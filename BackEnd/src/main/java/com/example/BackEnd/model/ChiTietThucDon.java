package com.example.BackEnd.model;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

@Getter
@Setter
@Entity
public class ChiTietThucDon {
    @EmbeddedId
    private ChiTietThucDonId id;

    @Nationalized
    @Column(name = "TinhTrang", nullable = false, length = 10)
    private String tinhTrang;

/*
 TODO [Reverse Engineering] create field to map the 'MaChiNhanh' column
 Available actions: Uncomment as is | Remove column mapping
    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MaChiNhanh", nullable = false)
    private ChiNhanh1 maChiNhanh;
*/
/*
 TODO [Reverse Engineering] create field to map the 'MaMonAn' column
 Available actions: Uncomment as is | Remove column mapping
    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MaMonAn", nullable = false)
    private MonAn1 maMonAn;
*/
/*
 TODO [Reverse Engineering] create field to map the 'MaKhuVuc' column
 Available actions: Uncomment as is | Remove column mapping
    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MaKhuVuc", nullable = false)
    private KhuVuc1 maKhuVuc;
*/
}