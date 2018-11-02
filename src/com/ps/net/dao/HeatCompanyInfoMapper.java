package com.ps.net.dao;

import com.ps.net.model.HeatCompanyInfo;

public interface HeatCompanyInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(HeatCompanyInfo record);

    int insertSelective(HeatCompanyInfo record);

    HeatCompanyInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(HeatCompanyInfo record);

    int updateByPrimaryKey(HeatCompanyInfo record);
    HeatCompanyInfo getHeatCompanyInfo();
}