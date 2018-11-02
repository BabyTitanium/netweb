package com.ps.net.dao;

import com.ps.net.model.RoleFunction;
import com.ps.net.model.RoleFunctionKey;

import java.util.List;
import java.util.function.Function;

public interface RoleFunctionMapper {
    int deleteByPrimaryKey(RoleFunctionKey key);

    int insert(RoleFunction record);

    int insertSelective(RoleFunction record);

    RoleFunction selectByPrimaryKey(RoleFunctionKey key);

    int updateByPrimaryKeySelective(RoleFunction record);

    int updateByPrimaryKey(RoleFunction record);

    void deleteByRole(Integer role_id);

}