package com.ps.net.service;

import com.ps.net.model.Functions;
import com.ps.net.model.Users;

import java.util.List;

public interface ShiroService {
     Users getUserByUserName(String username);
     List<Functions> getPermissionsByUser(Users users);
}
