package com.example.BackEnd.DTO;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@AllArgsConstructor
public class NhanVienDTO {
    
    private String iDNhanVien;
    private String hoTen;
    private LocalDate ngaySinh;
    private String gioiTinh;
    private String diaChi;
    private LocalDate ngayVaoLam;
    private LocalDate ngayNghiViec;
    private String maBoPhan;
    private String maChiNhanh;


}
