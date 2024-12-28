package com.example.BackEnd.repository;

import com.example.BackEnd.model.PhieuDatMon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface PhieuDatRepo extends JpaRepository<PhieuDatMon, String> {

    @Modifying
    @Transactional
    @Query(value = "DECLARE @MaPhieu VARCHAR(10); EXEC InsertPhieuDatMon :soBan, :iDNhanVien, :maChiNhanh, @MaPhieu OUTPUT; SELECT @MaPhieu AS MaPhieu;", nativeQuery = true)
    List<Map<String, Object>> insertPhieuDatMon(
        @Param("soBan") int soBan,
        @Param("iDNhanVien") String iDNhanVien,
        @Param("maChiNhanh") String maChiNhanh
    );
    
    @Modifying
    @Transactional
    @Query(value = "EXEC InsertChiTietPhieuDatMon :maMon, :maPhieu, :soLuong", nativeQuery = true)
    void insertChiTietPhieuDat(String maMon, String maPhieu, int soLuong);
    
}
