package com.example.BackEnd.service;

import com.example.BackEnd.model.Account;
import com.example.BackEnd.model.NhanVien;
import com.example.BackEnd.repository.NhanVienRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AccountService {

    @Autowired
    NhanVienRepo nhanVienRepo;

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    private JwtService jwtService;

    private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(10);

    public ResponseEntity<?> register(NhanVien nhanVien) {
        try {

            String encodedPassword = encoder.encode(nhanVien.getPassword());

            nhanVien.setPassword(encodedPassword);
            
            return new ResponseEntity<>(nhanVienRepo.insertNhanVien(
                nhanVien.getHoTen(),
                nhanVien.getNgaySinh(),
                nhanVien.getGioiTinh(),
                nhanVien.getDiaChi(),
                nhanVien.getLuong(),
                nhanVien.getNgayVaoLam(),
                nhanVien.getMaBoPhan(),
                nhanVien.getMaChiNhanh(),
                nhanVien.getUsername(),
                nhanVien.getPassword()
            ), HttpStatus.CREATED);
        }
        catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<Map<String, Object>> verify(Account user) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (user == null || user.getUsername() == null || user.getUsername().isEmpty()
                || user.getPassword() == null || user.getPassword().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            user.setUsername("EMPLOYEE_" + user.getUsername());

            Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));

            if (authentication.isAuthenticated()) {
                
                String token = jwtService.generateToken(user);
                response.put("token", token);
                response.put("message", "Login successful");
                return ResponseEntity.ok(response);
            }

            response.put("message", "Authentication failed.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        } catch (BadCredentialsException e) {
            response.put("message", "Invalid username or password.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        } catch (Exception e) {
            response.put("message", "An error occurred: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
}
