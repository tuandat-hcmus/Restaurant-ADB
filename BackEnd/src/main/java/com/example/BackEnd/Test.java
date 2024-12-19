package com.example.BackEnd;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Test {
    
    @GetMapping("/test")
    public String test() {
        return "test";
    }
    
    @PostMapping("/test")
    public String post() {
        return "post";
    }
    
}
