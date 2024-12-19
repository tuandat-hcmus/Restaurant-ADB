package com.example.BackEnd.service;

import com.example.BackEnd.model.PhieuDatMon;
import com.example.BackEnd.repository.PhieuDatRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PhieuDatService {
    
    @Autowired
    private PhieuDatRepo phieuDatRepo;
    
    public ResponseEntity<?> insertPhieuDatMon(String soBan, String idNhanVien, String maChiNhanh) {
        try {
            int res = phieuDatRepo.insertPhieuDatMon(soBan, idNhanVien, maChiNhanh);
            if (res == 1) {
                return new ResponseEntity<>("Success", HttpStatus.CREATED);
            }
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
        catch (Exception e) {
            return new ResponseEntity<>("An error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    public ResponseEntity<List<PhieuDatMon>> getAllPhieuDatMon() {
        try {
            return new ResponseEntity<>(phieuDatRepo.findAll(), HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    public ResponseEntity<?> deletePhieuDatMon(String maPhieu) {
        try {
            phieuDatRepo.deleteById(maPhieu);
            return new ResponseEntity<>("Deleted", HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<>("An error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
}
