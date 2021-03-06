package com.ps.net.dao;

import com.ps.net.model.BranchCompany;

import java.util.List;

public interface BranchCompanyMapper {
    List<BranchCompany> selectBranchCompanyList(Integer user_id);      //获取所有分公司列表
    void  insertBranchCompany(BranchCompany branchCompany);  //插入一条分公司信息（只有名称与上级ID）
    BranchCompany selectBranchCompany(Integer id);   //根据ID找出分公司信息
    void updateBranchCompany(BranchCompany branchCompany);//根据ID修改分公司信息（名称与地址）
}
