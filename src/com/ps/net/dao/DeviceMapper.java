package com.ps.net.dao;

import com.ps.net.model.Device;

import java.util.List;
import java.util.Map;

public interface DeviceMapper {
    int deleteByPrimaryKey(Integer device_net);

    int insert(Device record);

    int insertSelective(Device record);

    Device selectByPrimaryKey(Integer device_net);

    int updateByPrimaryKeySelective(Device record);

    int updateByPrimaryKey(Device record);

    List<Map<String,Object>>  getDeviceList(Map map);
    List<Map<String,Object>> getDeviceListOnline(Map<String,Object> map);
    Integer getDeviceListOnlineCount(Map<String,Object> map);
    List<Map<String,Object>> getDeviceListOffline(Map<String,Object> map);
    Integer getDeviceListOfflineCount(Map<String,Object> map);
  //  List<Map<String,Object>>  getDeviceListNoPage();
    Integer  getDeviceListCount(Map<String,Object> map);
}