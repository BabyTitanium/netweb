package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.RoomValveAddrMapper;
import com.ps.net.service.ZoneRoomValveService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
@Service
public class ZoneRoomValveServiceImpl implements ZoneRoomValveService {
@Resource
private RoomValveAddrMapper roomValveAddrMapper;

    @Override
    public List<Map<String, Object>> getRoomValveList(Map<String,Object> map) {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
        return roomValveAddrMapper.getRoomValveList(map);
    }

    @Override
    public Integer getRoomValveListCount(Map<String, Object> map) {
        return roomValveAddrMapper.getRoomValveListCount(map);
    }

    @Override
    public void addRoomValve(Map<String, Object> map) {
        roomValveAddrMapper.addRoomValve(map);
    }

    @Override
    public void updateRoomValve(Map<String, Object> map) {
        roomValveAddrMapper.updateRoomValve(map);
    }

    @Override
    public Map<String, Object> getRoomValveAddr(Integer room_id) {
        return roomValveAddrMapper.getRoomValveAddr(room_id);
    }

    @Override
    public List<Map<String, Object>> getAllRoomValve(Map<String,Object> condition) {
        return roomValveAddrMapper.getAllRoomValve(condition);
    }
    @Override
    public Integer getOnlineValveCount(Map<String,Object> map) {
        try{
            Integer count=roomValveAddrMapper.getValveListOnlineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public Integer getOfflineValveCount(Map<String,Object> map) {
        try{
            Integer count=roomValveAddrMapper.getValveListOfflineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }
}
