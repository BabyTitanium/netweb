package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.RoomLocationMapper;
import com.ps.net.model.RoomLocation;
import com.ps.net.service.RoomLocationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoomLocationServiceImpl implements RoomLocationService {
    @Resource
    private RoomLocationMapper roomLocationMapper;
    @Override
    public List<RoomLocation> getRoomLocationList(Integer page, Integer limit, String code, String location){
        Map<String,Object> map =new HashMap<>();
        if(page!=null && limit!=null){
            map.put("page",page);
            map.put("limit",limit);
            map=Page.getData(map);
        }
        map.put("code",code);
        map.put("location",location);
        return roomLocationMapper.selectRoomLocationList(map);
    }
    @Override
    public Integer getRoomLocationListCount( String code, String location){
        Map<String,Object> map =new HashMap<>();
        map.put("code",code);
        map.put("location",location);
        return roomLocationMapper.selectRoomLocationListCount(map);
    }
    @Override
    public void addRoomLocation(RoomLocation roomLocation) {
        roomLocationMapper.insertSelective(roomLocation);
    }

    @Override
    public List<RoomLocation> checkCodeExist(Map<String, Object> map) {
        return roomLocationMapper.checkCodeExist(map);
    }
    @Override
    public List<RoomLocation> checkLocationExist(Map<String, Object> map) {
        return roomLocationMapper.checkLocationExist(map);
    }

    @Override
    public RoomLocation getRoomLocation(Integer id) {
        return roomLocationMapper.selectByPrimaryKey(id);
    }

    @Override
    public void editRoomLocation(RoomLocation roomLocation) {
        roomLocationMapper.updateByPrimaryKeySelective(roomLocation);
    }

    @Override
    public void deleteRoomLocation(Integer id) {
        roomLocationMapper.deleteByPrimaryKey(id);
    }
}
