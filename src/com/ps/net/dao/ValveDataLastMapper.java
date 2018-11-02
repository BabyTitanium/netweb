package com.ps.net.dao;

import com.ps.net.model.ValveDataLast;

public interface ValveDataLastMapper {
    int deleteByPrimaryKey(String valve_addr);

    int insert(ValveDataLast record);

    int insertSelective(ValveDataLast record);

    ValveDataLast selectByPrimaryKey(String valve_addr);

    int updateByPrimaryKeySelective(ValveDataLast record);

    int updateByPrimaryKey(ValveDataLast record);
}