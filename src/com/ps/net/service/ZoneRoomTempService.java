package com.ps.net.service;

import java.util.List;
import java.util.Map;

public interface ZoneRoomTempService {
    List<Map<String,Object>> getRoomTempList(Map<String,Object> map);
    Integer getRoomTempListCount(Map<String,Object> map);
    void addRoomTemp(Map<String,Object> map);
    void updateRoomTemp(Map<String,Object> map);
    Map<String,Object> getRoomTempAddr(Integer room_id);

    List<Map<String,Object>> getAllRoomTemp(Map<String,Object> map);
    Integer getOnlineTempCount(Map<String,Object> map);
    Integer getOfflineTempCount(Map<String,Object> map);
}
