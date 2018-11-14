package com.ps.net.service.impl;

import com.ps.net.dao.ValveModelMapper;
import com.ps.net.model.ValveModel;
import com.ps.net.service.ValveModelService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ValveModelServiceImpl implements ValveModelService {
    @Resource
    private ValveModelMapper valveModelMapper;
    @Override
    public List<ValveModel> getValveModelList(Integer page, Integer limit, String model_name, String model_manu){
        Integer first;
        first=(page-1)*limit;
        Map<String,Object> map =new HashMap<>();
        map.put("first",first);
        map.put("last",limit);
        map.put("model_name",model_name);
        map.put("model_manu",model_manu);
        return  valveModelMapper.selectValveModelList(map);
    }
    @Override
    public Integer getValveModelListCount(String model_name, String model_manu){
        Map<String,Object> map =new HashMap<>();
        map.put("model_name",model_name);
        map.put("model_manu",model_manu);
        return  valveModelMapper.selectValveModelListCount(map);
    }
    @Override
    public List<ValveModel> modelNameCheck(Integer id,String model_name){
        Map<String,Object> map=new HashMap<>();
        map.put("id",id);
        map.put("model_name",model_name);
        return valveModelMapper.selectByModelName(map);
    }
    @Override
    public void addValveModel( ValveModel valveModel){
        valveModelMapper.insertSelective(valveModel);
    }
    @Override
    public void editValveModel(ValveModel valveModel){
        valveModelMapper.updateByPrimaryKeySelective(valveModel);
    }
    @Override
    public ValveModel getValveModel(Integer id){
        return  valveModelMapper.selectByPrimaryKey(id);
    }
@Override
    public void deleteValveModel(Integer id){
        valveModelMapper.deleteByPrimaryKey(id);
}
}
