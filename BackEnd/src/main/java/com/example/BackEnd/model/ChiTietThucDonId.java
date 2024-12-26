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
public class ChiTietThucDonId implements java.io.Serializable {
    private static final long serialVersionUID = -6428903499670900195L;
    @Column(name = "MaChiNhanh", nullable = false, length = 10)
    private String maChiNhanh;

    @Column(name = "MaMonAn", nullable = false, length = 10)
    private String maMonAn;

    @Column(name = "MaKhuVuc", nullable = false, length = 10)
    private String maKhuVuc;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ChiTietThucDonId entity = (ChiTietThucDonId) o;
        return Objects.equals(this.maChiNhanh, entity.maChiNhanh) &&
            Objects.equals(this.maKhuVuc, entity.maKhuVuc) &&
            Objects.equals(this.maMonAn, entity.maMonAn);
    }

    @Override
    public int hashCode() {
        return Objects.hash(maChiNhanh, maKhuVuc, maMonAn);
    }

}