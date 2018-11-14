package com.ps.net.controller;

import com.ps.net.model.ValveModel;
import com.ps.net.service.ValveModelService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("valveModel")
public class ValveModelController {
    @Autowired
    private ValveModelService valveModelService;

    @RequestMapping(value = "valveModel")
    @RequiresPermissions("valveModel")
    public String valveModal(){
        return "valveModel";
    }

    @RequestMapping(value = "valveModelList",method = RequestMethod.GET)
    @RequiresPermissions("valveModel")
    public @ResponseBody
    Map<String,Object> valveModelList(Integer page,Integer limit,String model_name, String model_manu){
        try {
            Map<String, Object> map = new HashMap<>();
            if(model_name==""){
                model_name=null;
            }
            if(model_manu==""){
                model_manu=null;
            }
            List<ValveModel> list = valveModelService.getValveModelList(page,limit,model_name,model_manu);
            Integer count=valveModelService.getValveModelListCount(model_name,model_manu);
            map.put("code", 0);
            map.put("msg", "");
            map.put("data", list);
            map.put("count",count);
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "modelNameCheck",method = RequestMethod.GET)
    @RequiresPermissions("valveModel")
    public @ResponseBody Map<String,Object> modelNameCheck(Integer id,String model_name){
        Map<String,Object> map=new HashMap<>();
        try {
            List<ValveModel> list=valveModelService.modelNameCheck(id,model_name);
            if(list.size()<=0){
                map.put("state","success");
            }else {
                map.put("state","error");
            }
        }catch (Exception e){
            return null;
        }
        return map;
    }
    @RequestMapping(value = "addValveModel",method = RequestMethod.POST)
    @RequiresPermissions("valveModel")
    public @ResponseBody Map<String,String> addValveModel(ValveModel valveModel){
        Map<String,String> map=new HashMap<>();
        try {
            valveModelService.addValveModel(valveModel);
            map.put("state","success");
            return  map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping( value = "editValveModel",method = RequestMethod.POST)
    @RequiresPermissions("valveModel")
    public @ResponseBody Map<String,Object> editValveModel(ValveModel valveModel){
        Map<String,Object> map=new HashMap<>();
        try {
            valveModelService.editValveModel(valveModel);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getValveModel",method = RequestMethod.GET)
    @RequiresPermissions("valveModel")
    public @ResponseBody ValveModel getValveModel(Integer id){
        try {
           ValveModel valveModel=valveModelService.getValveModel(id);
            return valveModel;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "deleteValveModel",method = RequestMethod.GET)
    @RequiresPermissions("valveModel")
    public @ResponseBody Map<String,String> deleteValveModel(Integer id){
        Map<String,String> map=new HashMap<>();
        try {
            valveModelService.deleteValveModel(id);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
}
