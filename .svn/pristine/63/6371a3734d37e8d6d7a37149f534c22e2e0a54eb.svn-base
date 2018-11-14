package com.ps.net.dao;

import com.ps.net.model.BranchHeatInfo;

import javax.jws.Oneway;
import java.util.Map;

public interface BranchHeatInfoMapper {
    int deleteByPrimaryKey(Integer branch_id);

    int insert(BranchHeatInfo record);

    int insertSelective(BranchHeatInfo record);

    BranchHeatInfo selectByPrimaryKey(Integer branch_id);

    int updateByPrimaryKeySelective(BranchHeatInfo record);

    int updateByPrimaryKey(BranchHeatInfo record);
    Map<String,Object> getBranchHeatInfo(Integer branch_id);//根据branch_id找出分支供暖信息
}