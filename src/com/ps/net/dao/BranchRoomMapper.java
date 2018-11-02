package com.ps.net.dao;

import com.ps.net.model.BranchRoom;

import java.util.List;
import java.util.Map;

public interface BranchRoomMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BranchRoom record);

    int insertSelective(BranchRoom record);

    BranchRoom selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BranchRoom record);

    int updateByPrimaryKey(BranchRoom record);
    List<Map<String,Object>> getBranchRoom(Map map);
    Integer getBranchRoomCount(Map map);
    void addBranchRoom(Map map);
    void batchDeleteBranchRoom(Integer branch_id);
}