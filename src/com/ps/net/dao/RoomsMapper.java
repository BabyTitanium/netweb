package com.ps.net.dao;

import com.ps.net.model.Rooms;

import java.util.List;
import java.util.Map;

public interface RoomsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Rooms record);

    int insertSelective(Map record);

    Rooms selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Rooms record);

    int updateByPrimaryKey(Rooms record);

    List<Rooms> findByUserType(Integer user_type);//根据住户类型查找

    List<Rooms> findByHeatType(Integer heat_type);//根据供暖类型查找

    List<Rooms> roomLocationExist(Integer location);//根据房屋位置id查找房屋列表

    List<Map<String,Object>> getBuildingRoomsList(Map<String,Object> map);
    Integer getBuildingRoomsListCount(Map<String,Object> map);
    Map<String,Object> getRoomInfo(Integer id);
    void changeRoomInfo(Map<String,Object> map);

    Map<String,Object> checkRoom(Map<String,Object> map);
   List<Map<String,Object>> roomsList(Integer unit_id);
}