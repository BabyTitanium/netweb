package com.ps.net.dao;

import com.ps.net.model.ValveModel;

import java.util.List;
import java.util.Map;

public interface ValveModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ValveModel record);

    int insertSelective(ValveModel record);

    ValveModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ValveModel record);

    int updateByPrimaryKey(ValveModel record);

    List<ValveModel> selectValveModelList(Map<String,Object> map);//（根据条件）查找阀门类型列表

    Integer selectValveModelListCount(Map<String,Object> map);//查找列表数目

    List<ValveModel> selectByModelName(Map map);  //根据名称查找
}