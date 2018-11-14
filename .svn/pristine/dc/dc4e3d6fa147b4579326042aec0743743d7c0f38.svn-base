package com.ps.net.controller;

import com.ps.net.model.ChargeType;
import com.ps.net.service.ChargeTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("chargeType")
public class ChargeTypeController {
    @Autowired
    private ChargeTypeService chargeTypeService;
    @RequestMapping("chargeType")
    @RequiresPermissions("chargeType")
    public String chargeType(){
        return "chargeType";
    }
    @RequestMapping("chargeTypeList")
    @RequiresPermissions("chargeType")
    public @ResponseBody
    Map<String,Object> chargeTypeList(Integer page, Integer limit, String name, String code){
        Map<String,Object> map=new HashMap<>();
        try {
            if(name==""){
              name=null;
            }
            if(code==""){
              code=null;
            }
            List<ChargeType> list=chargeTypeService.getChargeTypeList(page,limit,name,code);
            Integer count=chargeTypeService.getChargeTypeListCount(name,code);
            map.put("code", 0);
            map.put("msg", "");
            map.put("data", list);
            map.put("count",count);
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping("chargeTypeCodeCheck")
    @RequiresPermissions("chargeType")
    public @ResponseBody
    Map<String,String> codeCheck(Integer id, String code){
        Map<String,String> map=new HashMap<>();
        try {
            List<ChargeType> list=chargeTypeService.codeCheck(id,code);
            if(list.size()<=0)
                map.put("state","success");
            else
                map.put("state","error");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping("chargeTypeNameCheck")
    @RequiresPermissions("chargeType")
    public @ResponseBody
    Map<String,String> nameCheck(Integer id, String name){
        Map<String,String> map=new HashMap<>();
        try {
            List<ChargeType> list=chargeTypeService.nameCheck(id,name);
            if(list.size()<=0)
                map.put("state","success");
            else
                map.put("state","error");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "addChargeType",method = RequestMethod.POST)
    @RequiresPermissions("chargeType")
    public @ResponseBody Map<String,String> addChargeType(ChargeType chargeType){
        Map<String,String> map=new HashMap<>();
        try {
            chargeTypeService.addChargeType(chargeType);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping(value = "getChargeType")
    @RequiresPermissions("chargeType")
    public  @ResponseBody ChargeType getChargeType(Integer id){
        try{
            ChargeType chargeType=chargeTypeService.getChargeType(id);
            return chargeType;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "editChargeType")
    @RequiresPermissions("chargeType")
    public @ResponseBody Map<String,Object> editChargeType(ChargeType chargeType){
        Map<String,Object> map=new HashMap<>();
        try{
            chargeTypeService.editChargeType(chargeType);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "deleteChargeType")
    @RequiresPermissions("chargeType")
    public @ResponseBody Map<String,Object> deleteChargeType(Integer id){
        Map<String,Object> map=new HashMap<>();
        try{
            chargeTypeService.deleteChargeType(id);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
}
