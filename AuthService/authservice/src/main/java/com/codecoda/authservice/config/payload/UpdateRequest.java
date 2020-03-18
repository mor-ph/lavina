package com.codecoda.authservice.config.payload;

import javax.validation.constraints.NotBlank;

public class UpdateRequest {

    @NotBlank(message = "Username is a required field")
    private String username;

    private String password;

    @NotBlank(message = "Email is a required field")
    private String email;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
