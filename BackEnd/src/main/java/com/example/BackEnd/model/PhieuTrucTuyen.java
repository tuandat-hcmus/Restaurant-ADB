package com.example.BackEnd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
@Entity
public class PhieuTrucTuyen {
    @Id
    @Column(name = "MaPhieu", nullable = false, length = 10)
    private String maPhieu;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MaPhieu", nullable = false)
    private PhieuDatMon phieuDatMon;

    @Column(name = "SoKhach")
    private Integer soKhach;

    @Column(name = "NgayDat", nullable = false)
    private LocalDate ngayDat;

    @Column(name = "GioDen", nullable = false)
    private LocalTime gioDen;

    @Nationalized
    @Column(name = "GhiChu", length = 100)
    private String ghiChu;

    @Column(name = "SDT", nullable = false, length = 10)
    private String sdt;

}