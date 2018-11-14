package com.ps.net.dao;

import com.ps.net.model.Units;

import java.util.List;
import java.util.Map;

public interface UnitsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Units record);

    int insertSelective(Units record);

    Units selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Units record);

    int updateByPrimaryKey(Units record);

    Map<String,Object> checkUnit(Map<String,Object> map);

    Integer addUnit(Map<String,Object>map);

    List<Map<String,Object>> getUnitsListByBuilding(Integer build_id);
}