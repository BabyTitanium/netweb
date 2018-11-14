package com.ps.net.controller;

import com.ps.net.changeObject.ExtraMethod;
import com.ps.net.dao.RoleFunctionMapper;
import com.ps.net.dao.RolesMapper;
import com.ps.net.dao.UsersMapper;
import com.ps.net.model.*;
import com.ps.net.service.RoleService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("roleSet")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private RolesMapper rolesMapper;
    @Autowired
    private RoleFunctionMapper roleFunctionMapper;
    @Autowired
    private UsersMapper usersMapper;
    @RequestMapping("roleSet")
    @RequiresPermissions("roleSet")
    public String roleSet(){
        return "role";
    }
    @RequestMapping("roleList")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map<String,Object> roleList(@RequestParam Map<String,Object> map){
        try {
            List<Map<String,Object>> list=roleService.getRoleList(map);
            if(list!=null){
                for(int i=0;i<list.size();i++){
                    Map role=list.get(i);
                    Integer id=Integer.parseInt(String.valueOf(role.get("id")));
                    List<Map<String,Object>> list1=roleService.getRoleService(id);
                    if(list1!=null){
                        for(int j=0;j<list1.size();j++){
                            Map roles=list1.get(j);
                            role.put(String.valueOf(roles.get("name"))+"_rid",roles.get("rid"));
                            role.put(String.valueOf(roles.get("name")),"1");
                        }
                    }
                }
                Integer count=roleService.getRoleListCount();
                return ExtraMethod.returnList(list,count);
            }
            else return null;

        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "checkRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map<String,String> checkRole(@RequestParam Map map){
        try{
            Map<String,String> result=new HashMap<>();
            map=ExtraMethod.setNull(map);
            Map<String,Object> role=roleService.getRole(map);
            if(role!=null){
                result.put("state","error");
                return result;
            }else{
                result.put("state","success");
                return result;
            }
        }catch (Exception e){
            return  null;
        }
}
    @RequestMapping(value = "addRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map addRole( Roles roles){
        try{
            roleService.addRoles(roles);
            Map<String,Object> result=new HashMap<>();
            result.put("state","success");
            return  result;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "deleteRoleService")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map deleteRoleService(Integer id){
        try{
        roleService.deleteRoleService(id);
        Map<String,Object> map=new HashMap<>();
        map.put("state","success");
        return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "addRoleService")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map addRoleService(Integer id,String name){
        try{
            ServiceRole serviceRole=roleService.getServiceRoleByName(name);
            Map map=new HashMap();
            map.put("role_id",id);
            map.put("service_id",serviceRole.getId());
            roleService.addRoleService(map);
            Map<String,Object> result=new HashMap<>();
            result.put("state","success");
            return result;
        }catch (Exception e){
            return null;
        }
    }

    @RequestMapping(value = "editRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map editRole( Roles roles){
        try{
            roleService.editRoles(roles);
            Map<String,Object> result=new HashMap<>();
            result.put("state","success");
            return  result;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Roles getRole(Integer id){
        try{
            return rolesMapper.selectByPrimaryKey(id);
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "permissionTree")
    @RequiresPermissions("roleSet")
    public String permissionTree(Integer role_id, ModelMap map){
        map.addAttribute("role_id",role_id);
        return "permissionTree";
    }
    @RequestMapping(value = "getFunctionTree")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public List getFunctionTree(Integer role_id){
        List list=new ArrayList();
        List<Map<String,Object>> modules=rolesMapper.getModules();
        if(modules!=null){
            for(int i=0;i<modules.size();i++){
                Map<String,Object> module=modules.get(i);
                module.put("pId",0);
                module.put("zId",i+1);
                module.put("name",module.get("module_name"));
//                list.add(module);
                Integer module_id=Integer.parseInt(String.valueOf(module.get("id")));
                List<Map<String,Object>> functions=rolesMapper.getFunctions(module_id);
                if(functions!=null){
                    module.put("open","true");
                    list.add(module);
                    for(int j=0;j<functions.size();j++){
                        Map<String,Object> function=functions.get(j);
                        function.put("zId",(i+1)*10+j);
                        function.put("pId",i+1);
                        function.put("name",function.get("function_name"));
//                        list.add(function);
                        Integer function_id=Integer.parseInt(String.valueOf(function.get("id")));
                        Map<String,Object> con=new HashMap<>();
                        con.put("role_id",role_id);
                        con.put("function_id",function_id);
                        //查询是否选中
                        Map<String,Object> role_func=rolesMapper.getRoleFunc(con);
                        if(role_func!=null){
                            function.put("checked","true");
                            module.put("checked","true");
                        }
                        list.add(function);
                    }
                }else{
                    module.put("open","false");
                    list.add(module);
                }

            }
        }

        return list;
    }
    @RequestMapping("addFunctionToRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map addFunctionToRole(@RequestParam(value = "role_id") Integer role_id,@RequestParam(value = "list[]") Integer[] list){
        try{
            if(list.length>0){
                //先删除当前分支的所有房间
                roleFunctionMapper.deleteByRole(role_id);
                for(int i=0;i<list.length;i++){
                    Integer function_id=list[i];
                    RoleFunction roleFunction=new RoleFunction();
                    roleFunction.setFunction_id(function_id);
                    roleFunction.setRole_id(role_id);
                    roleFunction.setAdd_time(new Date());
                    roleFunctionMapper.insertSelective(roleFunction);
                }
            }
            //清空缓存

            Map map=new HashMap();
            map.put("state","success");
            return map;
        }catch(Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getUsersByRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map getUsersByRole(Integer role_id){
        try{
            Map map=new HashMap();
            List<Users> list=usersMapper.getUsersByRole(role_id);
            if(list.size()>0){
                map.put("state","error");
            }else{
                map.put("state","success");
            }
            return map;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "deleteRole")
    @RequiresPermissions("roleSet")
    @ResponseBody
    public Map deleteRole(Integer id){
        try{
            Map map=new HashMap();
            roleFunctionMapper.deleteByRole(id);
            rolesMapper.deleteByPrimaryKey(id);
            map.put("state","success");
            return map;
        }catch (Exception e){
            return null;
        }
    }
}
