package com.example.BackEnd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

@Getter
@Setter
@Entity
public class DanhGia {
    @Id
    @Column(name = "MaDanhGia", nullable = false, length = 10)
    private String maDanhGia;

    @Column(name = "DiemPhucVu", nullable = false)
    private Integer diemPhucVu;

    @Column(name = "DiemViTri", nullable = false)
    private Integer diemViTri;

    @Column(name = "ChatLuongMon", nullable = false)
    private Integer chatLuongMon;

    @Column(name = "GiaCa", nullable = false)
    private Integer giaCa;

    @Column(name = "KhongGian", nullable = false)
    private Integer khongGian;

    @Nationalized
    @Column(name = "BinhLuan", length = 100)
    private String binhLuan;

    @Column(name = "MaPhieu", nullable = false)
    private String maPhieu;

}