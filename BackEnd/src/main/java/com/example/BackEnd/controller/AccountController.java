package com.example.BackEnd.controller;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.KhachHang;
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
    
    /*
     * login returns: 
     * {
     *     "message": "",
     *     "token": ""
     * }
     */

    @PostMapping("/register")
    public ResponseEntity<?> empRegister(@RequestBody NhanVien nhanVien) {
        return accountService.empRegister(nhanVien);
    }

    @PostMapping("/login")
    public ResponseEntity<?> empLogin(@RequestBody Account account) {
        return accountService.verify(account, true);
    }

    @PostMapping("/cusRegister")
    public ResponseEntity<?> cusRegister(@RequestBody KhachHang khachHang) {
        return accountService.cusRegister(khachHang);
    }

    @PostMapping("/cusLogin")
    public ResponseEntity<?> cusLogin(@RequestBody Account account) {
        return accountService.verify(account, false);
    }
}
