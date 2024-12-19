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

--DECLARE @HoTen NVARCHAR(50) = 'John';
--DECLARE @NgaySinh DATE = '2000-01-01';
--DECLARE @GioiTinh NVARCHAR(10) = 'Nam';
--DECLARE @DiaChi NVARCHAR(50) = 'New York';
--DECLARE @Luong DECIMAL(10, 2) = 100000;
--DECLARE @NgayVaoLam DATE = '2021-01-01';
--DECLARE @MaBoPhan VARCHAR(10) = '43A725';
--DECLARE @MaChiNhanh VARCHAR(10) = '1V8TVJKJN5';
--DECLARE @Username VARCHAR(50) = 'test';
--DECLARE @Password VARCHAR(50) = '123';

--EXEC InsertNhanVien 
--    @HoTen = @HoTen,
--    @NgaySinh = @NgaySinh,
--    @GioiTinh = @GioiTinh,
--    @DiaChi = @DiaChi,
--    @Luong = @Luong,
--    @NgayVaoLam = @NgayVaoLam,
--    @MaBoPhan = @MaBoPhan,
--    @MaChiNhanh = @MaChiNhanh,
--    @Username = @Username,
--    @Password = @Password;


    select * from NhanVien where Username = 'test'

    delete from NhanVien
    where Username = 'EMPLOYEE_test'

    select * from NhanVien where Password != null

    select * from BoPhan_ChiNhanh

    select * from KhachHang where IDKhachHang = '1';
