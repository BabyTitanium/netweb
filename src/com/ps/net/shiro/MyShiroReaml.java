package com.ps.net.shiro;

import com.ps.net.model.Functions;
import com.ps.net.model.Users;
import com.ps.net.service.ShiroService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.Permission;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;

import java.util.List;

public class MyShiroReaml extends AuthorizingRealm {


    private ShiroService shiroService;

    public ShiroService getShiroService() {
        return shiroService;
    }

    public void setShiroService(ShiroService shiroService) {
        this.shiroService = shiroService;
    }


    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {

        /**
         *
         * 流程
         * 1.根据用户user->2.获取角色id->3.根据角色id获取权限permission
         */
        //方法一：获得user对象
        Users user=(Users)pc.getPrimaryPrincipal();
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //获取permission
        if(user!=null) {
            List<Functions> permissionsByUser = shiroService.getPermissionsByUser(user);
            if (permissionsByUser.size()!=0) {
                for (Functions f: permissionsByUser) {

                    info.addStringPermission(f.getFunction_code());
                }
                return info;
            }
        }

        //方法二： 从subject管理器里获取user
//      Subject subject = SecurityUtils.getSubject();
//      User _user = (User) subject.getPrincipal();
//      System.out.println("subject"+_user.getUsername());
        return null;
    }

    // 认证方法
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
            //加这一步的目的是在Post请求的时候会先进认证，然后在到请求
            if (authenticationToken.getPrincipal() == null) {
                return null;
            }
            //验证账号密码
            UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
            System.out.println("1:"+token.getUsername());
            Users user = shiroService.getUserByUserName(token.getUsername());
            if(user==null){
                throw new UnknownAccountException();
            }
        //    user.setUser_passwd("1");
            System.out.println("2");

            //最后的比对需要交给安全管理器
            //三个参数进行初步的简单认证信息对象的包装
            System.out.println(this.getName());
            AuthenticationInfo info = new SimpleAuthenticationInfo(user,user.getUser_passwd(), this.getName());
            if(info==null) {
                throw new IncorrectCredentialsException();
            }
            return info;
        }

}