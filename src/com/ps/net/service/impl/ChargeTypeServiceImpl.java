package com.ps.net.service.impl;

import com.ps.net.dao.ChargeTypeMapper;
import com.ps.net.model.ChargeType;
import com.ps.net.service.ChargeTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.jws.Oneway;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChargeTypeServiceImpl implements ChargeTypeService {
    @Resource
    private ChargeTypeMapper chargeTypeMapper;
    @Override
    public List<ChargeType> getChargeTypeList(Integer page, Integer limit, String name, String code) {
        Integer first;
        first=(page-1)*limit;

        Map<String,Object>map =new HashMap<>();
        map.put("first",first);
        map.put("last",limit);
        map.put("name",name);
        map.put("code",code);
        return chargeTypeMapper.selectChargeTypeList(map);
    }

    @Override
    public Integer getChargeTypeListCount(String name, String code) {
        Map<String,Object>map =new HashMap<>();
        map.put("name",name);
        map.put("code",code);
        return chargeTypeMapper.selectChargeTypeListCount(map);
    }
    @Override
    public List<ChargeType> nameCheck(Integer id,String name){
        Map<String,Object> map=new HashMap<>();
        map.put("name",name);
        map.put("id",id);
        return chargeTypeMapper.nameCheck(map);
    }
    @Override
    public List<ChargeType> codeCheck(Integer id,String code){
        Map<String,Object> map=new HashMap<>();
        map.put("code",code);
        map.put("id",id);
        return chargeTypeMapper.codeCheck(map);
    }
    @Override
    public void addChargeType(ChargeType chargeType){
        chargeTypeMapper.insertSelective(chargeType);
    }
    @Override
    public ChargeType getChargeType(Integer id){
        return chargeTypeMapper.selectByPrimaryKey(id);
    }
    @Override
    public void editChargeType(ChargeType chargeType){
        chargeTypeMapper.updateByPrimaryKeySelective(chargeType);
    }
    @Override
    public void deleteChargeType(Integer id){
        chargeTypeMapper.deleteByPrimaryKey(id);
    }
}
