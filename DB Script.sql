CREATE DATABASE CSDLNC
go

-- Tạo bảng Muc
CREATE TABLE Muc (
    IDMuc VARCHAR(5) PRIMARY KEY,
    TenMuc NVARCHAR(50) NOT NULL
);

-- Tạo bảng MonAn
CREATE TABLE MonAn (
    MaMon VARCHAR(5) PRIMARY KEY,
    TenMon NVARCHAR(50) NOT NULL,
    GiaHienTai DECIMAL(10, 2) NOT NULL,
    CoTheGiaoHang BIT NOT NULL,
    IDMuc VARCHAR(5) NOT NULL,
    FOREIGN KEY (IDMuc) REFERENCES Muc(IDMuc)  
);

-- Tạo bảng PhieuDatMon
CREATE TABLE PhieuDatMon (
    MaPhieu VARCHAR(5) PRIMARY KEY,
    NgayLap DATE NOT NULL,
    SoBan INT NOT NULL,
    IDNhanVien VARCHAR(5) NOT NULL,
    MaChiNhanh VARCHAR(5) NOT NULL,
);

-- Tạo bảng PhieuTrucTuyen
CREATE TABLE PhieuTrucTuyen (
    MaPhieu VARCHAR(5) PRIMARY KEY,
    SoKhach INT CHECK (SoKhach > 1),
    NgayDat DATE NOT NULL,
    GioDen TIME NOT NULL,
    GhiChu NVARCHAR(100),
    SDT VARCHAR(10) NOT NULL,
    FOREIGN KEY (MaPhieu) REFERENCES PhieuDatMon(MaPhieu)
);

-- Tạo bảng DanhGia
CREATE TABLE DanhGia (
    MaDanhGia VARCHAR(5) PRIMARY KEY,
    DiemPhucVu INT CHECK (DiemPhucVu BETWEEN 0 AND 10) NOT NULL,
    DiemViTri INT CHECK (DiemViTri BETWEEN 0 AND 10) NOT NULL,
    ChatLuongMon INT CHECK (ChatLuongMon BETWEEN 0 AND 10) NOT NULL,
    GiaCa INT CHECK (GiaCa BETWEEN 0 AND 10) NOT NULL,
    KhongGian INT CHECK (KhongGian BETWEEN 0 AND 10) NOT NULL,
    BinhLuan NVARCHAR(100),
    MaPhieu VARCHAR(5) NOT NULL,
    FOREIGN KEY (MaPhieu) REFERENCES PhieuDatMon(MaPhieu)
);

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon VARCHAR(5) PRIMARY KEY,
    NgayGioXuat DATETIME NOT NULL,
    TongTien DECIMAL(10, 2) NOT NULL,  
    Giam DECIMAL(10, 2),               
    MaPhieuDat VARCHAR(5),
    MaTheKhachHang VARCHAR(5),
    FOREIGN KEY (MaPhieuDat) REFERENCES PhieuDatMon(MaPhieu)
);
  --FOREIGN KEY (MaTheKhachHang) REFERENCES TheKhachHang(MaThe)

-- Tạo bảng ChiTietThucDon
CREATE TABLE ChiTietThucDon (
    MaChiNhanh VARCHAR(5),
    MaMonAn VARCHAR(5),
    MaKhuVuc VARCHAR(5),
    TinhTrang NVARCHAR(10) CHECK (TinhTrang IN ('Có', 'Không')) NOT NULL,
    PRIMARY KEY (MaChiNhanh, MaMonAn, MaKhuVuc),
    FOREIGN KEY (MaMonAn) REFERENCES MonAn(MaMon),
);
--FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh),
--FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc)

-- Tạo bảng ChiTietPhieuDat
CREATE TABLE ChiTietPhieuDat (
    MaMon VARCHAR(5),
    MaPhieu VARCHAR(5),
    SoLuong INT CHECK (SoLuong > 0) NOT NULL,
    DonGia DECIMAL(10, 2) NOT NULL,  
    PRIMARY KEY (MaMon, MaPhieu),
    FOREIGN KEY (MaMon) REFERENCES MonAn(MaMon),
    FOREIGN KEY (MaPhieu) REFERENCES PhieuDatMon(MaPhieu)
);

-- Tạo bảng KhuVuc
CREATE TABLE KhuVuc (
    MaKhuVuc VARCHAR(5) PRIMARY KEY,
    TenThanhPho NVARCHAR(50) NOT NULL
);

