package com.codecoda.authservice.controller;

import com.codecoda.authservice.models.Role;
import com.codecoda.authservice.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api.role")
public class RoleController {

    private RoleService roleService;

    @Autowired
    public RoleController(RoleService theRoleService){
        roleService = theRoleService;
    }

    @GetMapping("/roles")
    public List<Role> getRoles(){
        return roleService.findAll();
    }

    @GetMapping("/roles/{roleId}")
    public Role getUser(@PathVariable int roleId){

        Role role = roleService.findById(roleId);

        return role;
    }

    @PostMapping("/roles")
    public Role addRole(@RequestBody Role theRole){

        roleService.save(theRole);

        return theRole;
    }

    @PutMapping("/roles")
    public Role updateRole(@RequestBody Role theRole){

        roleService.save(theRole);

        return theRole;
    }

    @DeleteMapping("/users")
    public String deleteUser(@PathVariable int theId){

        roleService.deleteById(theId);

        return "Deleted role id - " + theId;
    }
}
