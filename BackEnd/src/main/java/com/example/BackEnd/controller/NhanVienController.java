package com.example.BackEnd.controller;

import com.example.BackEnd.DTO.DiemNhanVienDTO;
import com.example.BackEnd.DTO.NhanVienDTO;
import com.example.BackEnd.model.NhanVien;
import com.example.BackEnd.service.NhanVienService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/emp")
public class NhanVienController {
    
    @Autowired
    private NhanVienService nhanVienService;
    
    /* 
    [
        {
            "hoTen": "Terence Holloway",
            "ngaySinh": "1998-07-14",
            "gioiTinh": "Nam",
            "diaChi": "CTUH9VVN12BCGSFE5",
            "ngayVaoLam": "2020-12-11",
            "ngayNghiViec": null,
            "maBoPhan": "XI15HVF0H",
            "maChiNhanh": "YRJJQDHW",
            "idnhanVien": "0012KH"
        },
    ]*/
    @GetMapping("/chinhanh/{maChiNhanh}")
    public ResponseEntity<List<NhanVienDTO>> getNhanVienbyChiNhanh(@PathVariable String maChiNhanh) {
        return nhanVienService.getNhanVienByChiNhanh(maChiNhanh);
    }
    
    @GetMapping("/chinhanh/{maChiNhanh}/{hoTen}")
    public ResponseEntity<List<NhanVienDTO>> getNhanVienbyHoten(@PathVariable String hoTen, @PathVariable String maChiNhanh) {
        return nhanVienService.getNhanVienByHoTen(hoTen, maChiNhanh);
    }
    
    
    /*
    [
        {
            "id": "962SDA7Z18",
            "hoTen": "Hilary Wood",
            "diem": 2.0
        }
    ]
     */
    @GetMapping("/diem/ngay")
    public ResponseEntity<List<DiemNhanVienDTO>> diemNgay(@RequestPart("ngayXuat") String ngay, @RequestPart("chiNhanh") String maChiNhanh) {
        return nhanVienService.getDiemNhanVien(ngay, maChiNhanh);
    }
    
    @GetMapping("/diem/thang")
    public ResponseEntity<List<DiemNhanVienDTO>> diemThang(@RequestPart("thang") String thang, @RequestPart("nam") String nam, @RequestPart("chiNhanh") String maChiNhanh) {
        return nhanVienService.getDiemNhanVienThang(thang, nam, maChiNhanh);
    }

    @GetMapping("/diem/quy")
    public ResponseEntity<List<DiemNhanVienDTO>> diemQuy(@RequestPart("quy") String quy, @RequestPart("nam") String nam, @RequestPart("chiNhanh") String maChiNhanh) {
        return nhanVienService.getDiemNhanVienQuy(quy, nam, maChiNhanh);
    }
    
    @GetMapping("/diem/nam")
    public ResponseEntity<List<DiemNhanVienDTO>> diemNam(@RequestPart("nam") String nam, @RequestPart("chiNhanh") String maChiNhanh) {
        return nhanVienService.getDiemNhanVienNam(nam, maChiNhanh);
    }
    
    @GetMapping("/{empId}")
    public ResponseEntity<NhanVien> getNhanVienById(@PathVariable String empId) {
        return nhanVienService.getNhanVienById(empId);
    }
}
