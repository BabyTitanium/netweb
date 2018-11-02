package com.ps.net.service;

import com.ps.net.model.CustomType;
import com.ps.net.model.HeatType;
import com.ps.net.model.Rooms;

import java.util.List;
import java.util.Map;

public interface CustomTypeService {
    List<CustomType> getCustomTypeList(Integer page,Integer limit,String type_name,String type_code);
    Integer getCustomTypeListCount(String type_name,String type_code);
    void updateCustomType(CustomType customType);
    List<CustomType> nameCheck(Integer id,String type_name);
    List<CustomType> codeCheck(Integer id,String type_code);
    void addCustomType(CustomType customType);
    CustomType getCustomType(Integer id);
    void deleteCustomType(Integer id);
    List<Rooms> CustomTypeExist(Integer customId);
}
