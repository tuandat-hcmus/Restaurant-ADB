package com.example.BackEnd.repository;

import com.example.BackEnd.DTO.DiemNhanVienDTO;
import com.example.BackEnd.DTO.NhanVienDTO;
import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.NhanVien;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public interface NhanVienRepo extends JpaRepository<NhanVien, String> {
    
    @Query("SELECT new com.example.BackEnd.model.Account(nv.iDNhanVien, nv.username, nv.password, '') FROM NhanVien nv WHERE nv.username = :username ")
    Account findAccountByUsername(String username);

    @Modifying
    @Transactional
    @Query(value = "EXEC InsertNhanVien :hoTen, :ngaySinh, :gioiTinh, :diaChi, :luong, :ngayVaoLam, :maBoPhan, :maChiNhanh, :username, :password", nativeQuery = true)
    int insertNhanVien(
        @Param("hoTen") String hoTen,
        @Param("ngaySinh") LocalDate ngaySinh,
        @Param("gioiTinh") String gioiTinh,
        @Param("diaChi") String diaChi,
        @Param("luong") BigDecimal luong,
        @Param("ngayVaoLam") LocalDate ngayVaoLam,
        @Param("maBoPhan") String maBoPhan,
        @Param("maChiNhanh") String maChiNhanh,
        @Param("username") String username,
        @Param("password") String password
    );
    
    
    @Query("SELECT new com.example.BackEnd.DTO.DiemNhanVienDTO(nv.iDNhanVien, nv.hoTen, AVG(dg.diemPhucVu)) " +
        "FROM PhieuDatMon pd JOIN DanhGia dg ON dg.maPhieu = pd.maPhieu JOIN NhanVien nv ON pd.iDNhanVien = nv.iDNhanVien " +
        "WHERE pd.ngayLap = :ngayXuat AND pd.maChiNhanh = :maChiNhanh " +
        "GROUP BY nv.iDNhanVien, nv.hoTen")
    List<DiemNhanVienDTO> getDiemNhanVienDTO(@Param("ngayXuat") LocalDate ngayXuat, @Param("maChiNhanh") String maChiNhanh);


    @Query("SELECT new com.example.BackEnd.DTO.DiemNhanVienDTO(nv.iDNhanVien, nv.hoTen, AVG(dg.diemPhucVu)) " +
        "FROM PhieuDatMon pd JOIN DanhGia dg ON dg.maPhieu = pd.maPhieu JOIN NhanVien nv ON pd.iDNhanVien = nv.iDNhanVien " +
        "WHERE MONTH(pd.ngayLap) = :thang AND YEAR(pd.ngayLap) = :nam AND pd.maChiNhanh = :maChiNhanh " +
        "GROUP BY nv.iDNhanVien, nv.hoTen")
    List<DiemNhanVienDTO> getDiemNhanVienThang(String thang, String nam, String maChiNhanh);

    @Query(value = "SELECT nv.iDNhanVien, nv.hoTen, AVG(dg.diemPhucVu) " +
        "FROM PhieuDatMon pd JOIN DanhGia dg ON dg.maPhieu = pd.maPhieu JOIN NhanVien nv ON pd.iDNhanVien = nv.iDNhanVien " +
        "WHERE DATEPART(QUARTER, pd.ngayLap) = :quy AND YEAR(pd.ngayLap) = :nam AND pd.maChiNhanh = :maChiNhanh " +
        "GROUP BY nv.iDNhanVien, nv.hoTen", nativeQuery = true)
    List<Object[]> getDiemNhanVienQuy(String quy, String nam, String maChiNhanh);

    @Query("SELECT new com.example.BackEnd.DTO.DiemNhanVienDTO(nv.iDNhanVien, nv.hoTen, AVG(dg.diemPhucVu)) " +
        "FROM PhieuDatMon pd JOIN DanhGia dg ON dg.maPhieu = pd.maPhieu JOIN NhanVien nv ON pd.iDNhanVien = nv.iDNhanVien " +
        "WHERE YEAR(pd.ngayLap) = :nam AND pd.maChiNhanh = :maChiNhanh " +
        "GROUP BY nv.iDNhanVien, nv.hoTen")
    List<DiemNhanVienDTO> getDiemNhanVienNam(String nam, String maChiNhanh);
    
    
    List<NhanVienDTO> findNhanVienByMaChiNhanh(String maChiNhanh);
    
    
    @Query("SELECT new com.example.BackEnd.DTO.NhanVienDTO(nv.iDNhanVien, nv.hoTen, nv.ngaySinh, nv.gioiTinh, nv.diaChi, nv.ngayVaoLam, nv.ngayNghiViec, nv.maBoPhan, nv.maChiNhanh) "+
        "FROM NhanVien nv " +
        "WHERE nv.maChiNhanh = :maChiNhanh AND nv.hoTen LIKE :hoTen ")
    List<NhanVienDTO> findNhanVienByHoTen(String hoTen, String maChiNhanh);
}
