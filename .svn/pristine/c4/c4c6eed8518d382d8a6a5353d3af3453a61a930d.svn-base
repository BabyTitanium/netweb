package com.ps.net.dao;

import com.ps.net.model.RoomTempAddr;
import com.ps.net.model.RoomTempAddrKey;

import java.util.List;
import java.util.Map;

public interface RoomTempAddrMapper {
    int deleteByPrimaryKey(RoomTempAddrKey key);

    int insert(RoomTempAddr record);

    int insertSelective(RoomTempAddr record);

    RoomTempAddr selectByPrimaryKey(RoomTempAddrKey key);

    int updateByPrimaryKeySelective(RoomTempAddr record);

    int updateByPrimaryKey(RoomTempAddr record);

    List<Map<String,Object>> getRoomTempList(Map<String,Object> map);
    Integer getRoomTempListCount(Map<String,Object> map);
    void addRoomTemp(Map<String,Object> map);
    void updateRoomTemp(Map<String,Object> map);
    Map<String,Object> getRoomTempAddr(Integer room_id);

    List<Map<String,Object>> getAllRoomTemp(Map<String,Object> condition);


    Integer getTempListOnlineCount(Map<String,Object> map);
    Integer getTempListOfflineCount(Map<String,Object> map);
}