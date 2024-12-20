package com.example.BackEnd.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChiTietMonDTO {

    private String tenMon;
    private BigDecimal gia;
    private int soLuong;
    
}
