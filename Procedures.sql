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



-- 2.1 
