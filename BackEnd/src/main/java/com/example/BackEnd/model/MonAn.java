package com.example.BackEnd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
public class MonAn {
    @Id
    @Column(name = "MaMon", nullable = false, length = 10)
    private String maMon;

    @Nationalized
    @Column(name = "TenMon", nullable = false, length = 50)
    private String tenMon;

    @Column(name = "GiaHienTai", nullable = false, precision = 10, scale = 2)
    private BigDecimal giaHienTai;

    @Column(name = "CoTheGiaoHang", nullable = false)
    private Boolean coTheGiaoHang = false;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "IDMuc", nullable = false)
    private Muc muc;

}