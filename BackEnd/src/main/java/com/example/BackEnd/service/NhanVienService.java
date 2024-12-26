package com.example.BackEnd.service;

import com.example.BackEnd.DTO.DiemNhanVienDTO;
import com.example.BackEnd.DTO.NhanVienDTO;
import com.example.BackEnd.model.NhanVien;
import com.example.BackEnd.repository.NhanVienRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public class NhanVienService {
    
    @Autowired
    private NhanVienRepo nhanVienRepo;
    
    public ResponseEntity<List<DiemNhanVienDTO>> getDiemNhanVien(String ngayXuat, String maChiNhanh) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.parse(ngayXuat, formatter);
            List<DiemNhanVienDTO> list = nhanVienRepo.getDiemNhanVienDTO(localDate, maChiNhanh);
            return new ResponseEntity<>(list, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<List<DiemNhanVienDTO>> getDiemNhanVienThang(String thang, String nam, String maChiNhanh) {
        try {
            return new ResponseEntity<>(nhanVienRepo.getDiemNhanVienThang(thang, nam, maChiNhanh), HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<List<DiemNhanVienDTO>> getDiemNhanVienQuy(String quy, String nam, String maChiNhanh) {
        try {
            List<Object[]> rawData = nhanVienRepo.getDiemNhanVienQuy(quy, nam, maChiNhanh);
            List<DiemNhanVienDTO> result = new ArrayList<>();
            for (Object[] row : rawData) {
                DiemNhanVienDTO dto = new DiemNhanVienDTO(
                    row[0].toString(),
                    row[1].toString(),
                    ((Number) row[2]).doubleValue()
                );
                result.add(dto);
            }
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<List<DiemNhanVienDTO>> getDiemNhanVienNam(String nam, String maChiNhanh) {
        try {
            return new ResponseEntity<>(nhanVienRepo.getDiemNhanVienNam(nam, maChiNhanh), HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    public ResponseEntity<List<NhanVienDTO>> getNhanVienByChiNhanh(String maChiNhanh) {
        try {
            return new ResponseEntity<>(nhanVienRepo.findNhanVienByMaChiNhanh(maChiNhanh), HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    public ResponseEntity<List<NhanVienDTO>> getNhanVienByHoTen(String hoTen, String maChiNhanh) {
        try {
            hoTen = "%" + hoTen + "%";
            return new ResponseEntity<>(nhanVienRepo.findNhanVienByHoTen(hoTen, maChiNhanh), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
