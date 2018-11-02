package com.ps.net.dao;

import com.ps.net.model.RoomValveAddr;

import java.util.List;
import java.util.Map;

public interface RoomValveAddrMapper {
    int deleteByPrimaryKey(Integer room_id);

    int insert(RoomValveAddr record);

    int insertSelective(RoomValveAddr record);

    RoomValveAddr selectByPrimaryKey(Integer room_id);

    int updateByPrimaryKeySelective(RoomValveAddr record);

    int updateByPrimaryKey(RoomValveAddr record);
    List<Map<String,Object>> getRoomValveList(Map<String,Object> map);
    Integer getRoomValveListCount(Map<String,Object> map);
    void addRoomValve(Map<String,Object> map);
    void updateRoomValve(Map<String,Object> map);
    Map<String,Object> getRoomValveAddr(Integer room_id);
    List<Map<String,Object>> getAllRoomValve(Map<String,Object> condition);


    Integer getValveListOnlineCount(Map<String,Object> map);
    Integer getValveListOfflineCount(Map<String,Object> map);
}