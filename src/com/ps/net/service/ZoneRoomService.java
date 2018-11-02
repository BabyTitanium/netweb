package com.ps.net.service;

import com.ps.net.model.Builds;
import org.omg.CORBA.OBJ_ADAPTER;

import java.util.List;
import java.util.Map;

public interface ZoneRoomService {
    List<Map<String,Object>> getBuildingsByZoneId(Integer zone_id);
    List<Map<String,Object>> getBuildingRoomsList(Map<String,Object> map);
    Integer getBuildingRoomsListCount(Map<String,Object> map);
    void addRoomInfo(Map<String,Object> map);
    Map<String,Object> checkUnit(Map<String,Object> map);
    Map<String,Object> checkRoom(Map<String,Object> map);
    Integer addUnit(Map<String,Object> map);
    void  deleteRoom(Integer id);
    Map<String,Object> getRoomInfo(Integer id);
    void changeRoomInfo(Map<String,Object> map);
    void batchEditRoom(Integer[] ids,Map<String,Object> map);
    void batchDeleteRoom(Integer[] ids);
//    void batchImportRoomInfo(List<Map<String,Object>> list);
}
