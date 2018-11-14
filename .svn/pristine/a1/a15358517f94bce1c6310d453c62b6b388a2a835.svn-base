package com.ps.net.service;

import com.ps.net.model.Device;

import javax.jws.Oneway;
import java.util.List;
import java.util.Map;

public interface ZoneDeviceService {
    List<Map<String,Object>> getDeviceList(Map map);
    Integer getDeviceListCount(Map<String,Object> map);
    Device getDevice(Integer device_net);
    void addDeviceInfo(Device device);
    void editDevice(Device device);
    List<Map<String,Object>>getOnlineDevice (Map<String,Object> map);
    Integer getOnlineDeviceCount(Map<String,Object> map);
    List<Map<String,Object>> getOfflineDevice(Map<String,Object> map);
    Integer getOfflineDeviceCount(Map<String,Object> map);
    void deleteDevice(Integer device_net);
}
