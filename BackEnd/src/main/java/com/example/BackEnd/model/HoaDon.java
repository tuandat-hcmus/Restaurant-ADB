package com.example.BackEnd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
public class HoaDon {
    @Id
    @Column(name = "MaHoaDon", nullable = false, length = 10)
    private String maHoaDon;

    @Column(name = "NgayGioXuat", nullable = false)
    private Instant ngayGioXuat;

    @Column(name = "TongTien", nullable = false, precision = 10, scale = 2)
    private BigDecimal tongTien;

    @Column(name = "Giam", precision = 10, scale = 2)
    private BigDecimal giam;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaPhieuDat")
    private PhieuDatMon maPhieuDat;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaTheKhachHang")
    private TheKhachHang maTheKhachHang;

}