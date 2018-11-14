package com.ps.net.dao;

import com.ps.net.model.Roles;

import java.util.List;
import java.util.Map;

public interface RolesMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Roles record);

    int insertSelective(Roles record);

    Roles selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Roles record);

    int updateByPrimaryKey(Roles record);

    List<Map<String,Object>> getRoleList(Map<String,Object> map);
    Integer getRoleListCount();
    List<Map<String,Object>> getRoleService(Integer role_id);
    Map<String,Object> getRole(Map<String,Object> map);
    void deleteRoleService(Integer id);
    void addRoleService(Map map);
    List<Map<String,Object>> getModules();
    List<Map<String,Object>> getFunctions(Integer module_id);
    Map<String,Object> getRoleFunc(Map<String,Object> map);
}