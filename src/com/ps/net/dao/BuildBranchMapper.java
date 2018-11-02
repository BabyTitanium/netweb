package com.ps.net.dao;

import com.ps.net.model.BuildBranch;
import com.ps.net.model.BuildBranchKey;

import java.util.List;
import java.util.Map;

public interface BuildBranchMapper {
    int deleteByPrimaryKey(BuildBranchKey key);

    int insert(BuildBranch record);

    int insertSelective(BuildBranch record);

    BuildBranch selectByPrimaryKey(BuildBranchKey key);

    int updateByPrimaryKeySelective(BuildBranch record);

    int updateByPrimaryKey(BuildBranch record);
    List<Map<String,Object>> selectBuildBranchNoSet(Map<String,Object> map);
    List<Map<String,Object>> getBuildBranches(Integer build_id);
}