package com.ps.net.controller;

import com.ps.net.dao.FunctionsMapper;
import com.ps.net.dao.ModulesMapper;
import com.ps.net.dao.RolesMapper;
import com.ps.net.model.Functions;
import com.ps.net.model.Modules;
import com.ps.net.model.Roles;
import com.ps.net.model.Users;
import com.ps.net.service.UserService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("index")
public class LoginController {
    @Autowired
    private UserService userService;
    @Autowired
    private RolesMapper rolesMapper;
    @Autowired
    private ModulesMapper modulesMapper;
    @Autowired
    private FunctionsMapper functionsMapper;
    @RequestMapping(value = "login")
    public String login(){
        return "login";
    }
    @RequestMapping(value = "loginIns",method = RequestMethod.POST)
    public String loginIn(String user_name, String user_passwd, HttpSession session,RedirectAttributes attr){

        System.out.println("login------------------------------");
        if(user_name==null){
            attr.addAttribute("msg", "账号不为空");
            return "login";
        }
        //主体,当前状态为没有认证的状态“未认证”
        Subject subject = SecurityUtils.getSubject();
        // 登录后存放进shiro token
        UsernamePasswordToken token=new UsernamePasswordToken(user_name,user_passwd);
        Users user;
        //登录方法（认证是否通过）
        //使用subject调用securityManager,安全管理器调用Realm
        try {
            //利用异常操作
            //需要开始调用到Realm中

            System.out.println("进入认证方法");
            subject.login(token);
            if(subject.getPrincipal()!=null){
                user = (Users)subject.getPrincipal();
                session.setAttribute("user_id",user.getId());
                session.setAttribute("user_name",user.getUser_name());
                session.setAttribute("user",subject);
            }
            System.out.println("登录完成");


        } catch (UnknownAccountException uae) {
            attr.addFlashAttribute("msg","不存在此账号");
            return "redirect:/index/login.do";
        } catch (IncorrectCredentialsException ice) {
            attr.addFlashAttribute("msg","密码错误");
            return "redirect:/index/login.do";
        }
        return "redirect:/sysIndex/sysIndex.do";
    }
    @RequestMapping(value = "logout")
    public String logout(HttpSession session,Model model){
//        attr.addFlashAttribute("msg","已安全退出");
//        session.invalidate();
     //   Principal principal = UserUtils.getPrincipal();		// 如果已经登录，则跳转到管理首页
        // 	if(principal != null){			UserUtils.getSubject().logout();		}		return "redirect:" + adminPath+"/login";
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        model.addAttribute("msg","已安全退出");
        return "login";
    }
    @RequestMapping(value = "userLogin",method = RequestMethod.POST)
    public String userlogin(String user_name, String user_passwd, HttpSession session, Model model,RedirectAttributes attr){
                try{
            Users users=userService.findUserByName(user_name);
            if(users!=null){
                String password=users.getUser_passwd();
                if(user_passwd.equals(password)){
                    String address="";
                    session.setAttribute("user",users);
                    session.setAttribute("user_id",users.getId());
                    session.setAttribute("user_name",users.getUser_name());
                    Integer role_id=users.getRole_id();
                    Roles role=rolesMapper.selectByPrimaryKey(role_id);
                    session.setAttribute("role_name",role.getRole_name());
                    //获取侧边栏权限
                    List<Modules> modules=modulesMapper.getAllModules();
                    List<Functions> functions=functionsMapper.getFunctionByRole(role_id);
                    List<Map<String,Object>> list=new ArrayList<>();
                    for(int i=0;i<modules.size();i++){
                        Map<String,Object> m=new HashMap<>();
                        List<Functions> funs=new ArrayList<>();
                        Modules module=modules.get(i);
                        m.put("module_name",module.getModule_name());
                        m.put("module_code",module.getModule_code());
                        for(int j=0;j<functions.size();j++){
                            Functions function=functions.get(j);

                            if(function.getModule_id()==module.getId()){
                                funs.add(function);

                            }
                        }
                        m.put("functions",funs);
                        list.add(m);
                    }
                    JSONArray jsonArray=JSONArray.fromObject(list);
                    if(jsonArray.size()>0){
                        JSONObject jsonObject=jsonArray.getJSONObject(0);
                        JSONArray array=jsonObject.getJSONArray("functions");
                        // for(int y=0;y<array.size();y++){
                        JSONObject object=array.getJSONObject(0);
                        String value=object.getString("function_code");
                        if(value.length()>0)
                            address=value+".do";
                        //  }
                    }


                    session.setAttribute("leftMenu",jsonArray);
                    if(address!=""){
                        return "redirect:/sysIndex/"+address;
                    }else{
                        return "noPage";
                    }

                }else{
                    attr.addFlashAttribute("msg","密码错误");
                    return "login";
                }
            }else{
                attr.addFlashAttribute("msg","无此用户");
                return "login";
            }


        }catch (Exception e){
            attr.addFlashAttribute("msg","登录出现错误");
            return "login";
        }
    }
    @RequestMapping(value = "nopermission")
    public String nopermission(){
        return "nopermission";
    }
}
