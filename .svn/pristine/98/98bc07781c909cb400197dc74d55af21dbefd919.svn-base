package com.ps.net.service.impl;

import com.ps.net.dao.FunctionsMapper;
import com.ps.net.dao.RolesMapper;
import com.ps.net.dao.UsersMapper;
import com.ps.net.model.Functions;
import com.ps.net.model.Roles;
import com.ps.net.model.Users;
import com.ps.net.service.ShiroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShiroServiceImpl implements ShiroService {
    @Autowired
    private UsersMapper usersMapper;
    @Autowired
    private RolesMapper rolesMapper;
    @Autowired
    private FunctionsMapper functionsMapper;
    @Override
    public Users getUserByUserName(String username) {
        //根据账号获取账号密码
        Users userByUserName =usersMapper.findUserByName(username);
        return userByUserName;
    }

    //获取权限
    @Override
    public List<Functions> getPermissionsByUser(Users users) {
        //获取到用户角色userRole

        Integer role_id=users.getRole_id();
        Roles role=rolesMapper.selectByPrimaryKey(role_id);

        //获取侧边栏权限

        List<Functions> functions=functionsMapper.getFunctionByRole(role_id);

        return functions;
    }



}
