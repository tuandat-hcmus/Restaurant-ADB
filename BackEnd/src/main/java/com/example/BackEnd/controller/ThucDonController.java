package com.example.BackEnd.controller;

import com.example.BackEnd.DTO.ChiTietThucDonDTO;
import com.example.BackEnd.model.ChiTietThucDon;
import com.example.BackEnd.service.ThucDonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/thucdon")
@CrossOrigin
public class ThucDonController {
    
    @Autowired
    private ThucDonService thucDonService;
    
    @GetMapping("/{maChiNhanh}")
    public List<ChiTietThucDonDTO> getAllChiTietThucDon(@PathVariable String maChiNhanh) {
        return thucDonService.getAll(maChiNhanh);
    }
    
}
