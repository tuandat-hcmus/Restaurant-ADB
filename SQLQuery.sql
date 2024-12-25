-- 1. Tính doanh thu --Partition HoaDon theo quý / năm
-- Tính doanh thu theo ngày
DECLARE @NgayBD DATE = '2020-01-01';
DECLARE @NgayKT DATE = '2020-10-01';

SELECT 
    CONVERT(DATE, NgayGioXuat) AS Ngay,
    SUM(TongTien) AS DoanhThu
FROM HoaDon
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
GROUP BY CONVERT(DATE, NgayGioXuat)
ORDER BY CONVERT(DATE, NgayGioXuat);


--Tính doanh thu theo tháng
DECLARE @NgayBD DATE = '2020-01-01';
DECLARE @NgayKT DATE = '2023-01-01';
SELECT 
    CONCAT(YEAR(NgayGioXuat), '-', MONTH(NgayGioXuat)) AS Thang,
    SUM(TongTien) AS DoanhThu
FROM HoaDon
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
GROUP BY YEAR(NgayGioXuat), MONTH(NgayGioXuat)
ORDER BY YEAR(NgayGioXuat), MONTH(NgayGioXuat);


--Tính doanh thu theo quý
SELECT 
    CONCAT(YEAR(NgayGioXuat), '-Q', ((MONTH(NgayGioXuat) - 1) / 3 + 1)) AS Quy,
    SUM(TongTien) AS DoanhThu
FROM HoaDon
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
GROUP BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1)
ORDER BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1);


--Tính doanh thu theo năm
SELECT 
    YEAR(NgayGioXuat) AS Nam,
    SUM(TongTien) AS DoanhThu
FROM HoaDon
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
GROUP BY YEAR(NgayGioXuat)
ORDER BY YEAR(NgayGioXuat);

--2. Xem danh sách nhân viên, điểm phục vụ của mỗi nhân viên
-- Theo ngày
DECLARE @NgayXuat DATE = '2021-07-24';
DECLARE @MaChiNhanh VARCHAR(10) = 'YRJJQDHW';

SELECT nv.IDNhanVien, nv.HoTen, AVG(DiemPhucVu) AS DiemPhucVu
FROM PhieuDatMon pd JOIN DanhGia dg ON dg.MaPhieu = pd.MaPhieu JOIN NhanVien nv ON pd.IDNhanVien = nv.IDNhanVien
WHERE pd.NgayLap = @NgayXuat AND pd.MaChiNhanh = @MaChiNhanh
GROUP BY nv.IDNhanVien, nv.HoTen;

-- Theo tháng
DECLARE @Thang INT = 4;
DECLARE @Nam INT = 2020;
DECLARE @MaChiNhanh VARCHAR(10) = '359O0QG7';

SELECT nv.IDNhanVien, nv.HoTen, AVG(DiemPhucVu) AS DiemPhucVu
FROM PhieuDatMon pd JOIN DanhGia dg ON dg.MaPhieu = pd.MaPhieu JOIN NhanVien nv ON pd.IDNhanVien = nv.IDNhanVien
WHERE MONTH(pd.NgayLap) = @Thang AND YEAR(pd.NgayLap) = @Nam AND pd.MaChiNhanh = @MaChiNhanh
GROUP BY nv.IDNhanVien, nv.HoTen;

-- Theo quý
DECLARE @Quy INT = 2;
DECLARE @Nam INT = 2020;
DECLARE @MaChiNhanh VARCHAR(10) = '3YBNWW';

SELECT nv.IDNhanVien, nv.HoTen, AVG(DiemPhucVu) AS DiemPhucVu
FROM PhieuDatMon pd JOIN DanhGia dg ON dg.MaPhieu = pd.MaPhieu JOIN NhanVien nv ON pd.IDNhanVien = nv.IDNhanVien
WHERE DATEPART(QUARTER, pd.NgayLap) = @Quy AND YEAR(pd.NgayLap) = @Nam AND pd.MaChiNhanh = @MaChiNhanh
GROUP BY nv.IDNhanVien, nv.HoTen;

-- Theo năm
DECLARE @Nam INT = 2020;
DECLARE @MaChiNhanh VARCHAR(10) = '3YBNWW';

