package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.RoomTempAddrMapper;
import com.ps.net.dao.RoomTempAddrMapper;
import com.ps.net.service.ZoneRoomTempService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ZoneRoomTempServiceImpl implements ZoneRoomTempService {

    @Resource
    private RoomTempAddrMapper roomTempAddrMapper;

    @Override
    public List<Map<String, Object>> getRoomTempList(Map<String,Object> map) {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
        return roomTempAddrMapper.getRoomTempList(map);
    }

    @Override
    public Integer getRoomTempListCount(Map<String, Object> map) {
        return roomTempAddrMapper.getRoomTempListCount(map);
    }

    @Override
    public void addRoomTemp(Map<String, Object> map) {
        roomTempAddrMapper.addRoomTemp(map);
    }

    @Override
    public void updateRoomTemp(Map<String, Object> map) {
        roomTempAddrMapper.updateRoomTemp(map);
    }

    @Override
    public Map<String, Object> getRoomTempAddr(Integer room_id) {
        return roomTempAddrMapper.getRoomTempAddr(room_id);
    }


    @Override
    public List<Map<String, Object>> getAllRoomTemp(Map<String,Object> condition) {
        return roomTempAddrMapper.getAllRoomTemp(condition);
    }
    @Override
    public Integer getOnlineTempCount(Map<String,Object> map) {
        try{
            Integer count=roomTempAddrMapper.getTempListOnlineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public Integer getOfflineTempCount(Map<String,Object> map) {
        try{
            Integer count=roomTempAddrMapper.getTempListOfflineCount(map);
            return count;
        }catch (Exception e){
            return null;
        }
    }
}
