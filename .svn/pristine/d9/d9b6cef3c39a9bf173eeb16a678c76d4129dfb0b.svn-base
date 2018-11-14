package com.ps.net.service;

import com.ps.net.model.ChargeType;
import jdk.internal.dynalink.linker.LinkerServices;

import java.util.List;
import java.util.Map;

public interface ChargeTypeService {
    List<ChargeType> getChargeTypeList(Integer page, Integer limit, String name, String code);
    Integer getChargeTypeListCount(String name, String code);
    List<ChargeType> nameCheck(Integer id,String name);
    List<ChargeType> codeCheck(Integer id,String code);
    void addChargeType(ChargeType chargeType);
    ChargeType getChargeType(Integer id);
    void editChargeType(ChargeType chargeType);
    void deleteChargeType(Integer id);
}
