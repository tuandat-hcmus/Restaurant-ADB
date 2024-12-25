package com.example.BackEnd.DTO;

import com.example.BackEnd.model.ChiTietThucDonId;
import com.example.BackEnd.model.MonAn;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChiTietThucDonDTO {
    
    private ChiTietThucDonId id;
    private String tenMon;
    private BigDecimal donGia;
    private String tenMuc;
    private String tinhTrang;
    
}
