package com.example.BackEnd.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
public class DoanhThuDTO {
    
    String ngay;
    BigDecimal doanhThu;
    
}
