-- Cập nhật hạng thẻ - Thực hiện mỗi tháng

--DROP PROCEDURE sp_CapNhatHangThe
GO
CREATE PROCEDURE sp_CapNhatHangThe
AS
BEGIN
    -- Cập nhật thẻ SILVER xuống Membership
    UPDATE TheKhachHang
    SET LoaiThe = 'Membership',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Silver'
      AND DATEDIFF(YEAR, NgayDat, GETDATE()) < 1
      AND TongGiaTri < 5000000; -- Tổng giá trị dưới 5.000.000 VNĐ

    -- Cập nhật thẻ SILVER lên GOLD
    UPDATE TheKhachHang
    SET LoaiThe = 'Gold',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Silver'
      AND DATEDIFF(YEAR, NgayDat, GETDATE()) < 1
      AND TongGiaTri >= 10000000; -- Tổng giá trị từ 10.000.000 VNĐ

    -- Cập nhật thẻ GOLD xuống SILVER nếu không đạt điều kiện giữ hạng
    UPDATE TheKhachHang
    SET LoaiThe = 'Silver',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Gold'
      AND DATEDIFF(YEAR, NgayDat, GETDATE()) < 1
      AND TongGiaTri < 10000000; -- Tổng giá trị dưới 10.000.000 VNĐ

    -- Cập nhật thẻ Membership lên SILVER
    UPDATE TheKhachHang
    SET LoaiThe = 'Silver',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Membership'
      AND TongGiaTri >= 10000000; -- Tổng giá trị từ 10.000.000 VNĐ
END;
GO



-- Tạo nhân viên
-- DROP PROCEDURE InsertNhanVien
CREATE PROCEDURE InsertNhanVien
    @HoTen NVARCHAR(50),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @DiaChi NVARCHAR(50),
    @Luong DECIMAL(10, 2),
    @NgayVaoLam DATE,
    @MaBoPhan VARCHAR(10),
    @MaChiNhanh VARCHAR(10),
    @Username VARCHAR(50),
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IDNhanVien VARCHAR(10) = LEFT(NEWID(), 10);

    IF EXISTS (SELECT 1 FROM NhanVien WHERE IDNhanVien = @IDNhanVien)
    BEGIN
        SET @IDNhanVien = LEFT(NEWID(), 10);
    END

    SET @Username = CONCAT('EMPLOYEE_', @Username);

    INSERT INTO NhanVien 
    VALUES (@IDNhanVien, @HoTen, @NgaySinh, @GioiTinh, @DiaChi, @Luong, @NgayVaoLam, NULL, @MaBoPhan, @MaChiNhanh, @Username, @Password);
END;
GO


-- Tạo khách hàng
CREATE PROCEDURE InsertKhachHang
    @Username VARCHAR(50),
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IDKhachHang VARCHAR(10) = LEFT(NEWID(), 10);

    IF EXISTS (SELECT 1 FROM NhanVien WHERE @IDKhachHang = @IDKhachHang)
    BEGIN
        SET @IDKhachHang = LEFT(NEWID(), 10);
    END

    INSERT INTO KhachHang 
    VALUES (@IDKhachHang, @Username, @Password);
END;
GO



-- Tạo phiếu đặt
-- DROP PROCEDURE InsertPhieuDatMon
CREATE PROCEDURE InsertPhieuDatMon
    @SoBan INT,
    @IDNhanVien VARCHAR(10),
    @MaChiNhanh VARCHAR(10)
AS
BEGIN
    DECLARE @MaPhieu VARCHAR(10) = LEFT(NEWID(), 10);
    DECLARE @NgayLap DATE = GETDATE();
    IF EXISTS (SELECT 1 FROM PhieuDatMon WHERE MaPhieu = @MaPhieu)
    BEGIN
        SET @MaPhieu = LEFT(NEWID(), 10);
    END

    INSERT INTO PhieuDatMon (MaPhieu, NgayLap, SoBan, IDNhanVien, MaChiNhanh)
    VALUES (@MaPhieu, @NgayLap, @SoBan, @IDNhanVien, @MaChiNhanh);
END;
GO

--exec InsertPhieuDatMon 5, '0012KH', 'YRJJQDHW'



-- Tính tổng doanh thu
-- DROP PROCEDURE TongDoanhThu
CREATE PROCEDURE TongDoanhThu
    @NgayBD DATE,           -- Ngày bắt đầu
    @NgayKT DATE,           -- Ngày kết thúc
    @LoaiTinh INT,          -- Kiểu tính (1: Ngày, 2: Tháng, 3: Quý, 4: Năm)
    @MaChiNhanh VARCHAR(10) -- Mã chi nhánh (có thể là NULL)
