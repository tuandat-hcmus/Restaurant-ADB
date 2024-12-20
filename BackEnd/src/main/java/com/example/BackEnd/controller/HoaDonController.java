package com.example.BackEnd.controller;

import com.example.BackEnd.DTO.HoaDonDTO;
import com.example.BackEnd.service.HoaDonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/hoadon")
@CrossOrigin
public class HoaDonController {

    @Autowired
    private HoaDonService hoaDonService;

    /*    
    [
        {
            "items": [
                {
                    "tenMon": "Adpebonor",
                    "gia": 38508.53,
                    "soLuong": 8
                },
                {
                    "tenMon": "Zeesapaquantor",
                    "gia": 54594.65,
                    "soLuong": 1
                }
            ],
            "maHoaDon": "01RVU8NTQ2",
            "tongTien": 817481.62,
            "ngayLap": "2020-02-16"
        }
    ]   
     */
    @GetMapping("/search")
    public ResponseEntity<List<HoaDonDTO>> searchHoaDonByDate(@RequestParam("maThe") String maThe, @RequestParam("ngayBD") String ngayBD, @RequestParam("ngayKT") String ngayKT) {
        List<HoaDonDTO> hoaDons = hoaDonService.getHoaDonByDate(maThe, ngayBD, ngayKT);
        return ResponseEntity.ok(hoaDons);
    }
}
