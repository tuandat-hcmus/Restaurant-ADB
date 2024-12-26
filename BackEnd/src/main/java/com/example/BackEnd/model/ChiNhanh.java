package com.example.BackEnd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.time.LocalTime;

@Getter
@Setter
@Entity
public class ChiNhanh {
    @Id
    @Column(name = "MaChiNhanh", nullable = false, length = 10)
    private String maChiNhanh;

    @Nationalized
    @Column(name = "TenChiNhanh", nullable = false, length = 50)
    private String tenChiNhanh;

    @Nationalized
    @Column(name = "DiaChi", nullable = false, length = 50)
    private String diaChi;

    @Column(name = "ThoiGianMo", nullable = false)
    private LocalTime thoiGianMo;

    @Column(name = "ThoiGianDong", nullable = false)
    private LocalTime thoiGianDong;

    @Column(name = "SDT", nullable = false, length = 10)
    private String sdt;

    @Column(name = "Website", nullable = false, length = 50)
    private String website;

    @Column(name = "BaiXeMay", nullable = false)
    private Boolean baiXeMay = false;

    @Column(name = "BaiXeHoi", nullable = false)
    private Boolean baiXeHoi = false;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MaKhuVuc", nullable = false)
    private KhuVuc maKhuVuc;

    @Column(name = "MaNVQL")
    private String maNVQL;

}