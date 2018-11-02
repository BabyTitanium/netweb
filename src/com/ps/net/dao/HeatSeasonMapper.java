package com.ps.net.dao;

import com.ps.net.model.HeatSeason;

import java.util.List;
import java.util.Map;

public interface HeatSeasonMapper {
    int deleteByPrimaryKey(Integer season_id);

    int insert(HeatSeason record);

    int insertSelective(HeatSeason record);

    HeatSeason selectByPrimaryKey(Integer season_id);

    int updateByPrimaryKeySelective(HeatSeason record);

    int updateByPrimaryKey(HeatSeason record);
    List<Map<String,Object>> selectHeatSeasonList(Map<String,Object> map);//查找供暖季列表（或者根据条件搜索）
    Integer selectHeatSeasonListCount(Map<String,Object> map);//查找供暖季列表数目
    List<HeatSeason> selectByTypeName(Map map);  //根据名称查找供暖季列表
    Map<String,Object> selectById(Integer id);  //根据id查找供暖季（返回类型是Map是为了避免时间格式改变问题）
    void updateHeatSeason(Map<String,Object> heatSeason);//根据id更新供暖季信息，Map是为了解决时间问题
    void insertHeatSeason(Map<String,Object> heatSeason);//插入一条数据
}