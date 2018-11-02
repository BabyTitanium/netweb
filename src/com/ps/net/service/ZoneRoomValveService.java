package com.ps.net.service;

import java.util.List;
import java.util.Map;

public interface ZoneRoomValveService {
    List<Map<String,Object>> getRoomValveList(Map<String,Object> map);
    Integer getRoomValveListCount(Map<String,Object> map);
    void addRoomValve(Map<String,Object> map);
    void updateRoomValve(Map<String,Object> map);
    Map<String,Object> getRoomValveAddr(Integer room_id);
    List<Map<String,Object>> getAllRoomValve(Map<String,Object> map);
    Integer getOnlineValveCount(Map<String,Object> map);
    Integer getOfflineValveCount(Map<String,Object> map);
}
