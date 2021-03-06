package com.ps.net.controller;

import com.ps.net.changeObject.ExtraMethod;
import com.ps.net.model.Device;
import com.ps.net.service.ZoneDeviceService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("device")
public class DeviceController {
    @Autowired
    private ZoneDeviceService zoneDeviceService;

    @RequestMapping(value = "device")
    @RequiresPermissions("device")
    public String device(){
        return "device";
    }
    @RequestMapping(value ="deviceList")
    @RequiresPermissions("device")
    public @ResponseBody
    Map<String,Object> deviceList(@RequestParam Map map){
        try {
            List<Map<String,Object>> list=zoneDeviceService.getDeviceList(map);
            //转换时间
            for(int i=0;i<list.size();i++){
                Map<String,Object> device1=list.get(i);
                if(device1.get("heart_time")!=null){
                    String d=String.valueOf(device1.get("heart_time"));
                    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String date=simpleDateFormat.format(simpleDateFormat.parse(d));
                    device1.put("heart_time",date);
                }

            }
            Integer count=zoneDeviceService.getDeviceListCount(map);
            return ExtraMethod.returnList(list,count);
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value = "checkDeviceNet")
    @RequiresPermissions("device")
    public @ResponseBody Map<String,Object> checkDeviceNet(Integer device_net){
        try{
            Map<String,Object> map=new HashMap<>();
            Device device=zoneDeviceService.getDevice(device_net);
            if(device==null){
                map.put("state","success");
            }else{
                map.put("state","error");
            }
            return map;
        }catch (Exception e){
            return null;
        }
    }

    @RequestMapping(value = "addDeviceInfo")
    @RequiresPermissions("device")
    public @ResponseBody Map<String,Object> addDeviceInfo(Device device){
        try{
            Map<String,Object> map=new HashMap<>();
            zoneDeviceService.addDeviceInfo(device);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getDeviceInfo")
    @RequiresPermissions("device")
    public @ResponseBody Device getDeviceInfo(Integer device_net){
        try {
            return zoneDeviceService.getDevice(device_net);
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "editDevice")
    @RequiresPermissions("device")
    public @ResponseBody Map<String,Object> editDevice(Device device){
        try{
            Map<String,Object> map=new HashMap<>();
            zoneDeviceService.editDevice(device);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getDeviceCount")
    @RequiresPermissions("device")
    public @ResponseBody Map<String,Object> getDeviceCount(){
        try {
            Map condition=new HashMap();
            Integer all=zoneDeviceService.getDeviceListCount(condition);
            Integer online=zoneDeviceService.getOnlineDeviceCount(condition);
            Integer offline=zoneDeviceService.getOfflineDeviceCount(condition);
            Map<String,Object> map=new HashMap<>();
            map.put("all",all);
            map.put("online",online);
            map.put("offline",offline);
            return  map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value ="onlineDeviceList")
    @RequiresPermissions("device")
    public @ResponseBody  Map<String,Object> onlineDeviceList(@RequestParam Map map){
        try {
            List<Map<String,Object>> list=zoneDeviceService.getOnlineDevice(map);
            //转换时间
            for(int i=0;i<list.size();i++){
                Map<String,Object> device1=list.get(i);
                if(device1.get("heart_time")!=null){
                    String d=String.valueOf(device1.get("heart_time"));
                    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String date=simpleDateFormat.format(simpleDateFormat.parse(d));
                    device1.put("heart_time",date);
                }

            }
            Integer count=zoneDeviceService.getOnlineDeviceCount(map);
            return ExtraMethod.returnList(list,count);
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value ="offlineDeviceList")
    @RequiresPermissions("device")
    public @ResponseBody  Map<String,Object> offlineDeviceList(@RequestParam Map map){
        try {
            List<Map<String,Object>> list=zoneDeviceService.getOfflineDevice(map);
            //转换时间
            for(int i=0;i<list.size();i++){
                Map<String,Object> device1=list.get(i);
                if(device1.get("heart_time")!=null){
                    String d=String.valueOf(device1.get("heart_time"));
                    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String date=simpleDateFormat.format(simpleDateFormat.parse(d));
                    device1.put("heart_time",date);
                }

            }
            Integer count=zoneDeviceService.getOfflineDeviceCount(map);
            return ExtraMethod.returnList(list,count);
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value = "deleteDevice")
    @RequiresPermissions("device")
    public @ResponseBody Map<String,Object> deleteDevice(Integer device_net){
        try {
            zoneDeviceService.deleteDevice(device_net);
            Map<String,Object> map=new HashMap<>();
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
}