-- Tạo bảng BoPhan
CREATE TABLE BoPhan (
    MaBoPhan VARCHAR(5) PRIMARY KEY,
    TenBoPhan NVARCHAR(50) NOT NULL
);

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
    IDKhachHang VARCHAR(5) PRIMARY KEY,
    Username VARCHAR(50),
	Password VARCHAR(50)
);

-- Tạo bảng ChiNhanh
CREATE TABLE ChiNhanh (
    MaChiNhanh VARCHAR(5) PRIMARY KEY,
    TenChiNhanh NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    ThoiGianMo TIME NOT NULL,
    ThoiGianDong TIME NOT NULL,
    SDT VARCHAR(10) NOT NULL,
    Website VARCHAR(50) NOT NULL,
    BaiXeMay BIT NOT NULL,
    BaiXeHoi BIT NOT NULL,
    MaKhuVuc VARCHAR(5) NOT NULL,
    MaNVQL VARCHAR(5) NOT NULL,
    FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc),
);
--FOREIGN KEY (MaNVQL) REFERENCES NhanVien(IDNhanVien)

-- Tạo bảng BoPhan_ChiNhanh
CREATE TABLE BoPhan_ChiNhanh (
    MaBoPhan VARCHAR(5),
    MaChiNhanh VARCHAR(5),
    PRIMARY KEY (MaBoPhan, MaChiNhanh),  
    FOREIGN KEY (MaBoPhan) REFERENCES BoPhan(MaBoPhan),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    IDNhanVien VARCHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(3) CHECK (GioiTinh IN (N'Nam', N'Nữ')),
    DiaChi NVARCHAR(50) NOT NULL,
    Luong DECIMAL(10, 2) CHECK (Luong > 0) NOT NULL,
    NgayVaoLam DATE NOT NULL,
    NgayNghiViec DATE,
    MaBoPhan VARCHAR(5),
    MaChiNhanh VARCHAR(5),
    Username VARCHAR(50),
    Password VARCHAR(50),
    FOREIGN KEY (MaBoPhan) REFERENCES BoPhan(MaBoPhan),  
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh), 
);

-- Tạo bảng TheKhachHang
CREATE TABLE TheKhachHang (
    MaThe VARCHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    CCCD VARCHAR(12) NOT NULL,
    Email VARCHAR(50),
    GioiTinh VARCHAR(3) CHECK (GioiTinh IN ('Nam', 'Nữ')),
    LoaiThe VARCHAR(10) CHECK (LoaiThe IN ('Membership', 'Silver', 'Gold')) NOT NULL,
    NgayDat DATE NOT NULL,
    TongGiaTri INT CHECK (TongGiaTri > 0) NOT NULL,
    NgayLap DATE NOT NULL,
    TinhTrang VARCHAR(10) CHECK (TinhTrang IN ('Đang hoạt động', 'Đã hủy')),
    IDKhachHang VARCHAR(5),
    NhanVienLap VARCHAR(5) NOT NULL,
    FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(IDKhachHang),
    FOREIGN KEY (NhanVienLap) REFERENCES NhanVien(IDNhanVien)
);

-- Tạo bảng LichSuTruyCap
CREATE TABLE LichSuTruyCap (
    IDKhachHang VARCHAR(5),
    ThoiGianBatDau DATE,
    ThoiGianKetThuc DATE NOT NULL,
    PRIMARY KEY (IDKhachHang, ThoiGianBatDau),
    FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(IDKhachHang)
);

-- Tạo bảng LichSuLamViec
CREATE TABLE LichSuLamViec (
    IDNhanVien VARCHAR(5),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    MaChiNhanh VARCHAR(5) NOT NULL,
    PRIMARY KEY (IDNhanVien, NgayBatDau),
    FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(IDNhanVien),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

-- Tao rang buoc khoa ngoai

-- bang HoaDon
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_TheKhachHang FOREIGN KEY (MaTheKhachHang) REFERENCES TheKhachHang(MaThe)

-- bang ChiTietHoaDon
--ALTER TABLE ChiTietThucDon
--DROP CONSTRAINT FK_ChiTietThucDon_ChiNhanh
ALTER TABLE ChiTietThucDon ADD CONSTRAINT FK_ChiTietThucDon_ChiNhanh FOREIGN KEY (MaChiNhanh) REFERENCES  ChiNhanh(MaChiNhanh)
ALTER TABLE ChiTietThucDon ADD CONSTRAINT FK_ChiTietThucDon_NhanVien FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc)

-- bang ChiNhanh
ALTER TABLE ChiNhanh ADD CONSTRAINT FK_ChiNhanh_NhanVien FOREIGN KEY (MaNVQL) REFERENCES NhanVien(IDNhanVien)
