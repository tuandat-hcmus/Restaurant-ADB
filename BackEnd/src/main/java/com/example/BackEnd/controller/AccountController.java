package com.example.BackEnd.controller;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.NhanVien;
import com.example.BackEnd.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AccountController {

    @Autowired
    AccountService accountService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody NhanVien nhanVien) {
        return accountService.register(nhanVien);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Account account) {
        return accountService.verify(account);
    }


}
