package com.ps.net.dao;

import com.ps.net.model.Branchs;

import java.util.List;
import java.util.Map;

public interface BranchsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Branchs record);

    int insertSelective(Branchs record);

    Branchs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Map<String,Object> record);

    int updateByPrimaryKey(Branchs record);
    List<Map<String,Object>> getBranchList(Map map);
   Integer getBranchListCount(Map map);
   void addBranch(Map<String,Object> map);
   Map<String,Object> checkBranch(Map map);
}