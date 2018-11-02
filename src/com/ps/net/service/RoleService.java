package com.ps.net.service;

import com.ps.net.model.Roles;
import com.ps.net.model.ServiceRole;

import java.util.List;
import java.util.Map;

public interface RoleService {
    List<Map<String,Object>> getRoleList(Map<String,Object> map);
    Integer getRoleListCount();
    List<Map<String,Object>> getRoleService(Integer role_id);
    Map<String,Object> getRole(Map map);
    void addRoles(Roles roles);
    void deleteRoleService(Integer id);
    ServiceRole getServiceRoleByName(String name);
    void  addRoleService(Map map);
    void editRoles(Roles roles);

}
