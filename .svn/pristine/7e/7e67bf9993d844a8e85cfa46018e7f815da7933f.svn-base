package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.controller.ZoneThermostatController;
import com.ps.net.dao.RoomThermostatAddrMapper;
import com.ps.net.service.ZoneRoomThermoService;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ZoneRoomThermoServiceImpl implements ZoneRoomThermoService {

    @Resource
    private RoomThermostatAddrMapper roomThermostatAddrMapper;

    @Override
    public List<Map<String, Object>> getRoomThermostatList(Map<String,Object> map) {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
        return roomThermostatAddrMapper.getRoomThermostatList(map);
    }

    @Override
    public Integer getRoomThermostatListCount(Map<String, Object> map) {
        return roomThermostatAddrMapper.getRoomThermostatListCount(map);
    }

    @Override
    public void addRoomThermostat(Map<String, Object> map) {
        roomThermostatAddrMapper.addRoomThermostat(map);
    }

    @Override
    public void updateRoomThermostat(Map<String, Object> map) {
        roomThermostatAddrMapper.updateRoomThermostat(map);
    }

    @Override
    public Map<String, Object> getRoomThermostatAddr(Integer room_id) {
        return roomThermostatAddrMapper.getRoomThermostatAddr(room_id);
    }


    @Override
    public List<Map<String, Object>> getAllRoomThermostat(Map<String,Object> condition) {
        return roomThermostatAddrMapper.getAllRoomThermostat(condition);
    }
    @Override
    public Integer getOnlineThermostatCount(Map<String,Object> map) {
        try{
            Integer count=roomThermostatAddrMapper.getThermostatListOnlineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public Integer getOfflineThermostatCount(Map<String,Object> map) {
        try{
            Integer count=roomThermostatAddrMapper.getThermostatListOfflineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

}
