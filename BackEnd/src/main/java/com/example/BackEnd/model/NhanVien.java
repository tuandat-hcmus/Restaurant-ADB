package com.example.BackEnd.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "NhanVien")
public class NhanVien {
    @Id
    @Column(name = "IDNhanVien", nullable = false, length = 10)
    private String iDNhanVien;

    @Nationalized
    @Column(name = "HoTen", nullable = false, length = 50)
    private String hoTen;

    @Column(name = "NgaySinh")
    private LocalDate ngaySinh;

    @Nationalized
    @Column(name = "GioiTinh", length = 3)
    private String gioiTinh;

    @Nationalized
    @Column(name = "DiaChi", nullable = false, length = 50)
    private String diaChi;

    @Column(name = "Luong", nullable = false, precision = 10, scale = 2)
    private BigDecimal luong;

    @Column(name = "NgayVaoLam", nullable = false)
    private LocalDate ngayVaoLam;

    @Column(name = "NgayNghiViec")
    private LocalDate ngayNghiViec;

    @Column(name = "MaBoPhan")
    private String maBoPhan;
    
    @Column(name = "MaChiNhanh")
    private String maChiNhanh;

    @Column(name = "Username", length = 50)
    private String username;

    @Column(name = "Password")
    private String password;

}