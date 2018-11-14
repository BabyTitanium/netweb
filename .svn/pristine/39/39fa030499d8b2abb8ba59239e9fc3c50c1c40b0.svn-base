package com.ps.net.service;

import com.ps.net.model.RoomDataSource;
import com.ps.net.model.ZoneOutTempSet;
import com.ps.net.model.ZoneRoomTempSet;
import com.ps.net.model.Zones;

import java.util.List;

public interface ZoneParameterService {
    Zones getZoneBasicInfo(Integer id);
    void updateZonesParameter(Zones zones);
    List<ZoneRoomTempSet> getInTempInfo(Integer zone_id);
    void addRoomTempSet(ZoneRoomTempSet zoneRoomTempSet);
    void editRoomTempSet(ZoneRoomTempSet zoneRoomTempSet);
    void deleteRoomTempSet(Integer id);

    List<ZoneOutTempSet> getOutTempInfo(Integer zone_id);
    void addOutTempSet(ZoneOutTempSet zoneOutTempSet);
    void editOutTempSet(ZoneOutTempSet zoneOutTempSet);
    void deleteOutTempSet(Integer id);
    RoomDataSource getDataSource(Integer zone_id);
    void addRoomDataSource(RoomDataSource roomDataSource);
    void updateRoomDataSource(RoomDataSource roomDataSource);
}
