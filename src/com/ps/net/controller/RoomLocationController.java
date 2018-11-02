package com.ps.net.controller;

import com.ps.net.dao.RoomsMapper;
import com.ps.net.model.RoomLocation;
import com.ps.net.model.Rooms;
import com.ps.net.service.RoomLocationService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("roomLocation")
public class RoomLocationController {
    @Autowired
    private RoomLocationService roomLocationService;
    @Autowired
    private RoomsMapper roomsMapper;
    @RequestMapping(value = "roomLocation")
    @RequiresPermissions("roomLocation")
    public String roomLocation(){
        return "roomLocation";
    }
    @RequestMapping(value = "roomLocationList")
    @RequiresPermissions("roomLocation")
    public @ResponseBody
    Map<String,Object> roomLocationList(Integer page,Integer limit,String code,String location){
        try {
            if(code==""){
                code=null;
            }
            if(location==""){
                location=null;
            }
            Map<String,Object> map=new HashMap<>();
            List<RoomLocation> list=roomLocationService.getRoomLocationList(page,limit,code,location);
            Integer count=roomLocationService.getRoomLocationListCount(code,location);
            map.put("code", 0);
            map.put("msg", "");
            map.put("data", list);
            map.put("count",count);
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "roomLocationCodeCheck")
    @RequiresPermissions("roomLocation")
    public @ResponseBody Map<String,String> roomLocationCodeCheck(Integer id,String code){
        Map<String,Object> map=new HashMap<>();
        map.put("id",id);
        map.put("code",code);
        Map<String,String> result=new HashMap<>();
        try {
            List<RoomLocation> list=roomLocationService.checkCodeExist(map);
            if(list.size()<=0){
                result.put("state","success");
            }else
                result.put("state","error");
            return result;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "roomLocationCheck")
    @RequiresPermissions("roomLocation")
    public @ResponseBody Map<String,String> roomLocationCheck(Integer id,String location){
        Map<String,Object> map=new HashMap<>();
        map.put("id",id);
        map.put("location",location);
        Map<String,String> result=new HashMap<>();
        try {
            List<RoomLocation> list=roomLocationService.checkLocationExist(map);
            if(list.size()<=0){
                result.put("state","success");
            }else
                result.put("state","error");
            return result;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "addRoomLocation",method = RequestMethod.POST)
    @RequiresPermissions("roomLocation")
    public @ResponseBody Map<String,String> addRoomLocation(RoomLocation roomLocation){
        Map<String,String> map=new HashMap<>();
        try {
            roomLocationService.addRoomLocation(roomLocation);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
@RequestMapping(value = "getRoomLocation",method = RequestMethod.GET)
@RequiresPermissions("roomLocation")
    public @ResponseBody RoomLocation getRoomLocation(Integer id){
        try {
            RoomLocation roomLocation=roomLocationService.getRoomLocation(id);
            return roomLocation;
        }catch (Exception e){
            return null;
        }
}
@RequestMapping(value = "editRoomLocation",method = RequestMethod.POST)
@RequiresPermissions("roomLocation")
    public  @ResponseBody Map<String,Object> editRoomLocation(RoomLocation roomLocation){
        Map<String,Object> map=new HashMap<>();
        try {
            roomLocationService.editRoomLocation(roomLocation);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
}
@RequestMapping(value = "roomLocationExist")
@RequiresPermissions("roomLocation")
    public  @ResponseBody Map<String,String> roomLocationExist(Integer id ){
        Map<String,String> map=new HashMap<>();
        try {
            List<Rooms> list=roomsMapper.roomLocationExist(id);
            if(list.size()<=0){
                map.put("state","success");
            }else
                map.put("success","error");
            return map;
        }catch (Exception e){
            return  null;
        }

}
    @RequestMapping(value = "deleteRoomLocation")
    @RequiresPermissions("roomLocation")
    public  @ResponseBody Map<String,String> deleteRoomLocation(Integer id ){
        Map<String,String> map=new HashMap<>();
        try {
            roomLocationService.deleteRoomLocation(id);
                map.put("success","error");
            return map;
        }catch (Exception e){
            return  null;
        }
    }
}
