package com.example.BackEnd.repository;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;

public interface KhachHangRepo extends JpaRepository<KhachHang, String> {

    @Query("SELECT new com.example.BackEnd.model.Account(k.iDKhachHang, k.username, k.password, '') FROM KhachHang k WHERE k.username = :username ")
    Account findAccountByUsername(String username);

    @Modifying
    @Transactional
    @Query(value = "EXEC InsertKhachHang :username, :password", nativeQuery = true)
    int insertKhachHang(
        @Param("username") String username,
        @Param("password") String password
    );
    
}
