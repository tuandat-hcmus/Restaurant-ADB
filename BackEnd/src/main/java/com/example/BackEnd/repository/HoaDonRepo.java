package com.example.BackEnd.repository;

import com.example.BackEnd.model.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface HoaDonRepo extends JpaRepository<HoaDon, String> {

    @Modifying
    @Transactional
    @Query(value = "EXEC TongDoanhThu :ngayBD, :ngayKT, :loai, :maChiNhanh", nativeQuery = true)
    List<Object[]> tongDoanhThu(
        @Param("ngayBD") LocalDate ngayBD,
        @Param("ngayKT") LocalDate ngayKT,
        @Param("loai") int loai,
        @Param("maChiNhanh") String maChiNhanh
    );

    
    @Query(value = "EXEC getHoaDonKhachHang :maThe, :ngayBD, :ngayKT", nativeQuery = true)
    List<Object[]> findHoaDonByMaTheKhachHang(@Param("maThe")String maThe,@Param("ngayBD") LocalDate ngayBD,@Param("ngayKT") LocalDate ngayKT);


}
