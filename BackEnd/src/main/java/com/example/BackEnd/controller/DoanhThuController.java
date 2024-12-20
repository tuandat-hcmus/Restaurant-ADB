package com.example.BackEnd.controller;

import com.example.BackEnd.service.DoanhThuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
public class DoanhThuController {
    
    @Autowired
    private DoanhThuService doanhThuService;
    
    @GetMapping("/doanhthu")
    public ResponseEntity<?> getDoanhThu(@RequestParam("ngayBD") String ngayBD, @RequestParam("ngayKT") String ngayKT, @RequestParam("loai") String loai, @RequestParam("maChiNhanh") String maChiNhanh) {
        return doanhThuService.getDoanhThu(ngayBD, ngayKT, loai, maChiNhanh);
    }
    
}
