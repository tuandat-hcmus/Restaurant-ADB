package com.example.BackEnd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;

import java.time.LocalDate;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class PhieuDatMon {
    @Id
    @Column(name = "MaPhieu", nullable = false, length = 10)
    private String maPhieu;

    @Column(name = "NgayLap", nullable = false)
    private LocalDate ngayLap;

    @Column(name = "SoBan", nullable = false)
    private Integer soBan;

    @Column(name = "IDNhanVien", nullable = false)
    private String iDNhanVien;

    @Column(name = "MaChiNhanh", nullable = false)
    private String maChiNhanh;

}