package com.ps.net.dao;

import com.ps.net.model.Users;
import org.omg.PortableInterceptor.INACTIVE;

import java.util.List;
import java.util.Map;

public interface UsersMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);

    List<Users> getUsersByRole(Integer role_id);

    List<Map<String, Object>> getUserList(Map map);

    List<Map<String, Object>> getUserStations(Integer role_id);

    Integer userListCount();

    Map<String, Object> checkUsername(String user_name);

    List<Map<String, Object>> getArealist();

    Map haveStation(Map map);

    void deleteByUser(Integer user_id);

    void addUserStation(Map map);

    Users findUserByName(String user_name);
}