package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.HeatTypeMapper;
import com.ps.net.dao.RoomsMapper;
import com.ps.net.model.CustomType;
import com.ps.net.model.HeatType;
import com.ps.net.model.Rooms;
import com.ps.net.service.HeatTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HeatTypeServiceImpl implements HeatTypeService {
@Resource
private HeatTypeMapper heatTypeMapper;
@Resource
private RoomsMapper roomsMapper;
    @Override
    public List<HeatType> getHeatTypeList(Integer page, Integer limit, String type_name, String type_code){
        Map<String,Object> map =new HashMap<>();
        if(page!=null && limit!=null) {
            map.put("page",page);
            map.put("limit",limit);
            map=Page.getData(map);
        }
        map.put("type_name",type_name);
        map.put("type_code",type_code);
        return heatTypeMapper.selectHeatTypeList(map);
    }
    @Override
    public Integer getHeatTypeListCount(String type_name,String type_code){
        Map<String,Object>map =new HashMap<>();
        map.put("type_name",type_name);
        map.put("type_code",type_code);
        return  heatTypeMapper.selectHeatTypeListCount(map);
    }
    @Override
    public void updateHeatType(HeatType heatType){
       heatTypeMapper.updateByPrimaryKeySelective(heatType);
    }
    @Override
    public  List<HeatType>  nameCheck(Integer id,String type_name){
        Map map=new HashMap();
        map.put("id",id);
        map.put("type_name",type_name);
        return heatTypeMapper.selectByTypeName(map);
    }
    @Override
    public  List<HeatType>  codeCheck(Integer id,String type_code){
        Map map=new HashMap();
        map.put("id",id);
        map.put("type_code",type_code);
        return heatTypeMapper.selectByTypeCode(map);
    }
    @Override
    public  void addHeatType(HeatType heatType){
        heatTypeMapper.insertSelective(heatType);
    }
    @Override
    public  HeatType getHeatType(Integer id){
        return heatTypeMapper.selectByPrimaryKey(id);
    }
    @Override
    public  void deleteHeatType(Integer id) {
        heatTypeMapper.deleteByPrimaryKey(id);
    }
    @Override
    public List<Rooms> HeatTypeExist(Integer heatId){
        return roomsMapper.findByHeatType(heatId);
    }
}
