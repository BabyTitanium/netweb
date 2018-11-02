package com.ps.net.dao;

import com.ps.net.model.Functions;

import java.util.List;

public interface FunctionsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Functions record);

    int insertSelective(Functions record);

    Functions selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Functions record);

    int updateByPrimaryKey(Functions record);
    List<Functions> getFunctionByRole(Integer function_id);
}