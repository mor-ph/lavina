package com.codecoda.authservice.service;

import com.codecoda.authservice.models.Role;

import java.util.List;

public interface RoleService {

    List<Role> findAll();

    Role findById(int theId);

    void save(Role theUser);

    void deleteById(int theId);
}
