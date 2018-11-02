package com.ps.net.dao;

import com.ps.net.model.ValveInfo;
import sun.applet.resources.MsgAppletViewer;

import java.util.Map;

public interface ValveInfoMapper {
    int deleteByPrimaryKey(String valve_addr);

    int insert(ValveInfo record);

    int insertSelective(ValveInfo record);

    ValveInfo selectByPrimaryKey(String valve_addr);

    int updateByPrimaryKeySelective(ValveInfo record);

    int updateByPrimaryKey(ValveInfo record);

    int updateValveInfo(Map record);
    int insertValveInfo(Map record);
}