package com.example.BackEnd.repository;

import com.example.BackEnd.model.PhieuDatMon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;

public interface PhieuDatRepo extends JpaRepository<PhieuDatMon, String> {

    @Modifying
    @Transactional
    @Query(value = "EXEC InsertPhieuDatMon :soBan, :iDNhanVien, :maChiNhanh", nativeQuery = true)
    int insertPhieuDatMon(
        @Param("soBan") String soBan,
        @Param("iDNhanVien") String iDNhanVien,
        @Param("maChiNhanh") String maChiNhanh
    );
    
}
