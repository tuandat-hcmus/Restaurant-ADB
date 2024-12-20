package com.example.BackEnd.controller;

import com.example.BackEnd.model.PhieuDatMon;
import com.example.BackEnd.service.PhieuDatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/phieudat")
public class PhieuDatController {
    
    @Autowired
    private PhieuDatService phieuDatService;
    
    @GetMapping("/all")
    public ResponseEntity<List<PhieuDatMon>> getAllPhieuDat() {
        return phieuDatService.getAllPhieuDatMon();
    }
    
    @PostMapping("/them")
    public ResponseEntity<?> insertPhieuDat(@RequestPart("soBan") String soBan, @RequestPart("idNhanVien") String idNhanVien,  @RequestPart("maChiNhanh") String maChiNhanh) {
        return phieuDatService.insertPhieuDatMon(soBan, idNhanVien, maChiNhanh);
    }
    
    @DeleteMapping("/xoa/{id}")
    public ResponseEntity<?> deletePhieuDat(@PathVariable String id) {
        return phieuDatService.deletePhieuDatMon(id);
    }
}
