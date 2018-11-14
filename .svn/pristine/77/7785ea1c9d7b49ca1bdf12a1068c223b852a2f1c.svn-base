package com.ps.net.service;
import com.ps.net.model.HeatType;
import com.ps.net.model.Rooms;

import java.util.List;

public interface HeatTypeService {
    List<HeatType> getHeatTypeList(Integer page, Integer limit, String type_name, String type_code);
    Integer getHeatTypeListCount(String type_name,String type_code);
    void updateHeatType(HeatType heatType);

    List<HeatType> nameCheck(Integer id,String type_name);
    List<HeatType> codeCheck(Integer id,String type_code);
    void addHeatType(HeatType heatType);
    HeatType getHeatType(Integer id);

    void deleteHeatType(Integer id);
    List<Rooms> HeatTypeExist(Integer heatId);
}
