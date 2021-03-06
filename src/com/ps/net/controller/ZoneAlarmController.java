package com.ps.net.controller;

import com.ps.net.changeObject.ExtraMethod;
import com.ps.net.model.ZoneAlarmValue;
import com.ps.net.model.ZoneAlarmValueKey;
import com.ps.net.service.ZoneAlarmService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping("sysIndex")
public class ZoneAlarmController {
    @Autowired
    ZoneAlarmService zoneAlarmService;
    @RequestMapping("alarmsList")
    @RequiresPermissions("sysIndex")
    public @ResponseBody
    Map<String,Object> getAlarmList(@RequestParam Map<String,Object> map){
        try {
            List<Map<String,Object>> list=zoneAlarmService.getAlarmList(map);
            Integer count=zoneAlarmService.getAlarmListCount(map);
             for(int k=0;k<list.size();k++){
                 Map<String,Object> a=list.get(k);
                 String alarmCode=String.valueOf(a.get("alarm_code"));
                 ZoneAlarmValueKey zoneAlarmValueKey=new ZoneAlarmValueKey();
                 zoneAlarmValueKey.setAlarm_code(alarmCode);
                 zoneAlarmValueKey.setZone_id(Integer.parseInt(String.valueOf(map.get("zone_id"))));
                 ZoneAlarmValue zoneAlarmValue=zoneAlarmService.getZoneAlarmValue(zoneAlarmValueKey);
                 if(zoneAlarmValue!=null){
                     a.put("available",zoneAlarmValue.getAvailable());
                     a.put("alarm_value",zoneAlarmValue.getAlarm_value());
                 }
                 else {
                     a.put("available","1");
                     a.put("alarm_value","");
                 }
        }
        return ExtraMethod.returnList(list,count);
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "editAlarmValue")
    @RequiresPermissions("sysIndex")
    public @ResponseBody Map<String,Object> editAlarmValue(@RequestParam Map<String,Object> map){
        try {
            Map<String,Object> result=new HashMap<>();
            Integer zone_id=Integer.parseInt(String.valueOf(map.get("zone_id")));
            String alarmCode=String.valueOf(map.get("alarm_code"));
            ZoneAlarmValueKey zoneAlarmValueKey=new ZoneAlarmValueKey();
            zoneAlarmValueKey.setAlarm_code(alarmCode);
            zoneAlarmValueKey.setZone_id(Integer.parseInt(String.valueOf(map.get("zone_id"))));
            ZoneAlarmValue zoneAlarmValue=zoneAlarmService.getZoneAlarmValue(zoneAlarmValueKey);
            if(zoneAlarmValue!=null){
                zoneAlarmService.updateZoneAlarm(map);
            }
            else {
                zoneAlarmService.addAlarmValue(map);
            }

            result.put("state","success");
            return  result;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping("alarmsInfoPage")
    @RequiresPermissions("sysIndex")
    public String index(Integer id, ModelMap map){
        map.addAttribute("id",id);
        return "zoneAlarm";
    }
}
