package com.example.BackEnd.service;

import com.example.BackEnd.DTO.ChiTietMonDTO;
import com.example.BackEnd.DTO.HoaDonDTO;
import com.example.BackEnd.repository.HoaDonRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HoaDonService {
    
    @Autowired
    private HoaDonRepo hoaDonRepo;

    public List<HoaDonDTO> getHoaDonByDate(String maThe, String ngayBD, String ngayKT) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate bd = LocalDate.parse(ngayBD, formatter);
        LocalDate kt = LocalDate.parse(ngayKT, formatter);
        
        List<Object[]> results = hoaDonRepo.findHoaDonByMaTheKhachHang(maThe, bd, kt);
        Map<String, HoaDonDTO> hoaDonMap = new HashMap<>();

        for (Object[] row : results) {
            String maHoaDon = row[0].toString();
            BigDecimal tongTien = ((BigDecimal) row[1]);
            LocalDate ngayLap = LocalDate.parse(row[2].toString(), formatter);
            int soLuong = ((Number) row[3]).intValue();
            BigDecimal gia = ((BigDecimal) row[4]);
            String tenMon = row[5].toString();
            
            HoaDonDTO hoaDonDTO = hoaDonMap.getOrDefault(maHoaDon, new HoaDonDTO());
            if (!hoaDonMap.containsKey(maHoaDon)) {
                hoaDonDTO.setMaHoaDon(maHoaDon);
                hoaDonDTO.setTongTien(tongTien);
                hoaDonDTO.setNgayLap(ngayLap);
                hoaDonDTO.setItems(new ArrayList<>());
                hoaDonMap.put(maHoaDon, hoaDonDTO);
            }

            ChiTietMonDTO chiTietMon = new ChiTietMonDTO();
            chiTietMon.setTenMon(tenMon);
            chiTietMon.setGia(gia);
            chiTietMon.setSoLuong(soLuong);

            hoaDonDTO.getItems().add(chiTietMon);
        }

        return new ArrayList<>(hoaDonMap.values());
    }
    
}
