package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.RoomMeterAddrMapper;
import com.ps.net.dao.RoomsMapper;
import com.ps.net.service.ZoneRoomMeterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ZoneRoomMeterServiceImpl implements ZoneRoomMeterService {
    @Resource
    private RoomsMapper roomsMapper;
    @Resource
    private RoomMeterAddrMapper roomMeterAddrMapper;

    @Override
    public List<Map<String, Object>> getRoomMeterList(Map<String,Object> map) {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
        return roomMeterAddrMapper.getRoomMeterList(map);
    }

    @Override
    public Integer getRoomMeterListCount(Map<String, Object> map) {
        return roomMeterAddrMapper.getRoomMeterListCount(map);
    }

    @Override
    public void addRoomMeter(Map<String, Object> map) {
        roomMeterAddrMapper.addRoomMeter(map);
    }

    @Override
    public void updateRoomMeter(Map<String, Object> map) {
        roomMeterAddrMapper.updateRoomMeter(map);
    }

    @Override
    public Map<String, Object> getRoomMeterAddr(Integer room_id) {
        return roomMeterAddrMapper.getRoomMeterAddr(room_id);
    }

    @Override
    public List<Map<String, Object>> getAllRoomMeter(Map<String,Object> condition) {
        return roomMeterAddrMapper.getAllRoomMeter(condition);
    }

    @Override
    public Integer getOnlineMeterCount(Map<String,Object> map) {
        try{
            Integer count=roomMeterAddrMapper.getMeterListOnlineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public Integer getOfflineMeterCount(Map<String,Object> map) {
        try{
            Integer count=roomMeterAddrMapper.getMeterListOfflineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }
}