SELECT nv.IDNhanVien, nv.HoTen, AVG(DiemPhucVu) AS DiemPhucVu
FROM PhieuDatMon pd JOIN DanhGia dg ON dg.MaPhieu = pd.MaPhieu JOIN NhanVien nv ON pd.IDNhanVien = nv.IDNhanVien
WHERE YEAR(pd.NgayLap) = @Nam AND pd.MaChiNhanh = @MaChiNhanh
GROUP BY nv.IDNhanVien, nv.HoTen;


--3. Tìm nhân viên theo chi nhánh
-- Tất cả
DECLARE @MaChiNhanh VARCHAR(10) = '152OC76L7';

SELECT nv.IDNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.DiaChi, nv.NgayVaoLam, nv.NgayNghiViec, nv.MaBoPhan
FROM NhanVien nv
WHERE nv.MaChiNhanh = @MaChiNhanh;

-- Họ tên
DECLARE @MaChiNhanh VARCHAR(10) = '152OC76L7';
DECLARE @HoTen NVARCHAR(50) = 'Sylvia';

SET @HoTen = '%' + @HoTen + '%';

SELECT nv.IDNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.DiaChi, nv.NgayVaoLam, nv.NgayNghiViec, nv.MaBoPhan
FROM NhanVien nv 
WHERE nv.MaChiNhanh = @MaChiNhanh AND nv.HoTen LIKE @HoTen;


--4. Thêm, xóa, cập nhật phiếu đặt món
-- Thêm
DECLARE @MaPhieu VARCHAR(10);
DECLARE @NgayLap DATE = GETDATE();
DECLARE @SoBan INT;
DECLARE @IDNhanVien VARCHAR(10);
DECLARE @MaChiNhanh VARCHAR(10);
DECLARE @MaMon VARCHAR(10);
DECLARE @SoLuong INT;
DECLARE @DonGia DECIMAL(10, 2);

INSERT INTO PhieuDatMon VALUES (@MaPhieu, @NgayLap, @SoBan, @IDNhanVien, @MaChiNhanh)
INSERT INTO ChiTietPhieuDat VALUES (@MaMon, @MaPhieu, @SoLuong, @DonGia)

-- Xóa
DECLARE @MaPhieu VARCHAR(10);

DELETE FROM PhieuDatMon
WHERE MaPhieu = @MaPhieu

DELETE FROM ChiTietPhieuDat
WHERE MaPhieu = @MaPhieu

-- Cập nhật
DECLARE @MaPhieu VARCHAR(10);
DECLARE @NgayLap DATE = GETDATE();
DECLARE @SoBan INT;
DECLARE @IDNhanVien VARCHAR(10);
DECLARE @MaChiNhanh VARCHAR(10);

UPDATE PhieuDatMon
SET NgayLap = @NgayLap, SoBan = @SoBan, IDNhanVien = @IDNhanVien, MaChiNhanh = @MaChiNhanh
WHERE MaPhieu = @MaPhieu

UPDATE ChiTietPhieuDat
SET MaMon = @MaMonMoi, SoLuong = @SoLuong
WHERE MaPhieu = @MaPhieu AND MaMon = @MaMon

--5. Tìm kiếm hóa đơn theo khách hàng
DECLARE @MaTheKhachHang VARCHAR(10) = 'BPXF4DCG';
DECLARE @NgayBD DATE = '2020-01-01';
DECLARE @NgayKT DATE = '2020-03-01';

SELECT 
    hd.TongTien,
    pd.NgayLap,
    ctp.SoLuong, ctp.DonGia,
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
    hd.NgayGioXuat >= @NgayBD AND hd.NgayGioXuat < @NgayKT
    AND hd.MaTheKhachHang = @MaTheKhachHang;


--6. Thêm, xóa, cập nhật thẻ khách hàng
-- Thêm 
DECLARE @MaThe VARCHAR(10);
DECLARE @HoTen NVARCHAR(50);
DECLARE @CCCD VARCHAR(12);
DECLARE @Email VARCHAR(50);
DECLARE @GioiTinh NVARCHAR(10);
DECLARE @LoaiThe VARCHAR(10) = 'Membership';
DECLARE @NgayDat DATE = GETDATE();
DECLARE @TongGiaTri INT = 0;
DECLARE @NgayLap DATE = GETDATE();
DECLARE @TinhTrang NVARCHAR(20) = N'Đang hoạt động';
DECLARE @IDKhachHang VARCHAR(10);
DECLARE @NhanVienLap VARCHAR(10);

