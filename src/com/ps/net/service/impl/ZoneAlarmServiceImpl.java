package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.AlarmsTypeMapper;
import com.ps.net.dao.ZoneAlarmValueMapper;
import com.ps.net.model.AlarmsType;
import com.ps.net.model.ZoneAlarmValue;
import com.ps.net.model.ZoneAlarmValueKey;
import com.ps.net.service.ZoneAlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ZoneAlarmServiceImpl implements ZoneAlarmService {
    @Resource
    private AlarmsTypeMapper alarmsTypeMapper;
    @Resource
    private ZoneAlarmValueMapper zoneAlarmValueMapper;
//    @Override
//    public List<Map<String,Object>> getAllAlarmsType() {
//        return alarmsTypeMapper.selectAll();
//    }

    @Override
    public void insertRecord(ZoneAlarmValue zoneAlarmValue) {
        zoneAlarmValueMapper.insertSelective(zoneAlarmValue);
    }

    @Override
    public List<Map<String, Object>> getAlarmList(Map<String, Object> map) {
        if(map.get("page")!=null&&map.get("limit")!=null) {
            map=Page.getData(map);
        }
    //    List<Map<String,Object>>list=zoneAlarmValueMapper.getAlarmList(map);
        List<Map<String,Object>> list=alarmsTypeMapper.selectAll(map);
//        for(int k=0;k<list.size();k++){
//            Map<String,Object> a=list.get(k);
//            String alarmCode=String.valueOf(a.get("alarm_code"));
//
//        }
        return list;
    }

    @Override
    public Integer getAlarmListCount(Map<String, Object> map) {
        return alarmsTypeMapper.selectAllCount();
    }

    @Override
    public void updateZoneAlarm(Map<String, Object> map) {
        zoneAlarmValueMapper.updateByPrimaryKeySelective(map);
    }

    @Override
    public ZoneAlarmValue getZoneAlarmValue(ZoneAlarmValueKey zoneAlarmValueKey) {
        return zoneAlarmValueMapper.selectByPrimaryKey(zoneAlarmValueKey);
    }

    @Override
    public void addAlarmValue(Map map) {
        zoneAlarmValueMapper.addAlarmValue(map);
    }
}
