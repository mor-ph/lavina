package com.codecoda.authservice.service;

import com.codecoda.authservice.dao.RoleRepository;
import com.codecoda.authservice.models.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoleServiceImpl implements RoleService {

    private RoleRepository roleRepository;

    @Autowired
    public RoleServiceImpl(RoleRepository theRoleRepository){
        roleRepository = theRoleRepository;
    }

    @Override
    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    @Override
    public Role findById(int theId) {
        Optional<Role> result = roleRepository.findById(theId);

        Role theRole;

        if (result.isPresent()){
            theRole = result.get();
        }
        else {
            throw  new RuntimeException("Did not find role id -" + theId);
        }
        return theRole;
    }

    @Override
    public void save(Role theUser) {
        roleRepository.save(theUser);
    }


    @Override
    public void deleteById(int theId) {
        roleRepository.deleteById(theId);
    }
}
