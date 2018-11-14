package com.ps.net.service.impl;

import com.ps.net.dao.HeatSeasonMapper;
import com.ps.net.model.HeatSeason;
import com.ps.net.service.HeatSeasonService;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HeatSeasonServiceImpl implements HeatSeasonService {
    @Resource
    private HeatSeasonMapper heatSeasonMapper;
    @Override
    public List<Map<String,Object>> getHeatSeasonList(Integer page, Integer limit, String season_name, String start_date, String end_date){
        Integer first;
        first=(page-1)*limit;
        Map<String,Object> map =new HashMap<>();
        map.put("first",first);
        map.put("last",limit);
        map.put("season_name",season_name);
        map.put("start_date",start_date);
        map.put("end_date",end_date);
        return  heatSeasonMapper.selectHeatSeasonList(map);
    }
    @Override
    public Integer  getHeatSeasonListCount(String season_name, String start_date, String end_date){
        Map<String,Object> map =new HashMap<>();
        map.put("season_name",season_name);
        map.put("start_date",start_date);
        map.put("end_date",end_date);
        return  heatSeasonMapper.selectHeatSeasonListCount(map);
    }

    @Override
    public  List<HeatSeason>  nameCheck(Integer id,String season_name){
        Map map=new HashMap();
        map.put("season_id",id);
        map.put("season_name",season_name);
        return heatSeasonMapper.selectByTypeName(map);
    }
    @Override
    public  void addHeatSeason(HeatSeason heatSeason){
        heatSeasonMapper.insertSelective(heatSeason);
    }
    @Override
    public Map<String,Object> getHeatSeason(Integer id){
        return heatSeasonMapper.selectById(id);
    }
    @Override
    public void updateHeatSeason(HeatSeason heatSeason){

       heatSeasonMapper.updateByPrimaryKeySelective(heatSeason);
    }
    @Override
    public void deleteHeatSeason(Integer id){
        heatSeasonMapper.deleteByPrimaryKey(id);
    }

}
