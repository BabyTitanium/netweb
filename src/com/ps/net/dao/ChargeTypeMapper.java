package com.ps.net.dao;

import com.ps.net.model.ChargeType;

import java.util.List;
import java.util.Map;

public interface ChargeTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ChargeType record);

    int insertSelective(ChargeType record);

    ChargeType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ChargeType record);

    int updateByPrimaryKey(ChargeType record);


    List<ChargeType> selectChargeTypeList(Map<String,Object> map);    //（根据条件)查找收费方式列表
    Integer selectChargeTypeListCount(Map<String,Object> map);    //（根据条件)查找收费方式列表数量
    List<ChargeType> nameCheck(Map<String,Object> map);//名称验重
    List<ChargeType> codeCheck(Map<String,Object> map);//编码验重

}