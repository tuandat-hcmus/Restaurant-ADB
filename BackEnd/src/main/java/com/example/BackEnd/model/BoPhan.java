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
public class BoPhan {
    @Id
    @Column(name = "MaBoPhan", nullable = false, length = 10)
    private String maBoPhan;

    @Nationalized
    @Column(name = "TenBoPhan", nullable = false, length = 50)
    private String tenBoPhan;

}