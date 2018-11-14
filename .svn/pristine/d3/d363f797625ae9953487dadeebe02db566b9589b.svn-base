package com.ps.net.service;

import com.ps.net.model.RoomLocation;

import java.util.List;
import java.util.Map;

public interface RoomLocationService {
    List<RoomLocation> getRoomLocationList(Integer page,Integer limit,String code,String location);
    Integer getRoomLocationListCount(String code,String location);
    void addRoomLocation(RoomLocation roomLocation);
    List<RoomLocation> checkCodeExist(Map<String,Object> map);
    List<RoomLocation> checkLocationExist(Map<String,Object> map);
    RoomLocation getRoomLocation(Integer id);
    void editRoomLocation(RoomLocation roomLocation);
    void deleteRoomLocation(Integer id);
}
