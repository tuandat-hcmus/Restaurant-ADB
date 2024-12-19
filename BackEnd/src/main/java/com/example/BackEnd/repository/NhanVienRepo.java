package com.example.BackEnd.repository;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.NhanVien;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;

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

}
