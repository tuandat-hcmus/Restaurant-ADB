package com.example.BackEnd.service;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.MyUserDetail;
import com.example.BackEnd.model.NhanVien;
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
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account = nhanVienRepo.findAccountByUsername(username);

        if (account == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return new MyUserDetail(new Account(
            account.getId(),
            account.getUsername(),
            account.getPassword(),
            "EMPLOYEE"
        ));

    }
}
