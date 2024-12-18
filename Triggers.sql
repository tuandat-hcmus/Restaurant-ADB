--1. Giờ đến > giờ hiện tại trong phiếu trực tuyến
GO
IF OBJECT_ID('TRG_Check_GioDen', 'TR') IS NOT NULL
    DROP TRIGGER TRG_Check_GioDen;
GO
CREATE TRIGGER TRG_Check_GioDen
ON PhieuTrucTuyen
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE GioDen <= CONVERT(TIME, GETDATE())
    )
    BEGIN
        RAISERROR ('Giờ đến phải lớn hơn giờ hiện tại.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO PhieuTrucTuyen (MaPhieu, SoKhach, NgayDat, GioDen, GhiChu, SDT)
        SELECT MaPhieu, SoKhach, NgayDat, GioDen, GhiChu, SDT
        FROM inserted;
    END
END;

-- 2. Mỗi nhân viên làm việc tại 1 chi nhánh tại một thời điểm cụ thể
GO
IF OBJECT_ID('TRG_Check_LichSuLamViec', 'TR') IS NOT NULL
    DROP TRIGGER TRG_Check_LichSuLamViec;
GO
CREATE TRIGGER TRG_Check_LichSuLamViec
ON LichSuLamViec
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        JOIN LichSuLamViec AS l
        ON i.IDNhanVien = l.IDNhanVien
           AND i.MaChiNhanh <> l.MaChiNhanh
           AND (
               (i.NgayBatDau BETWEEN l.NgayBatDau AND ISNULL(l.NgayKetThuc, '9999-12-31'))
               OR
               (ISNULL(i.NgayKetThuc, '9999-12-31') BETWEEN l.NgayBatDau AND ISNULL(l.NgayKetThuc, '9999-12-31'))
               OR
               (l.NgayBatDau BETWEEN i.NgayBatDau AND ISNULL(i.NgayKetThuc, '9999-12-31'))
           )
    )
    BEGIN
        RAISERROR ('Một nhân viên không thể làm việc tại nhiều chi nhánh trong cùng một thời gian.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO LichSuLamViec (IDNhanVien, NgayBatDau, NgayKetThuc, MaChiNhanh)
        SELECT IDNhanVien, NgayBatDau, NgayKetThuc, MaChiNhanh
        FROM inserted;
    END
END;

-- 3. Ngày sinh của nhân viên < hiện tại 15 năm
GO
IF OBJECT_ID('TRG_Check_Tuoi', 'TR') IS NOT NULL
    DROP TRIGGER TRG_Check_Tuoi;
GO
CREATE TRIGGER TRG_Check_Tuoi
ON NhanVien
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DATEDIFF(YEAR, NgaySinh, GETDATE()) < 15
    )
    BEGIN
        RAISERROR ('Ngày sinh nhân viên phải đủ 15 tuổi.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Chèn dữ liệu vào bảng NhanVien
        INSERT INTO NhanVien (IDNhanVien, HoTen, NgaySinh, GioiTinh, DiaChi, Luong, NgayVaoLam, NgayNghiViec, MaBoPhan, MaChiNhanh, Username, Password)
        SELECT IDNhanVien, HoTen, NgaySinh, GioiTinh, DiaChi, Luong, NgayVaoLam, NgayNghiViec, MaBoPhan, MaChiNhanh, Username, Password
        FROM inserted;
    END
END;

--4. Nhân viên quản lí chi nhánh phải thuộc chi nhánh đó
GO
IF OBJECT_ID('TRG_Check_NVQL', 'TR') IS NOT NULL
    DROP TRIGGER TRG_Check_NVQL;
GO
CREATE TRIGGER TRG_Check_NVQL
ON ChiNhanh
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN NhanVien nv
        ON i.MaNVQL = nv.IDNhanVien AND i.MaChiNhanh = nv.MaChiNhanh
        WHERE i.MaNVQL IS NOT NULL AND nv.IDNhanVien IS NULL
    )
    BEGIN
        RAISERROR ('Nhân viên quản lý phải thuộc chi nhánh.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--5. Tổng tiền trong hóa đơn phải bằng số lượng * đơn giá trong phiếu đặt món, cập nhật giảm giá khi thêm thẻ
GO
IF OBJECT_ID('trg_HoaDon_Insert', 'TR') IS NOT NULL
    DROP TRIGGER trg_HoaDon_Insert;
GO
CREATE TRIGGER trg_HoaDon_Insert
ON HoaDon
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    --  Kiểm tra và cập nhật TongTien từ ChiTietPhieuDat
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN (
            SELECT MaPhieu, SUM(SoLuong * DonGia) AS TongTienTam
            FROM ChiTietPhieuDat
            GROUP BY MaPhieu
        ) ct ON i.MaPhieuDat = ct.MaPhieu
        WHERE ISNULL(ct.TongTienTam, 0) = 0
    )
    BEGIN
        RAISERROR('TongTien bằng 0.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    UPDATE hd
    SET TongTien = ISNULL(
        (
            SELECT SUM(ct.SoLuong * ct.DonGia)
            FROM ChiTietPhieuDat ct
            WHERE ct.MaPhieu = i.MaPhieuDat
        ), 0
    )
    FROM HoaDon hd
    INNER JOIN inserted i ON hd.MaHoaDon = i.MaHoaDon;

    --  Cập nhật giảm giá (Giam) dựa trên LoaiThe
    UPDATE hd
    SET hd.Giam = 
        CASE 
            WHEN tk.LoaiThe = 'Membership' THEN hd.TongTien * 0.02
            WHEN tk.LoaiThe = 'Silver' THEN hd.TongTien * 0.05
            WHEN tk.LoaiThe = 'Gold' THEN hd.TongTien * 0.07
            ELSE 0
        END
    FROM HoaDon hd
    INNER JOIN inserted i ON hd.MaHoaDon = i.MaHoaDon
    LEFT JOIN TheKhachHang tk ON i.MaTheKhachHang = tk.MaThe;

    -- Nếu thẻ khách hàng tồn tại, cộng thêm giá trị vào TongGiaTri trong TheKhachHang
    UPDATE tk
    SET TongGiaTri = ISNULL(tk.TongGiaTri, 0) + (hd.TongTien / 1000)
    FROM TheKhachHang tk
    INNER JOIN inserted i ON tk.MaThe = i.MaTheKhachHang
    INNER JOIN HoaDon hd ON i.MaHoaDon = hd.MaHoaDon;
END;

--6. Phiếu đặt món ở một chi nhánh chỉ được tạo bởi nhân viên thuộc cùng chi nhánh
GO
IF OBJECT_ID('TRG_Check_NVPhieuDatMon', 'TR') IS NOT NULL
    DROP TRIGGER TRG_Check_NVPhieuDatMon;
GO
CREATE TRIGGER TRG_Check_NVPhieuDatMon
ON PhieuDatMon
FOR INSERT
AS
BEGIN
    DECLARE @MaChiNhanh VARCHAR(10);
    SELECT @MaChiNhanh = MaChiNhanh FROM INSERTED;
    IF NOT EXISTS (
        SELECT 1
        FROM NhanVien nv
        JOIN INSERTED i ON nv.MaChiNhanh = i.MaChiNhanh
        WHERE nv.IDNhanVien = i.IDNhanVien
    )
    BEGIN
        RAISERROR('Nhân viên phải thuộc đúng chi nhánh.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

