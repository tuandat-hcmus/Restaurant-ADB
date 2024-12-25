package com.example.BackEnd.service;

import com.example.BackEnd.DTO.ChiTietThucDonDTO;
import com.example.BackEnd.repository.ThucDonRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThucDonService {
    
    @Autowired
    private ThucDonRepo thucDonRepo;
    
    public List<ChiTietThucDonDTO> getAll(String maChiNhanh) {
        return thucDonRepo.findServed(maChiNhanh);
    }
    
}
