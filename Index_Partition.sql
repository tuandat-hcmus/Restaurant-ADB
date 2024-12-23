-- Index

USE RES_ADB
GO

CREATE NONCLUSTERED INDEX IX_PhieuDatMon_IDNhanVien
ON PhieuDatMon (IDNhanVien);
GO

CREATE NONCLUSTERED INDEX IX_DanhGia_MaPhieu
ON DanhGia (MaPhieu);
GO

-- Partition
ALTER DATABASE RES_ADB ADD FILEGROUP HD2020;
ALTER DATABASE RES_ADB ADD FILEGROUP HD2021;
ALTER DATABASE RES_ADB ADD FILEGROUP HD2022;
ALTER DATABASE RES_ADB ADD FILEGROUP HD2023;

ALTER DATABASE RES_ADB
ADD FILE(NAME = 'HD2020', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\P1.mdf', SIZE = 2, MAXSIZE = 100, FILEGROWTH = 2) TO FILEGROUP HD2020;
ALTER DATABASE RES_ADB
ADD FILE(NAME = 'HD2021', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\P2.mdf', SIZE = 2, MAXSIZE = 100, FILEGROWTH = 2) TO FILEGROUP HD2021;
ALTER DATABASE RES_ADB
ADD FILE(NAME = 'HD2022', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\P3.mdf', SIZE = 2, MAXSIZE = 100, FILEGROWTH = 2) TO FILEGROUP HD2022;
ALTER DATABASE RES_ADB
ADD FILE(NAME = 'HD2023', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\P4.mdf', SIZE = 2, MAXSIZE = 100, FILEGROWTH = 2) TO FILEGROUP HD2023;

CREATE PARTITION FUNCTION NgayXuatPartition(datetime)
AS RANGE LEFT FOR VALUES('2021-01-01 00:00:00', '2022-01-01 00:00:00', '2023-01-01 00:00:00', '2024-01-01 00:00:00');

CREATE PARTITION SCHEME NgayXuatPartitionScheme
AS PARTITION NgayXuatPartition TO (HD2020, HD2021, HD2022, HD2023, [PRIMARY]);

GO
ALTER TABLE HoaDon DROP CONSTRAINT PK__HoaDon__835ED13B8A9DEE0B
ALTER TABLE HoaDon DROP CONSTRAINT PK_HD_PDM
ALTER TABLE HoaDon DROP CONSTRAINT PK_HD_TKH

CREATE CLUSTERED INDEX idx ON HoaDon (NgayGioXuat) on NgayXuatPartitionScheme(NgayGioXuat)
CREATE NONCLUSTERED INDEX IX_HoaDon_MaPhieuDat ON HoaDon (MaPhieuDat)
CREATE NONCLUSTERED INDEX IX_HoaDon_MaTheKhachHang ON HoaDon (MaTheKhachHang)

--SELECT 
--	p.partition_number AS partition_number,
--	f.name AS file_group, 
--	p.rows AS row_count
--FROM sys.partitions p
--JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
--JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
--WHERE OBJECT_NAME(OBJECT_ID) = 'HoaDon'
--order by partition_number;

--select count(*) from hoadon where year(ngaygioxuat) = '2020'
--select count(*) from hoadon where year(ngaygioxuat) = '2021'
--select count(*) from hoadon where year(ngaygioxuat) = '2022'
--select count(*) from hoadon where year(ngaygioxuat) = '2023'
--select count(*) from hoadon where year(ngaygioxuat) = '2024'