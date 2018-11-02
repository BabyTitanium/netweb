package com.ps.net.service;

import com.ps.net.model.AlarmsType;
import com.ps.net.model.ZoneAlarmValue;
import com.ps.net.model.ZoneAlarmValueKey;

import javax.xml.ws.Service;
import java.util.List;
import java.util.Map;

public interface ZoneAlarmService {
//    List<Map<String,Object>> getAllAlarmsType();
    void insertRecord(ZoneAlarmValue zoneAlarmValue);
    List<Map<String,Object>> getAlarmList(Map<String,Object> map);
   Integer getAlarmListCount(Map<String,Object> map);
   void updateZoneAlarm(Map<String,Object> map);
   ZoneAlarmValue getZoneAlarmValue(ZoneAlarmValueKey zoneAlarmValueKey);
   void addAlarmValue(Map map);
}
