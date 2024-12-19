package com.example.BackEnd.repository;

import com.example.BackEnd.model.ChiNhanh;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChiNhanhRepo extends JpaRepository<ChiNhanh, String> {
    
    int findChiNhanhByMaNVQL(String maNVQL);
    
}
