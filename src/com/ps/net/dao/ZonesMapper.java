package com.ps.net.dao;

import com.ps.net.model.Zones;

import java.util.List;

public interface ZonesMapper {
    List<Zones> selectZonesList(Integer areaId);  //根据区域的ID找出所属小区信息列表
    void insertZones(Zones zones);   //插入一条小区信息（只包含上级ID跟名称）
    Zones selectZones(Integer id);//   根据ID找出对用小区
    void updateZones(Zones zones);//根据ID修改小区信息（名称跟地址）

}
