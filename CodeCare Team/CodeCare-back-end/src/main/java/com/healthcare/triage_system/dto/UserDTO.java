package com.healthcare.triage_system.dto;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserDTO {
    private String username;
    private String email;
    private String password;
    private LocalDateTime createdAt;
}