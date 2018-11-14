package com.ps.net.service;

import com.ps.net.model.Branchs;

import java.util.List;
import java.util.Map;

public interface ZoneBranchService {
    List<Map<String,Object>> getBranchList(Map<String,Object> map);
    Integer getBranchListCount(Map<String,Object> map);
    void addBranch(Map<String,Object> map);
    Branchs getBranch(Integer id);
    void changeBranchInfo(Map<String,Object> branch);
    void  deleteBranchInfo(Integer id);
    Map<String,Object> checkBranch(Map<String,Object> map);
    List<Map<String,Object>> getBranchRoom(Map map);
    void addBranchRoom(Map<String,Object> map);
    void batchDeleteBranchRoom(Integer branch_id);
    void addBranchHeatInfo(Integer branch_id);
    void updateBranchHeatInfo(Integer branch_id);
    List<Map<String,Object>> getBuildBranchNoSet(Map<String,Object> map);
}
