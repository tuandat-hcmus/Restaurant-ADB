package com.example.BackEnd.service;

import com.example.BackEnd.DTO.DiemNhanVienDTO;
import com.example.BackEnd.DTO.DoanhThuDTO;
import com.example.BackEnd.repository.HoaDonRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class DoanhThuService {
    
    @Autowired
    private HoaDonRepo hoaDonRepo;
    
    public ResponseEntity<?> getDoanhThu(String ngayBD, String ngayKT, String loai, String maChiNhanh) {
        try {

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate bd = LocalDate.parse(ngayBD, formatter);
            LocalDate kt = LocalDate.parse(ngayKT, formatter);
            
            if (maChiNhanh.isEmpty()) maChiNhanh = null;
            
            List<Object[]> rawData = hoaDonRepo.tongDoanhThu(bd, kt, Integer.parseInt(loai), maChiNhanh);

            List<DoanhThuDTO> result = new ArrayList<>();
            for (Object[] row : rawData) {
                DoanhThuDTO dto = new DoanhThuDTO(
                    row[0].toString(),
                    (BigDecimal) row[1]
                );
                result.add(dto);
            }
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>("An error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
}