AS
BEGIN
    DECLARE @DoanhThu FLOAT;
    IF @LoaiTinh = 1  -- Tính theo Ngày
    BEGIN
        IF @MaChiNhanh IS NULL
        BEGIN
            SELECT 
                CONVERT(DATE, NgayGioXuat) AS Ngay,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
            GROUP BY CAST(NgayGioXuat AS DATE)
            ORDER BY CAST(NgayGioXuat AS DATE);
        END
        ELSE
        BEGIN
            SELECT 
                CONVERT(DATE, NgayGioXuat) AS Ngay,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
              AND MaChiNhanh = @MaChiNhanh
            GROUP BY CAST(NgayGioXuat AS DATE)
            ORDER BY CAST(NgayGioXuat AS DATE);
        END
    END
    ELSE IF @LoaiTinh = 2
    BEGIN
        IF @MaChiNhanh IS NULL
        BEGIN
            SELECT 
                CONCAT(YEAR(NgayGioXuat), '-', MONTH(NgayGioXuat)) AS Thang,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
            GROUP BY YEAR(NgayGioXuat), MONTH(NgayGioXuat)
            ORDER BY YEAR(NgayGioXuat), MONTH(NgayGioXuat);
        END
        ELSE
        BEGIN
            SELECT 
                CONCAT(YEAR(NgayGioXuat), '-', MONTH(NgayGioXuat)) AS Thang,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
              AND MaChiNhanh = @MaChiNhanh
            GROUP BY YEAR(NgayGioXuat), MONTH(NgayGioXuat)
            ORDER BY YEAR(NgayGioXuat), MONTH(NgayGioXuat);
        END
    END
    ELSE IF @LoaiTinh = 3
    BEGIN
        DECLARE @QuyBD INT = (MONTH(@NgayBD) - 1) / 3 + 1;
        DECLARE @QuyKT INT = (MONTH(@NgayKT) - 1) / 3 + 1;

        IF @MaChiNhanh IS NULL
        BEGIN
            SELECT 
                CONCAT(YEAR(NgayGioXuat), '-Q', ((MONTH(NgayGioXuat) - 1) / 3 + 1)) AS Quy,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
            GROUP BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1)
            ORDER BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1);
        END
        ELSE
        BEGIN
            SELECT 
                CONCAT(YEAR(NgayGioXuat), '-Q', ((MONTH(NgayGioXuat) - 1) / 3 + 1)) AS Quy,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
              AND MaChiNhanh = @MaChiNhanh
            GROUP BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1)
            ORDER BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1);
        END
    END
    ELSE IF @LoaiTinh = 4
    BEGIN
        IF @MaChiNhanh IS NULL
        BEGIN
            SELECT 
                YEAR(NgayGioXuat) AS Nam,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
            GROUP BY YEAR(NgayGioXuat)
            ORDER BY YEAR(NgayGioXuat);
        END
        ELSE
        BEGIN
            SELECT 
                YEAR(NgayGioXuat) AS Nam,
                SUM(TongTien) AS DoanhThu
            FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
            WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
              AND MaChiNhanh = @MaChiNhanh
            GROUP BY YEAR(NgayGioXuat)
            ORDER BY YEAR(NgayGioXuat);
        END
    END
END;
GO
EXEC TongDoanhThu
    @NgayBD = '2020-01-01', 
    @NgayKT = '2020-05-31', 
    @LoaiTinh = 2,           -- Tính theo ngày
    @MaChiNhanh = '667U9QB';
GO

-- Hóa đơn theo khách hàng theo ngày
-- DROP PROCEDURE getHoaDonKhachHang;
CREATE PROCEDURE getHoaDonKhachHang
    @MaTheKhachHang VARCHAR(10),
    @NgayBD DATE,
    @NgayKT DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        hd.MaHoaDon,
        hd.TongTien,
        pd.NgayLap,
        ctp.SoLuong, 
        ctp.DonGia,
        m.TenMon
    FROM 
        HoaDon AS hd
    JOIN 
        TheKhachHang AS tkh ON hd.MaTheKhachHang = tkh.MaThe
    JOIN 
        PhieuDatMon AS pd ON pd.MaPhieu = hd.MaPhieuDat
    JOIN 
        ChiTietPhieuDat AS ctp ON ctp.MaPhieu = pd.MaPhieu
    JOIN 
        MonAn AS m ON ctp.MaMon = m.MaMon
    WHERE 
        pd.NgayLap BETWEEN @NgayBD AND @NgayKT
        AND hd.MaTheKhachHang = @MaTheKhachHang
    ORDER BY hd.MaHoaDon, pd.NgayLap
END;
GO

-- EXEC getHoaDonKhachHang 'BPXF4DCG', '2020-02-16', '2020-02-16'