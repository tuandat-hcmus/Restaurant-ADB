package com.example.BackEnd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "BoPhan_ChiNhanh")
public class BophanChinhanh {

    @EmbeddedId
    private BophanChinhanhId id;

}