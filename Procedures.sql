-- Cập nhật hạng thẻ - Thực hiện mỗi tháng

--DROP PROCEDURE sp_CapNhatHangThe
GO
CREATE PROCEDURE sp_CapNhatHangThe
AS
BEGIN
    -- Cập nhật thẻ SILVER xuống Membership
    UPDATE TheKhachHang
    SET LoaiThe = 'Membership',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Silver'
      AND DATEDIFF(YEAR, NgayDat, GETDATE()) < 1
      AND TongGiaTri < 5000000; -- Tổng giá trị dưới 5.000.000 VNĐ

    -- Cập nhật thẻ SILVER lên GOLD
    UPDATE TheKhachHang
    SET LoaiThe = 'Gold',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Silver'
      AND DATEDIFF(YEAR, NgayDat, GETDATE()) < 1
      AND TongGiaTri >= 10000000; -- Tổng giá trị từ 10.000.000 VNĐ

    -- Cập nhật thẻ GOLD xuống SILVER nếu không đạt điều kiện giữ hạng
    UPDATE TheKhachHang
    SET LoaiThe = 'Silver',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Gold'
      AND DATEDIFF(YEAR, NgayDat, GETDATE()) < 1
      AND TongGiaTri < 10000000; -- Tổng giá trị dưới 10.000.000 VNĐ

    -- Cập nhật thẻ Membership lên SILVER
    UPDATE TheKhachHang
    SET LoaiThe = 'Silver',
        TongGiaTri = 0,
        NgayDat = GETDATE()
    WHERE LoaiThe = 'Membership'
      AND TongGiaTri >= 10000000; -- Tổng giá trị từ 10.000.000 VNĐ
END;
GO
