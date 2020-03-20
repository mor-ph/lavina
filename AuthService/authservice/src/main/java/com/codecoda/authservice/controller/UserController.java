package com.codecoda.authservice.controller;

import com.codecoda.authservice.config.JwtUtils;
import com.codecoda.authservice.config.payload.JwtResponse;
import com.codecoda.authservice.config.payload.LoginRequest;
import com.codecoda.authservice.config.payload.UpdateRequest;
import com.codecoda.authservice.models.User;
import com.codecoda.authservice.service.RoleService;
import com.codecoda.authservice.service.UserDetailsImpl;
import com.codecoda.authservice.service.UserService;
import com.codecoda.authservice.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.ValidationException;
import java.time.LocalDateTime;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/auth")
public class UserController {

    private UserService userService;
    private RoleService roleService;

    @Autowired
    private UserServiceImpl userDetailsService;

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

    @GetMapping("/email/{email}")
    public String getEmail(@PathVariable String email){

        User userByEmail = userService.findByEmail(email);

        return userByEmail.getEmail();
    }

    @GetMapping("/username/{username}")
    public String getUsername(@PathVariable String username){

        User userByUsername = userService.findByUsername(username);

        return userByUsername.getEmail();
    }


    @PostMapping("/users")
    public User addUser(@RequestBody @Valid User theUser) {

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
                roles));
    }

    @PutMapping("/users/{id}")
    public ResponseEntity<?> updateUser(@RequestBody @Valid UpdateRequest theUser, @PathVariable int id) {

        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        int loggedUserId = userDetails.getId();

        if (id == loggedUserId) {

            User updatedUser = userService.findById(id);
            User userByName = userService.findByUsername(theUser.getUsername());
            User userByEmail = userService.findByEmail(theUser.getEmail());

            if (updatedUser != null && userByName != null) {

                if (updatedUser.getId() != userByName.getId()) {
                    throw new ValidationException("The username exists");
                }
            }

            if (updatedUser != null && userByEmail != null) {

                if (updatedUser.getId() != userByEmail.getId()) {
                    throw new ValidationException("The email exists");
                }
            }

            if (updatedUser == null) {
                return ResponseEntity.notFound().build();
            }

            if(theUser.getPassword() != null ){
                updatedUser.setPassword(encoder.encode(theUser.getPassword()));
            }

            updatedUser.setUsername(theUser.getUsername());
            updatedUser.setEmail(theUser.getEmail());
            updatedUser.setCreatedAt(updatedUser.getCreatedAt());
            updatedUser.setUpdatedAt(LocalDateTime.now());

            userService.save(updatedUser);

            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.badRequest().build();
    }

//    @DeleteMapping("/users/{userId}")
//    public String deleteUser(@PathVariable int userId) {
//
//        userService.deleteById(userId);
//
//        return "Deleted user id - " + userId;
//    }

}
