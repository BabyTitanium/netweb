package com.ps.net.dao;

import com.ps.net.model.HeatArea;

import java.util.List;
import java.util.Map;

public interface HeatAreaMapper {
    List<HeatArea> selectHeatAreaList(Map<String,Object> map);  //根据分公司ID找到区域列表
    void insertHeatArea(HeatArea heatArea);    //插入一条区域信息（只包含名称跟上级ID）
    HeatArea selectHeatArea(Integer id);//根据ID查找区域数据
    void updateHeatArea(HeatArea heatArea);//修改区域信息（根据ID修改名称与地址）

}
