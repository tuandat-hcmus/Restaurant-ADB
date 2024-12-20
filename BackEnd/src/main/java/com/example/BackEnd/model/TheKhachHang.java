package com.example.BackEnd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.time.LocalDate;

@Getter
@Setter
@Entity
public class TheKhachHang {
    @Id
    @Column(name = "MaThe", nullable = false, length = 10)
    private String maThe;

    @Nationalized
    @Column(name = "HoTen", nullable = false, length = 50)
    private String hoTen;

    @Column(name = "CCCD", nullable = false, length = 12)
    private String cccd;

    @Column(name = "Email", length = 50)
    private String email;

    @Nationalized
    @Column(name = "GioiTinh", length = 3)
    private String gioiTinh;

    @Column(name = "LoaiThe", nullable = false, length = 10)
    private String loaiThe;

    @Column(name = "NgayDat", nullable = false)
    private LocalDate ngayDat;

    @Column(name = "TongGiaTri", nullable = false)
    private Integer tongGiaTri;

    @Column(name = "NgayLap", nullable = false)
    private LocalDate ngayLap;

    @Nationalized
    @Column(name = "TinhTrang", length = 20)
    private String tinhTrang;

    @Column(name = "IDKhachHang")
    private String iDKhachHang;

    @Column(name = "NhanVienLap", nullable = false)
    private String nhanVienLap;

}