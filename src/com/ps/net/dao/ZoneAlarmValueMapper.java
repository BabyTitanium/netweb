package com.ps.net.dao;

import com.ps.net.model.ZoneAlarmValue;
import com.ps.net.model.ZoneAlarmValueKey;

import java.util.List;
import java.util.Map;

public interface ZoneAlarmValueMapper {
    int deleteByPrimaryKey(ZoneAlarmValueKey key);

    int insert(ZoneAlarmValue record);

    int insertSelective(ZoneAlarmValue record);

    ZoneAlarmValue selectByPrimaryKey(ZoneAlarmValueKey key);

    int updateByPrimaryKeySelective(Map record);

    int updateByPrimaryKey(ZoneAlarmValue record);

    List<Map<String,Object>> getAlarmList(Map<String,Object> map);

    Integer getAlarmListCount(Map<String,Object> map);

    public void addAlarmValue(Map map);
}