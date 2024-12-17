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