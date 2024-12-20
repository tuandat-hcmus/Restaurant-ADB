package com.example.BackEnd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.util.Objects;

@Getter
@Setter
@Embeddable
public class BophanChinhanhId implements java.io.Serializable {
    private static final long serialVersionUID = 7829223440323822386L;
    @Column(name = "MaBoPhan", nullable = false, length = 10)
    private String maBoPhan;

    @Column(name = "MaChiNhanh", nullable = false, length = 10)
    private String maChiNhanh;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        BophanChinhanhId entity = (BophanChinhanhId) o;
        return Objects.equals(this.maChiNhanh, entity.maChiNhanh) &&
            Objects.equals(this.maBoPhan, entity.maBoPhan);
    }

    @Override
    public int hashCode() {
        return Objects.hash(maChiNhanh, maBoPhan);
    }

}