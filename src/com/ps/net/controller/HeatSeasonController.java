package com.ps.net.controller;

import com.ps.net.model.HeatSeason;
import com.ps.net.model.HeatType;
import com.ps.net.service.HeatSeasonService;
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
@RequestMapping("heatSeason")

public class HeatSeasonController {
    @Autowired
    private HeatSeasonService heatSeasonService;
    @RequestMapping("heatSeason")
    @RequiresPermissions("heatSeason")
    public String heatSeason(){
        return  "heatSeason";
    }
    @RequestMapping("heatSeasonList")
    @RequiresPermissions("heatSeason")
    public @ResponseBody
        Map<String,Object> heatSeasonList(Integer page, Integer limit, String season_name, String start_date, String end_date){
        if (season_name == "") {
            season_name=null;
        }
        if (start_date == "") {

            start_date=null;
        }
        if (end_date == "") {
            end_date=null;
        }
        Map<String,Object> map=new HashMap<>();
        List<Map<String,Object>> list=heatSeasonService.getHeatSeasonList(page,limit,season_name,start_date,end_date);
        Integer count=heatSeasonService.getHeatSeasonListCount(season_name,start_date,end_date);
        map.put("code", 0);
        map.put("msg", "");
        map.put("data", list);
        map.put("count",count);
        return map;
    }
    @RequestMapping(value = "HeatSeasonNameCheck",method = RequestMethod.GET)
    @RequiresPermissions("heatSeason")
    public   @ResponseBody Map<String,String> HeatTypeNameCheck(Integer season_id,String season_name) {
        Map<String, String> map = new HashMap<>();
        try {
            List<HeatSeason> list=heatSeasonService.nameCheck(season_id,season_name);
            if(list.size()>0){
                map.put("state","error");
            }else
                map.put("state","success");
            return map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value = "addHeatSeason",method = RequestMethod.POST)
    @RequiresPermissions("heatSeason")
    public  @ResponseBody Map<String,String> addHeatSeason(HeatSeason   heatSeason){
        Map<String,String> map=new HashMap<>();
        try {
         heatSeasonService.addHeatSeason(heatSeason);
            map.put("state","success");
            return  map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getHeatSeason",method = RequestMethod.GET)
    @RequiresPermissions("heatSeason")
    public   @ResponseBody Map<String,Object>   getHeatSeason(Integer id){
        try {
            Map<String,Object> heatSeason =heatSeasonService.getHeatSeason(id);
            return  heatSeason;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "editHeatSeason",method = RequestMethod.POST)
    @RequiresPermissions("heatSeason")
    public @ResponseBody   Map<String,String> editHeatSeason(HeatSeason heatSeason){
        Map<String,String> map=new HashMap<>();
        try{
            heatSeasonService.updateHeatSeason(heatSeason);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "deleteHeatSeason" ,method = RequestMethod.GET)
    @RequiresPermissions("heatSeason")
    public  @ResponseBody Map<String,String> deleteHeatSeason(Integer season_id){
        Map<String,String> map=new HashMap<>();
        try {
            heatSeasonService.deleteHeatSeason(season_id);
            map.put("state","success");
            return  map;
        }
        catch (Exception e){
            return null;
        }

    }
}