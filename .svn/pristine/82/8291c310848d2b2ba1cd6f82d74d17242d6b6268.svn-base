package com.ps.net.service;

import com.ps.net.model.Builds;

import java.util.List;
import java.util.Map;

public interface ZoneBuildingService {
    Integer addBuilding(Map<String,Object> map);
    Map<String,Object> checkBuilding(Map<String,Object> map);
    List<Map<String,Object>> getBuildingList(Map<String,Object> map);
    Integer getBuildingListCount(Map<String,Object> map);
    Builds getBuildingInfo(Integer id);
    void editBuilding(Map<String,Object> map);
    void addBuildHeatInfo(Integer build_id);
    void updateBuildHeatInfo(Integer build_id);
    List<Map<String,Object>> getUnitsByBuilding(Integer build_id);
    void deleteBuilding(Integer id);
}
