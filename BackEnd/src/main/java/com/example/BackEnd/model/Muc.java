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
public class Muc {
    @Id
    @Column(name = "IDMuc", nullable = false, length = 10)
    private String iDMuc;

    @Nationalized
    @Column(name = "TenMuc", nullable = false, length = 50)
    private String tenMuc;

}