INSERT INTO TheKhachHang VALUES (@MaThe, @HoTen, @CCCD, @Email, @GioiTinh, @LoaiThe, @NgayDat, @TongGiaTri, @NgayLap, @TinhTrang, @IDKhachHang, @NhanVienLap);

-- Xóa
DECLARE @MaThe VARCHAR(10);

UPDATE TheKhachHang
SET TinhTrang = N'Đã hủy'
WHERE MaThe = @MaThe

-- Cập nhật
DECLARE @MaThe VARCHAR(10);
DECLARE @HoTen NVARCHAR(50);
DECLARE @CCCD VARCHAR(12);
DECLARE @Email VARCHAR(50);
DECLARE @GioiTinh NVARCHAR(10);
DECLARE @LoaiThe VARCHAR(10);
DECLARE @NgayDat DATE;
DECLARE @TongGiaTri INT;

UPDATE TheKhachHang
SET HoTen = @HoTen, CCCD = @CCCD, Email = @Email, GioiTinh = @GioiTinh, LoaiThe = @LoaiThe, NgayDat = @NgayDat, TongGiaTri = TongGiaTri
WHERE MaThe = @MaThe



-- 7. Tính doanh thu theo chi nhanh
-- Tính doanh thu theo ngày
DECLARE @NgayBD DATE;
DECLARE @NgayKT DATE;
DECLARE @MaChiNhanh VARCHAR(10) = '152OC76L7'

SELECT 
    CONVERT(DATE, NgayGioXuat) AS Ngay,
    SUM(TongTien) AS DoanhThu
FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
    AND MaChiNhanh = @MaChiNhanh
GROUP BY CONVERT(DATE, NgayGioXuat)
ORDER BY CONVERT(DATE, NgayGioXuat);


--Tính doanh thu theo tháng
DECLARE @NgayBD DATE;
DECLARE @NgayKT DATE;
DECLARE @MaChiNhanh VARCHAR(10) = '152OC76L7'

SELECT 
    CONCAT(YEAR(NgayGioXuat), '-', MONTH(NgayGioXuat)) AS Thang,
    SUM(TongTien) AS DoanhThu
FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
    AND MaChiNhanh = @MaChiNhanh
GROUP BY YEAR(NgayGioXuat), MONTH(NgayGioXuat)
ORDER BY YEAR(NgayGioXuat), MONTH(NgayGioXuat);


--Tính doanh thu theo quý
DECLARE @NgayBD DATE;
DECLARE @NgayKT DATE;
DECLARE @MaChiNhanh VARCHAR(10) = '152OC76L7'

SELECT 
    CONCAT(YEAR(NgayGioXuat), '-Q', ((MONTH(NgayGioXuat) - 1) / 3 + 1)) AS Quy,
    SUM(TongTien) AS DoanhThu
FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
    AND MaChiNhanh = @MaChiNhanh
GROUP BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1)
ORDER BY YEAR(NgayGioXuat), ((MONTH(NgayGioXuat) - 1) / 3 + 1);


--Tính doanh thu theo năm
DECLARE @NgayBD DATE = '2020-01-01';
DECLARE @NgayKT DATE = '2022-01-05';
DECLARE @MaChiNhanh VARCHAR(10) = '152OC76L7';

SELECT 
    YEAR(NgayGioXuat) AS Nam,
    SUM(TongTien) AS DoanhThu
FROM HoaDon JOIN PhieuDatMon ON PhieuDatMon.MaPhieu = HoaDon.MaPhieuDat
WHERE NgayGioXuat BETWEEN @NgayBD AND @NgayKT
    AND MaChiNhanh = @MaChiNhanh
GROUP BY YEAR(NgayGioXuat)
ORDER BY YEAR(NgayGioXuat);

--8. Thống kê doanh thu theo từng món
DECLARE @NgayBD DATE = '2021-02-03';
DECLARE @NgayKT DATE = '2022-02-03';

