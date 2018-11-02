package com.ps.net.dao;

import com.ps.net.model.RoomLocation;

import java.util.List;
import java.util.Map;

public interface RoomLocationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RoomLocation record);

    int insertSelective(RoomLocation record);

    RoomLocation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoomLocation record);

    int updateByPrimaryKey(RoomLocation record);
    List<RoomLocation> selectRoomLocationList(Map<String,Object> map);//（根据条件）查找房屋列表
    Integer selectRoomLocationListCount(Map<String,Object> map);//（根据条件）查找房屋列表数量
    List<RoomLocation> checkCodeExist(Map<String,Object> map);//编号重复检验
    List<RoomLocation> checkLocationExist(Map<String,Object> map);//名称重复检验
}