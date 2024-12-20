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
public class KhuVuc {
    @Id
    @Column(name = "MaKhuVuc", nullable = false, length = 10)
    private String maKhuVuc;

    @Nationalized
    @Column(name = "TenThanhPho", nullable = false, length = 50)
    private String tenThanhPho;

}