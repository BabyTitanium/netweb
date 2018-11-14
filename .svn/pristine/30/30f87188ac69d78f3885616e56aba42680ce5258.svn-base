package com.ps.net.dao;

import com.ps.net.model.CustomType;
import com.ps.net.model.HeatType;

import java.util.List;
import java.util.Map;

public interface CustomTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomType record);

    int insertSelective(CustomType record);

    CustomType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomType record);

    int updateByPrimaryKey(CustomType record);
    List<CustomType> selectCustomTypeList(Map<String,Object> map);   //（根据查询条件）查询所有住户类型列表
    Integer selectCustomTypeListCount(Map<String,Object> map);//（根据查询条件）查询所有住户类型列表数量
    List<CustomType> selectByTypeName(Map map);   //根据住户类型名称查找住户类型列表
    List<CustomType> selectByTypeCode(Map map);  //根据住户类型编码查找住户类型
}