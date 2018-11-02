package com.ps.net.service;

import com.ps.net.model.HeatSeason;

import java.util.List;
import java.util.Map;

public interface HeatSeasonService {
    List<Map<String,Object>> getHeatSeasonList(Integer page, Integer limit, String season_name, String start_time, String end_time);
    Integer getHeatSeasonListCount(String season_name, String start_time, String end_time);
    List<HeatSeason> nameCheck(Integer id,String season_name);
    void addHeatSeason(HeatSeason heatSeason);
    Map<String,Object> getHeatSeason(Integer id);
    void updateHeatSeason(HeatSeason heatSeason);
void deleteHeatSeason(Integer id);
}
