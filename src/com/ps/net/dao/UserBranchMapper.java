package com.ps.net.dao;

import com.ps.net.model.UserBranch;

public interface UserBranchMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserBranch record);

    int insertSelective(UserBranch record);

    UserBranch selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserBranch record);

    int updateByPrimaryKey(UserBranch record);
}