WITH BestSellingCTE AS (
    SELECT 
        M.MaMon,
        M.TenMon,
        CN.MaChiNhanh,
        KV.TenThanhPho AS Region,
        SUM(CT.SoLuong) AS TotalQuantitySold
    FROM 
        ChiTietPhieuDat CT
    JOIN 
        MonAn M ON CT.MaMon = M.MaMon
    JOIN 
        PhieuDatMon PD ON CT.MaPhieu = PD.MaPhieu
    JOIN 
        HoaDon H ON H.MaPhieuDat = PD.MaPhieu
    JOIN 
        ChiNhanh CN ON PD.MaChiNhanh = CN.MaChiNhanh
    JOIN 
        KhuVuc KV ON CN.MaKhuVuc = KV.MaKhuVuc
    WHERE 
        H.NgayGioXuat BETWEEN @NgayBD AND @NgayKT
    GROUP BY 
        M.MaMon, M.TenMon, CN.MaChiNhanh, KV.TenThanhPho
),
RankedProducts AS (
    SELECT
        TenMon,
        MaChiNhanh,
        Region,
        TotalQuantitySold,
        ROW_NUMBER() OVER (ORDER BY TotalQuantitySold DESC) AS BestRank,
        ROW_NUMBER() OVER (ORDER BY TotalQuantitySold ASC) AS LowestRank
    FROM 
        BestSellingCTE
)
 
-- Final Results: Best-Selling and Lowest-Selling Products
SELECT 
    'Best-Selling Dish' AS Metric,
    TenMon, 
    MaChiNhanh, 
    Region, 
    TotalQuantitySold
FROM 
    RankedProducts
WHERE 
    BestRank = 1
 
UNION ALL
 
SELECT 
    'Lowest-Selling Dish' AS Metric,
    TenMon, 
    MaChiNhanh, 
    Region, 
    TotalQuantitySold
FROM 
    RankedProducts
WHERE 
    LowestRank = 1;



--9. Chuyển nhân sự giữa các chi nhánh
DECLARE @IDNhanVien VARCHAR(10);
DECLARE @MaChiNhanh VARCHAR(10);
DECLARE @MaBoPhan VARCHAR(10);


UPDATE LichSuLamViec
SET NgayKetThuc = GETDATE()
WHERE IDNhanVien = @IDNhanVien;

INSERT INTO LichSuLamViec VALUES (@IDNhanVien, GETDATE(), NULL, @MaChiNhanh);

UPDATE NhanVien
SET MaChiNhanh = @MaChiNhanh, MaBoPhan = @MaBoPhan
WHERE IDNhanVien = @IDNhanVien

--10. Thêm, xóa sửa nhân viên
--Thêm
DECLARE @IDNhanVien VARCHAR(10);
DECLARE @HoTen NVARCHAR(50);
DECLARE @NgaySinh DATE;
DECLARE @DiaChi NVARCHAR(50);
DECLARE @Luong DECIMAL(10, 2);
DECLARE @NgayVaoLam DATE;
DECLARE @NgayNghiViec DATE;
DECLARE @MaBoPhan VARCHAR(10);
DECLARE @MaChiNhanh VARCHAR(10);
DECLARE @Username VARCHAR(50);

INSERT INTO NhanVien VALUES (@IDNhanVien, @HoTen, @NgaySinh, @DiaChi, @Luong, @NgayVaoLam, NULL, @MaBoPhan, @MaChiNhanh, @Username, '123');

--Xóa 
DECLARE @IDNhanVien VARCHAR(10);

DELETE FROM NhanVien
WHERE IDNhanVien = @IDNhanVien

-- Cập nhật
DECLARE @IDNhanVien VARCHAR(10);
DECLARE @HoTen NVARCHAR(50);
DECLARE @NgaySinh DATE;
DECLARE @DiaChi NVARCHAR(50);
DECLARE @Luong DECIMAL(10, 2);
DECLARE @NgayNghiViec DATE;
DECLARE @MaBoPhan VARCHAR(10);
DECLARE @MaChiNhanh VARCHAR(10);
DECLARE @Username VARCHAR(50);
DECLARE @Password VARCHAR(50);


UPDATE NhanVien
SET HoTen = @HoTen, NgaySinh = @NgaySinh, DiaChi = @DiaChi, Luong = @Luong, NgayNghiViec = @NgayNghiViec, MaBoPhan = @MaBoPhan, MaChiNhanh = @MaChiNhanh, Username = @Username, Password = @Password
WHERE IDNhanVien = @IDNhanVien
