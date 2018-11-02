package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.DeviceMapper;
import com.ps.net.model.Device;
import com.ps.net.service.ZoneDeviceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class ZoneDeviceServiceImpl implements ZoneDeviceService {
    @Resource
    private DeviceMapper deviceMapper;
    @Override
    public List<Map<String,Object>> getDeviceList(Map map)
    {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
        return deviceMapper.getDeviceList(map);
    }
    @Override
    public  Integer getDeviceListCount(Map<String,Object> map){
        return deviceMapper.getDeviceListCount(map);
    }

    @Override
    public Device getDevice(Integer device_net) {
        return deviceMapper.selectByPrimaryKey(device_net);
    }

    @Override
    public void addDeviceInfo(Device device) {
        deviceMapper.insertSelective(device);
    }

    @Override
    public void editDevice(Device device) {
        deviceMapper.updateByPrimaryKeySelective(device);
    }

    @Override
    public List<Map<String,Object>> getOnlineDevice(Map<String,Object> map){
      //  try{
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
            List<Map<String,Object>> list=deviceMapper.getDeviceListOnline(map);
            return list;
    }

    @Override
    public Integer getOnlineDeviceCount(Map<String,Object> map) {
        try{
            Integer count=deviceMapper.getDeviceListOnlineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public List<Map<String,Object>> getOfflineDevice(Map<String,Object> map) {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
            List<Map<String,Object>> list=deviceMapper.getDeviceListOffline(map);
            return list;

    }

    @Override
    public Integer getOfflineDeviceCount(Map<String,Object> map) {
        try{
           Integer count=deviceMapper.getDeviceListOfflineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public void deleteDevice(Integer device_net) {
        deviceMapper.deleteByPrimaryKey(device_net);
    }
}
