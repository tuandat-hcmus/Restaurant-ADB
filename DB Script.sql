USE MASTER
--DROP DATABASE RES_ADB
GO 
CREATE DATABASE RES_ADB
GO
USE RES_ADB
GO

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
    IDKhachHang VARCHAR(10) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
	Password nvarchar(255)
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    IDNhanVien VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(3) CHECK (GioiTinh IN (N'Nam', N'Nữ')),
    DiaChi NVARCHAR(50) NOT NULL,
    Luong DECIMAL(10, 2) CHECK (Luong > 0) NOT NULL,
    NgayVaoLam DATE NOT NULL,
    NgayNghiViec DATE,
    MaBoPhan VARCHAR(10) NOT NULL,
    MaChiNhanh VARCHAR(10) NOT NULL,
    Username VARCHAR(50) UNIQUE,
	Password nvarchar(255)
);

-- Tạo bảng LichSuTruyCap
CREATE TABLE LichSuTruyCap (
    IDKhachHang VARCHAR(10),
    ThoiGianBatDau DATE,
    ThoiGianKetThuc DATE NOT NULL,
	PRIMARY KEY (IDKhachHang, ThoiGianBatDau)
);

-- Tạo bảng LichSuLamViec
CREATE TABLE LichSuLamViec (
    IDNhanVien VARCHAR(10),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    MaChiNhanh VARCHAR(10) NOT NULL,
    PRIMARY KEY (IDNhanVien, NgayBatDau)
);

-- Tạo bảng TheKhachHang
CREATE TABLE TheKhachHang (
    MaThe VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    CCCD VARCHAR(12) NOT NULL,
    Email VARCHAR(50),
    GioiTinh NVARCHAR(3) CHECK (GioiTinh IN (N'Nam', N'Nữ')),
    LoaiThe VARCHAR(10) CHECK (LoaiThe IN ('Membership', 'Silver', 'Gold')) NOT NULL,
    NgayDat DATE NOT NULL,
    TongGiaTri INT CHECK (TongGiaTri > 0) NOT NULL,
    NgayLap DATE NOT NULL,
    TinhTrang NVARCHAR(20) CHECK (TinhTrang IN (N'Đang hoạt động', N'Đã hủy')),
    IDKhachHang VARCHAR(10),
    NhanVienLap VARCHAR(10) NOT NULL
);

-- Tạo bảng PhieuDatMon
CREATE TABLE PhieuDatMon (
    MaPhieu VARCHAR(10) PRIMARY KEY,
    NgayLap DATE NOT NULL,
    SoBan INT NOT NULL,
    IDNhanVien VARCHAR(10) NOT NULL,
    MaChiNhanh VARCHAR(10) NOT NULL
);

-- Tạo bảng PhieuTrucTuyen
CREATE TABLE PhieuTrucTuyen (
    MaPhieu VARCHAR(10) PRIMARY KEY,
    SoKhach INT CHECK (SoKhach >= 1),
    NgayDat DATE NOT NULL,
    GioDen TIME NOT NULL,
    GhiChu NVARCHAR(100),
    SDT VARCHAR(10) NOT NULL
);

-- Tạo bảng DanhGia
CREATE TABLE DanhGia (
    MaDanhGia VARCHAR(10) PRIMARY KEY,
    DiemPhucVu INT CHECK (DiemPhucVu BETWEEN 1 AND 10) NOT NULL,
    DiemViTri INT CHECK (DiemViTri BETWEEN 1 AND 10) NOT NULL,
    ChatLuongMon INT CHECK (ChatLuongMon BETWEEN 1 AND 10) NOT NULL,
    GiaCa INT CHECK (GiaCa BETWEEN 1 AND 10) NOT NULL,
    KhongGian INT CHECK (KhongGian BETWEEN 1 AND 10) NOT NULL,
    BinhLuan NVARCHAR(100),
    MaPhieu VARCHAR(10) NOT NULL
);

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon VARCHAR(10) PRIMARY KEY,
    NgayGioXuat DATETIME NOT NULL,
    TongTien DECIMAL(10, 2) NOT NULL,
    Giam DECIMAL(10, 2),
    MaPhieuDat VARCHAR(10),
    MaTheKhachHang VARCHAR(10)
);

-- Tạo bảng ChiNhanh
CREATE TABLE ChiNhanh (
    MaChiNhanh VARCHAR(10) PRIMARY KEY,
    TenChiNhanh NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    ThoiGianMo TIME NOT NULL,
    ThoiGianDong TIME NOT NULL,
    SDT VARCHAR(10) NOT NULL,
    Website VARCHAR(50) NOT NULL,
    BaiXeMay BIT NOT NULL,
    BaiXeHoi BIT NOT NULL,
    MaKhuVuc VARCHAR(10) NOT NULL,
    MaNVQL VARCHAR(10),
	CONSTRAINT CK_ThoiGianDong_ThoiGianMo
    CHECK (ThoiGianDong > ThoiGianMo)
);

-- Tạo bảng KhuVuc
CREATE TABLE KhuVuc (
    MaKhuVuc VARCHAR(10) PRIMARY KEY,
    TenThanhPho NVARCHAR(50) NOT NULL
);

