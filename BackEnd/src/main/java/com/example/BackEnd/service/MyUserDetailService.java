package com.example.BackEnd.service;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.MyUserDetail;
import com.example.BackEnd.model.NhanVien;
import com.example.BackEnd.repository.KhachHangRepo;
import com.example.BackEnd.repository.NhanVienRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class MyUserDetailService implements UserDetailsService {
    
    @Autowired
    private NhanVienRepo nhanVienRepo;
    @Autowired
    private KhachHangRepo khachHangRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account;
        if (username.contains("EMPLOYEE_")) {
            account = nhanVienRepo.findAccountByUsername(username);
        } else {
            account = khachHangRepo.findAccountByUsername(username);
        }

        if (account == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return new MyUserDetail(account);

    }
}
