package com.ps.net.dao;

import com.ps.net.model.CustomType;
import com.ps.net.model.HeatType;

import java.util.List;
import java.util.Map;

public interface HeatTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(HeatType record);

    int insertSelective(HeatType record);

    HeatType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(HeatType record);

    int updateByPrimaryKey(HeatType record);

    List<HeatType> selectHeatTypeList(Map<String,Object> map);   //（根据查询条件）查询所有取暖类型列表

    Integer selectHeatTypeListCount(Map<String,Object> map);//（根据查询条件）查询所有取暖类型列表数量

    List<HeatType> selectByTypeName(Map map);   //根据住户类型名称查找住户类型列表
    List<HeatType> selectByTypeCode(Map map);  //根据住户类型编码查找住户类型
}