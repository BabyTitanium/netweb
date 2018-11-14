package com.ps.net.service;

import com.ps.net.model.Users;

import java.util.List;
import java.util.Map;

public interface UserService {
    List<Map<String,Object>> userList(Map<String,Object> map);
    List<Map<String,Object>> getUserStations(Integer user_id);
    Integer userListCount();
    Map<String,Object> checkUsername(String user_name);
    void addUser(Users users);
    List<Map<String,Object>> getArealist();
    Map<String,Object> haveStation(Map map);
    void deleteByUser(Integer user_id);
    void addUserStation(Map map);
    Users  findUserByName(String user_name);
}
