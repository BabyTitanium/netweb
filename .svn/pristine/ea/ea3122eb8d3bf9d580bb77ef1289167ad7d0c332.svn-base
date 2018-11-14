package com.ps.net.service.impl;

import com.ps.net.changeObject.Page;
import com.ps.net.dao.CustomTypeMapper;
import com.ps.net.dao.RoomsMapper;
import com.ps.net.model.CustomType;
import com.ps.net.model.HeatArea;
import com.ps.net.model.HeatType;
import com.ps.net.model.Rooms;
import com.ps.net.service.CustomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.jws.Oneway;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CustomTypeServiceImpl  implements CustomTypeService {
    @Resource
    private CustomTypeMapper customTypeMapper;
    @Resource
    private  RoomsMapper roomsMapper;
    @Override
    public List<CustomType> getCustomTypeList(Integer page,Integer limit,String type_name,String type_code){
        Map<String,Object> map =new HashMap<>();
        if(page!=null && limit!=null) {
            map.put("page",page);
            map.put("limit",limit);
            map=Page.getData(map);
        }
        map.put("type_name",type_name);
        map.put("type_code",type_code);
        return customTypeMapper.selectCustomTypeList(map);
    }
    @Override
    public Integer getCustomTypeListCount(String type_name,String type_code){
        Map<String,Object>map =new HashMap<>();
        map.put("type_name",type_name);
        map.put("type_code",type_code);
return  customTypeMapper.selectCustomTypeListCount(map);
    }
    @Override
    public void updateCustomType(CustomType customType){
        customTypeMapper.updateByPrimaryKeySelective(customType);
    }
    @Override
    public  List<CustomType>  nameCheck(Integer id,String type_name){
        Map map=new HashMap();
        map.put("id",id);
        map.put("type_name",type_name);
        return customTypeMapper.selectByTypeName(map);
    }
    @Override
    public  List<CustomType>  codeCheck(Integer id,String type_code){
        Map map=new HashMap();
        map.put("id",id);
        map.put("type_code",type_code);
        return customTypeMapper.selectByTypeCode(map);
    }
    @Override
    public  void addCustomType(CustomType customType){
        customTypeMapper.insertSelective(customType);
    }
    @Override
    public  CustomType getCustomType(Integer id){
        return customTypeMapper.selectByPrimaryKey(id);
    }
    @Override
    public  void deleteCustomType(Integer id) {
        customTypeMapper.deleteByPrimaryKey(id);
    }
    @Override
    public List<Rooms> CustomTypeExist(Integer customId){
        return roomsMapper.findByUserType(customId);
    }
}
