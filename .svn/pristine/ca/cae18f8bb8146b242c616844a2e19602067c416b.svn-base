package com.ps.net.service.impl;

import com.ps.net.dao.RoomDataSourceMapper;
import com.ps.net.dao.ZoneOutTempSetMapper;
import com.ps.net.dao.ZoneRoomTempSetMapper;
import com.ps.net.dao.ZonesMapper;
import com.ps.net.model.RoomDataSource;
import com.ps.net.model.ZoneOutTempSet;
import com.ps.net.model.ZoneRoomTempSet;
import com.ps.net.model.Zones;
import com.ps.net.service.ZoneParameterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZoneParameterServiceImpl implements ZoneParameterService {
    @Autowired
    private ZonesMapper zonesMapper;
    @Autowired
    private ZoneRoomTempSetMapper zoneRoomTempSetMapper;
    @Autowired
    private ZoneOutTempSetMapper zoneOutTempSetMapper;
    @Autowired
    private RoomDataSourceMapper roomDataSourceMapper;

    @Override
    public Zones getZoneBasicInfo(Integer id){
        return zonesMapper.selectZones(id);
    }

    @Override
    public void updateZonesParameter(Zones zones) {
        zonesMapper.updateZones(zones);
    }

    @Override
    public List<ZoneRoomTempSet> getInTempInfo(Integer zone_id) {
        return zoneRoomTempSetMapper.getInTempInfo(zone_id);
    }

    @Override
    public void addRoomTempSet(ZoneRoomTempSet zoneRoomTempSet) {
        zoneRoomTempSetMapper.insertSelective(zoneRoomTempSet);
    }

    @Override
    public void editRoomTempSet(ZoneRoomTempSet zoneRoomTempSet) {
        zoneRoomTempSetMapper.updateByPrimaryKeySelective(zoneRoomTempSet);
    }

    @Override
    public void deleteRoomTempSet(Integer id) {
        zoneRoomTempSetMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<ZoneOutTempSet> getOutTempInfo(Integer zone_id) {
        return zoneOutTempSetMapper.getOutTempInfo(zone_id);
    }

    @Override
    public void addOutTempSet(ZoneOutTempSet zoneOutTempSet) {
        zoneOutTempSetMapper.insertSelective(zoneOutTempSet);
    }

    @Override
    public void editOutTempSet(ZoneOutTempSet zoneOutTempSet) {
        zoneOutTempSetMapper.updateByPrimaryKeySelective(zoneOutTempSet);
    }

    @Override
    public void deleteOutTempSet(Integer id) {
        zoneOutTempSetMapper.deleteByPrimaryKey(id);
    }

    @Override
    public RoomDataSource getDataSource(Integer zone_id) {
        return roomDataSourceMapper.selectByPrimaryKey(zone_id) ;
    }

    @Override
    public void addRoomDataSource(RoomDataSource roomDataSource){
        roomDataSourceMapper.insertSelective(roomDataSource);
    }

    @Override
    public void updateRoomDataSource(RoomDataSource roomDataSource) {
        roomDataSourceMapper.updateByPrimaryKeySelective(roomDataSource);
    }
}
