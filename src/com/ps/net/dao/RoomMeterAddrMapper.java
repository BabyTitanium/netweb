package com.ps.net.dao;

import com.ps.net.model.MeterDataLast;
import com.ps.net.model.RoomMeterAddr;

import javax.xml.ws.Service;
import java.util.List;
import java.util.Map;

public interface RoomMeterAddrMapper {
    int deleteByPrimaryKey(Integer room_id);

    int insert(RoomMeterAddr record);

    int insertSelective(RoomMeterAddr record);

    RoomMeterAddr selectByPrimaryKey(Integer room_id);

    int updateByPrimaryKeySelective(RoomMeterAddr record);

    int updateByPrimaryKey(RoomMeterAddr record);
    List<Map<String,Object>> getRoomMeterList(Map<String,Object> map);
    Integer getRoomMeterListCount(Map<String,Object> map);
    void addRoomMeter(Map<String,Object> map);
    void updateRoomMeter(Map<String,Object> map);
    Map<String,Object> getRoomMeterAddr(Integer room_id);
    List<Map<String,Object>> getAllRoomMeter(Map<String,Object> condition);


    Integer getMeterListOnlineCount(Map<String,Object> map);
    Integer getMeterListOfflineCount(Map<String,Object> map);
}