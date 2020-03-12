package com.codecoda.authservice.controller;

import com.codecoda.authservice.config.JwtUtils;
import com.codecoda.authservice.config.payload.JwtResponse;
import com.codecoda.authservice.config.payload.LoginRequest;
import com.codecoda.authservice.models.Role;
import com.codecoda.authservice.models.User;
import com.codecoda.authservice.service.RoleService;
import com.codecoda.authservice.service.UserDetailsImpl;
import com.codecoda.authservice.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.ValidationException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
//@CrossOrigin(origins = "http://localhost:8081")
@RequestMapping("/auth")
public class UserController {

    private UserService userService;
    private RoleService roleService;

    @Autowired
    PasswordEncoder encoder;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    JwtUtils jwtUtils;

    @Autowired
    public UserController(UserService theUserService, RoleService theRoleService) {
        this.userService = theUserService;
        this.roleService = theRoleService;
    }

    @GetMapping("/users")
    public List<User> getUsers() {

        return userService.findAll();
    }

    @GetMapping("/users/{userId}")
    public User getUser(@PathVariable int userId) {

        User user = userService.findById(userId);

        return user;
    }

    @PostMapping("/users")
    public User addUser(@RequestBody User theUser) {

        if (userService.existsByUsername(theUser.getUsername())) {
            throw new ValidationException("The username exists");
        }

        if (userService.existsByEmail(theUser.getEmail())) {
            throw new ValidationException("The email exists");
        }

        theUser.setPassword(encoder.encode(theUser.getPassword()));
        theUser.setCreatedAt(LocalDateTime.now());
        theUser.setUpdatedAt(LocalDateTime.now());
        userService.save(theUser);

        return theUser;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody @Valid LoginRequest loginRequest) {

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwt = jwtUtils.genereteJwtToken(authentication);
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<String> roles = userDetails.getAuthorities().stream()
                .map(item -> item.getAuthority())
                .collect(Collectors.toList());

        System.out.println("Login");

        return ResponseEntity.ok(new JwtResponse(jwt,
                userDetails.getId(),
                userDetails.getUsername(),
                userDetails.getPassword(),
                roles));
    }

    @PutMapping("/users/{id}")
    public ResponseEntity<?> updateUser(@RequestBody User theUser, @PathVariable int id) {

         User updatedUser = userService.findById(id);

         if (updatedUser == null){
             return ResponseEntity.notFound().build();
         }

         updatedUser.setUsername(theUser.getUsername());
         updatedUser.setPassword(theUser.getPassword());
         updatedUser.setEmail(theUser.getEmail());
         updatedUser.setCreatedAt(theUser.getCreatedAt());
         updatedUser.setUpdatedAt(LocalDateTime.now());

         userService.save(updatedUser);

         return ResponseEntity.noContent().build();
    }

//    @DeleteMapping("/users/{userId}")
//    public String deleteUser(@PathVariable int userId) {
//
//        userService.deleteById(userId);
//
//        return "Deleted user id - " + userId;
//    }

}
