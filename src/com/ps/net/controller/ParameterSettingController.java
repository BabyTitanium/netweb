package com.ps.net.controller;

import com.ps.net.model.RoomDataSource;
import com.ps.net.model.ZoneOutTempSet;
import com.ps.net.model.ZoneRoomTempSet;
import com.ps.net.model.Zones;
import com.ps.net.service.ZoneParameterService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("sysIndex")
public class ParameterSettingController {
    @Autowired
    private ZoneParameterService zoneParameterService;

    @RequestMapping(value = "getZoneBasicInfo")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Zones getZoneBasicInfo(Integer zone_id){
        try{
            return zoneParameterService.getZoneBasicInfo(zone_id);
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "zoneBasicInfo",method = RequestMethod.POST)
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map zoneBasicInfo( Zones zones){
        try{
            zoneParameterService.updateZonesParameter(zones);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return  map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getInTempInfo")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public List<ZoneRoomTempSet> getInTempInfo(Integer zone_id){
        try{
            List<ZoneRoomTempSet> list=zoneParameterService.getInTempInfo(zone_id);
            return  list;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value="addRoomTemp")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map addRoomTemp(ZoneRoomTempSet zoneRoomTempSet){
        try{
            zoneParameterService.addRoomTempSet(zoneRoomTempSet);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "editRoomTemp")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map editRoomTemp(ZoneRoomTempSet zoneRoomTempSet){
        try{
            zoneParameterService.editRoomTempSet(zoneRoomTempSet);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value="deleteRoomTemp")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map deleteRoomTemp(Integer id){
        try{
            zoneParameterService.deleteRoomTempSet(id);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }

    @RequestMapping(value = "getOutTempInfo")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public List<ZoneOutTempSet> getOutTempInfo(Integer zone_id){
        try{
            List<ZoneOutTempSet> list=zoneParameterService.getOutTempInfo(zone_id);
            return  list;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value="addOutTemp")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map addOutTemp(ZoneOutTempSet zoneOutTempSet){
        try{
            zoneParameterService.addOutTempSet(zoneOutTempSet);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "editOutTemp")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map editOutTemp(ZoneOutTempSet zoneOutTempSet){
        try{
            zoneParameterService.editOutTempSet(zoneOutTempSet);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value="deleteOutTemp")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map deleteOutTemp(Integer id){
        try{
            zoneParameterService.deleteOutTempSet(id);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }

    @RequestMapping("getDataSource")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public RoomDataSource getDataSource(Integer zone_id){
        try{
            return zoneParameterService.getDataSource(zone_id);
        }catch (Exception e){
            return null;
        }
    }

    @RequestMapping("submitDataSource")
    @RequiresPermissions("sysIndex")
    @ResponseBody
    public Map submitDataSource(RoomDataSource roomDataSource){
        try{
            roomDataSource.setUpdate_time(new Date());
            RoomDataSource roomDataSource1=zoneParameterService.getDataSource(roomDataSource.getZone_id());
            if(roomDataSource1!=null){
                zoneParameterService.updateRoomDataSource(roomDataSource);
            }else{
                zoneParameterService.addRoomDataSource(roomDataSource);

            }
            Map<String,Object> map=new HashMap();
             map.put("state","success");
             return  map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping("parameterSettingPage")
    @RequiresPermissions("sysIndex")
    public String index(Integer id, ModelMap map){
        map.addAttribute("id",id);
        return "zoneParameter";
    }
}
