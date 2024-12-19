package com.example.BackEnd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Account {
    
    private String id;
    private String username;
    private String password;
    private String role;
    
}
