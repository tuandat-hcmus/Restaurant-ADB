package com.example.BackEnd.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HoaDonDTO {

    private List<ChiTietMonDTO> items;
    private String maHoaDon;
    private BigDecimal tongTien;
    private LocalDate ngayLap;
    
}
