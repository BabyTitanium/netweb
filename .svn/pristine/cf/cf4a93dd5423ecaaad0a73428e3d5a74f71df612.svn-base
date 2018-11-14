package com.ps.net.dao;

import com.ps.net.model.RoomThermostatAddr;

import java.util.List;
import java.util.Map;

public interface RoomThermostatAddrMapper {
    int deleteByPrimaryKey(Integer room_id);

    int insert(RoomThermostatAddr record);

    int insertSelective(RoomThermostatAddr record);

    RoomThermostatAddr selectByPrimaryKey(Integer room_id);

    int updateByPrimaryKeySelective(RoomThermostatAddr record);

    int updateByPrimaryKey(RoomThermostatAddr record);

    List<Map<String,Object>> getRoomThermostatList(Map<String,Object> map);
    Integer getRoomThermostatListCount(Map<String,Object> map);
    void addRoomThermostat(Map<String,Object> map);
    void updateRoomThermostat(Map<String,Object> map);
    Map<String,Object> getRoomThermostatAddr(Integer room_id);

    List<Map<String,Object>> getAllRoomThermostat(Map<String,Object> condition);


    Integer getThermostatListOnlineCount(Map<String,Object> map);
    Integer getThermostatListOfflineCount(Map<String,Object> map);
}