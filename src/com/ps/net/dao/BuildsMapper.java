package com.ps.net.dao;

import com.ps.net.model.Builds;

import java.util.List;
import java.util.Map;

public interface BuildsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Builds record);

    int insertSelective(Builds record);

    Builds selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Builds record);

    int updateByPrimaryKey(Builds record);
    List<Map<String,Object>> getByZoneId(Integer zone_id); //根据小区ID找出楼栋列表
    Integer addBuilding(Map<String,Object> map);//添加楼栋信息并且返回ID
    Map<String,Object>  checkBuilding(Map<String,Object> map);
    List<Map<String,Object>> getBuildingList(Map<String,Object> map);
   Integer getBuildingListCount(Map<String,Object> map);
   void updateBuilding(Map<String,Object> map);
}