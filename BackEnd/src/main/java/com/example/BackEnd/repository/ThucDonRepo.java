package com.example.BackEnd.repository;

import com.example.BackEnd.DTO.ChiTietThucDonDTO;
import com.example.BackEnd.model.ChiTietThucDon;
import com.example.BackEnd.model.ChiTietThucDonId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ThucDonRepo extends JpaRepository<ChiTietThucDon, ChiTietThucDonId> {
    
    @Query("SELECT new com.example.BackEnd.DTO.ChiTietThucDonDTO(ct.id, m.tenMon, m.giaHienTai, m.muc.tenMuc, ct.tinhTrang) " +
        "FROM ChiTietThucDon ct JOIN MonAn m ON ct.id.maMonAn = m.maMon "+
        "WHERE ct.tinhTrang = 'Có' AND ct.id.maChiNhanh = :maChiNhanh ")
    List<ChiTietThucDonDTO> findServed(String maChiNhanh);
    
}
