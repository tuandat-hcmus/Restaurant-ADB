package com.example.BackEnd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

@Getter
@Setter
@Entity
public class KhachHang {
    @Id
    @Column(name = "IDKhachHang", nullable = false, length = 10)
    private String iDKhachHang;

    @Column(name = "Username", length = 50)
    private String username;

    @Nationalized
    @Column(name = "Password")
    private String password;

}