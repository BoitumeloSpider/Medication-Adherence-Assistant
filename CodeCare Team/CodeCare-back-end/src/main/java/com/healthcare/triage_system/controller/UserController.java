package com.healthcare.triage_system.controller;
import com.healthcare.triage_system.dto.UserDTO;
import com.healthcare.triage_system.model.User;
import com.healthcare.triage_system.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @Operation(summary = "Register a new user")
    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody UserDTO dto) {
        return ResponseEntity.ok(userService.registerUser(dto));
    }

    @Operation(summary = "Login user")
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody UserDTO dto) {
        boolean success = userService.authenticate(dto.getUsername(), dto.getPassword());
        if (success) return ResponseEntity.ok("Login successful");
        return ResponseEntity.status(401).body("Invalid username or password");
    }
}