-- Tạo bảng BoPhan_ChiNhanh
CREATE TABLE BoPhan_ChiNhanh (
    MaBoPhan VARCHAR(10),
    MaChiNhanh VARCHAR(10),
	PRIMARY KEY (MaBoPhan, MaChiNhanh)
);

-- Tạo bảng BoPhan
CREATE TABLE BoPhan (
    MaBoPhan VARCHAR(10) PRIMARY KEY,
    TenBoPhan NVARCHAR(50) NOT NULL
);

-- Tạo bảng ChiTietThucDon
CREATE TABLE ChiTietThucDon (
    MaChiNhanh VARCHAR(10),
    MaMonAn VARCHAR(10),
    MaKhuVuc VARCHAR(10),
    TinhTrang NVARCHAR(10) CHECK (TinhTrang IN (N'Có', N'Không')) NOT NULL,
	PRIMARY KEY (MaChiNhanh, MaMonAn, MaKhuVuc)
);

-- Tạo bảng MonAn
CREATE TABLE MonAn (
    MaMon VARCHAR(10) PRIMARY KEY,
    TenMon NVARCHAR(50) UNIQUE NOT NULL,
    GiaHienTai DECIMAL(10, 2) NOT NULL,
    CoTheGiaoHang BIT NOT NULL,
    IDMuc VARCHAR(10) NOT NULL
);

-- Tạo bảng Muc
CREATE TABLE Muc (
    IDMuc VARCHAR(10) PRIMARY KEY,
    TenMuc NVARCHAR(50) NOT NULL
);

-- Tạo bảng ChiTietPhieuDat
CREATE TABLE ChiTietPhieuDat (
    MaMon VARCHAR(10),
    MaPhieu VARCHAR(10),
    SoLuong INT CHECK (SoLuong > 0) NOT NULL,
    DonGia DECIMAL(10, 2) CHECK (DonGia > 0) NOT NULL,
    PRIMARY KEY (MaMon, MaPhieu)
);

ALTER TABLE NhanVien ADD CONSTRAINT PK_NV_BPCN FOREIGN KEY (MaBoPhan, MaChiNhanh) REFERENCES BoPhan_ChiNhanh(MaBoPhan, MaChiNhanh);

ALTER TABLE LichSuTruyCap ADD CONSTRAINT PK_LS_KH FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(IDKhachHang);

ALTER TABLE LichSuLamViec ADD CONSTRAINT PK_LS_NV FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(IDNhanVien);
ALTER TABLE LichSuLamViec ADD CONSTRAINT PK_LS_CN FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh);

ALTER TABLE TheKhachHang ADD CONSTRAINT PK_TKH_KH FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(IDKhachHang);
ALTER TABLE TheKhachHang ADD CONSTRAINT PK_TKH_NV FOREIGN KEY (NhanVienLap) REFERENCES NhanVien(IDNhanVien);

ALTER TABLE PhieuDatMon ADD CONSTRAINT PK_PDM_NV FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(IDNhanVien);
ALTER TABLE PhieuDatMon ADD CONSTRAINT PK_PDM_CN FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh);

ALTER TABLE PhieuTrucTuyen ADD CONSTRAINT PK_PTT_PDM FOREIGN KEY (MaPhieu) REFERENCES PhieuDatMon(MaPhieu);

ALTER TABLE DanhGia ADD CONSTRAINT PK_DG_PDM FOREIGN KEY (MaPhieu) REFERENCES PhieuDatMon(MaPhieu);

ALTER TABLE ChiNhanh ADD CONSTRAINT PK_CN_KV FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc);
ALTER TABLE ChiNhanh ADD CONSTRAINT PK_CN_NVQL FOREIGN KEY (MaNVQL) REFERENCES NhanVien(IDNhanVien);

ALTER TABLE BoPhan_ChiNhanh ADD CONSTRAINT PK_BPCN_BP FOREIGN KEY (MaBoPhan) REFERENCES BoPhan(MaBoPhan);
ALTER TABLE BoPhan_ChiNhanh ADD CONSTRAINT PK_BPCN_CN FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh);

ALTER TABLE ChiTietThucDon ADD CONSTRAINT PK_CTTD_CN FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh);
ALTER TABLE ChiTietThucDon ADD CONSTRAINT PK_CTTD_MA FOREIGN KEY (MaMonAn) REFERENCES MonAn(MaMon);
ALTER TABLE ChiTietThucDon ADD CONSTRAINT PK_CTTD_KV FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc);

ALTER TABLE MonAn ADD CONSTRAINT PK_MA_M FOREIGN KEY (IDMuc) REFERENCES Muc(IDMuc);

ALTER TABLE ChiTietPhieuDat ADD CONSTRAINT PK_CTPD_MA FOREIGN KEY (MaMon) REFERENCES MonAn(MaMon);
ALTER TABLE ChiTietPhieuDat ADD CONSTRAINT PK_CTPD_PDM FOREIGN KEY (MaPhieu) REFERENCES PhieuDatMon(MaPhieu);

ALTER TABLE HoaDon ADD CONSTRAINT PK_HD_TKH FOREIGN KEY (MaTheKhachHang) REFERENCES TheKhachHang(MaThe);
ALTER TABLE HoaDon ADD CONSTRAINT PK_HD_PDM FOREIGN KEY (MaPhieuDat) REFERENCES PhieuDatMon(MaPhieu);