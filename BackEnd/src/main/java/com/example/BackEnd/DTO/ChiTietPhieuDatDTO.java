package com.example.BackEnd.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.RequestPart;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChiTietPhieuDatDTO {
    
    private int soBan;
    private String idNhanVien;
    private String maChiNhanh;
    private List<MonAnDTO> mon;
    
}
