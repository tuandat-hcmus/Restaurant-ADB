-- Update MaNVQL
DECLARE @MaChiNhanh varchar(10), @MaNVQL varchar(10);

-- Lặp qua tất cả các chi nhánh
DECLARE chiNhanh_cursor CURSOR FOR
SELECT MaChiNhanh
FROM ChiNhanh;

OPEN chiNhanh_cursor;
FETCH NEXT FROM chiNhanh_cursor INTO @MaChiNhanh;

WHILE @@FETCH_STATUS = 0
BEGIN
   -- Chọn ngẫu nhiên một nhân viên thuộc chi nhánh
   SELECT TOP 1 @MaNVQL = IDNhanVien
   FROM NhanVien
   WHERE MaChiNhanh = @MaChiNhanh
   ORDER BY NEWID(); -- Sử dụng NEWID() để random

   -- Cập nhật MaNVQL cho chi nhánh
   UPDATE ChiNhanh
   SET MaNVQL = @MaNVQL
   WHERE MaChiNhanh = @MaChiNhanh;

   FETCH NEXT FROM chiNhanh_cursor INTO @MaChiNhanh;
END

-- Đóng và giải phóng cursor
CLOSE chiNhanh_cursor;
DEALLOCATE chiNhanh_cursor;











-- Fix IDNhanVien trong PhieuDatMon
DECLARE @MaChiNhanh VARCHAR(10), @IDNhanVien VARCHAR(10), @MaPhieu VARCHAR(10);

-- Con trỏ để lặp qua tất cả các dòng trong bảng PhieuDatMon
DECLARE db_cursor CURSOR FOR
SELECT MaPhieu, MaChiNhanh
FROM PhieuDatMon;

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @MaPhieu, @MaChiNhanh;

-- Lặp qua từng dòng trong bảng PhieuDatMon
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Lấy một IDNhanVien ngẫu nhiên từ bảng NhanVien có MaChiNhanh tương ứng
    SELECT TOP 1 @IDNhanVien = IDNhanVien
    FROM NhanVien
    WHERE MaChiNhanh = @MaChiNhanh
    ORDER BY NEWID();

    -- Cập nhật bảng PhieuDatMon với IDNhanVien tìm được
    UPDATE PhieuDatMon
    SET IDNhanVien = @IDNhanVien
    WHERE MaPhieu = @MaPhieu;

    FETCH NEXT FROM db_cursor INTO @MaPhieu, @MaChiNhanh;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;



-- Fix pass nvarchar(255)

ALTER TABLE NhanVien
ALTER COLUMN Password NVARCHAR(255);

ALTER TABLE KhachHang
ALTER COLUMN Password NVARCHAR(255);