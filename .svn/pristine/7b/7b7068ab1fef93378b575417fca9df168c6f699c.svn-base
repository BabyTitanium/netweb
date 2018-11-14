<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/25
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
    HttpSession s = request.getSession();
%>
<div class="layui-side layui-bg-black">

    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->

        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed" id="basic">
                <a  href="javascript:;">基础信息</a>
                <dl class="layui-nav-child">
                    <shiro:hasPermission name="sysIndex">
                        <dd id="sysIndex" ><a href="sysIndex/sysIndex.do">组织架构管理</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="heatSeason">
                        <dd id="heatSeason"  ><a href="heatSeason/heatSeason.do">采暖季管理</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="heatType">
                        <dd id="heatType"  ><a href="heatType/heatType.do">采暖类型管理</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="device">
                        <dd id="device"  ><a href="device/device.do">基站管理</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="customType">
                        <dd id="customType" ><a href="customType/customType.do">住户类型管理</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="valveModel">
                        <dd id="valveModel" ><a href="valveModel/valveModel.do">阀门型号管理</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="roomLocation">
                        <dd id="roomLocation" ><a href="roomLocation/roomLocation.do">房屋位置管理</a></dd>
                </shiro:hasPermission>
                    <shiro:hasPermission name="chargeType">
                        <dd id="chargeType" ><a href="chargeType/chargeType.do">收费方式管理</a></dd>

                    </shiro:hasPermission>
                </dl>
            </li>
            <li class="layui-nav-item layui-nav-itemed" id="permiss" >
                <a href="javascript:;">权限设置</a>
                <dl class="layui-nav-child">
                    <shiro:hasPermission name="heatType">
                        <dd id="roleSet" ><a href="roleSet/roleSet.do">角色设置</a></dd>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="heatType">
                        <dd id="userSet"  ><a href="userSet/userSet.do">用户管理</a></dd>
                    </shiro:hasPermission>


                </dl>
            </li>
            <%--<li class="layui-nav-item layui-nav-itemed" id="datasch"  style="display: none;">--%>
                <%--<a href="javascript:;">数据查询</a>--%>
                <%--<dl class="layui-nav-child">--%>
                    <%--<dd id="heatData" style="display: none;"><a href="javascript:;">热量数据</a></dd>--%>
                    <%--<dd id="valveData"  style="display: none;"><a href="javascript:;">阀门数据</a></dd>--%>
                    <%--<dd id="tempData" style="display: none;"><a href="javascript:;">测温数据</a></dd>--%>
                    <%--<dd id="thermoData"  style="display: none;"><a href="javascript:;">无线面板数据</a></dd>--%>
                    <%--<dd id="deviceData"  style="display: none;"><a href="javascript:;">基站状态信息</a></dd>--%>
                <%--</dl>--%>
            <%--</li>--%>

        </ul>
    </div>
</div>
<% String type=request.getParameter("type");%>
<script type="text/javascript">
    <%--var leftMenu=<%=s.getAttribute("leftMenu")%>;--%>
    <%--$(leftMenu).each(function (index) {--%>
        <%--var n=leftMenu[index];--%>
        <%--var f=n.functions;--%>
        <%--if(f!=null&&f!=""&&f!=undefined){--%>
            <%--$("#"+n.module_code).css("display","block");--%>
           <%--$(f).each(function (temp) {--%>
               <%--var t=f[temp];--%>
               <%--$("#"+t.function_code).css("display","block");--%>
           <%--})--%>
        <%--}--%>
    <%--})--%>
  var type="#"+"<%=type%>";

 $("#"+"<%=type%>").addClass("layui-this");

var i=0;
    //通过图标id来触发左侧导航栏收缩功能动画效果
    $('#animation-left-nav').click(function(){
        //这里定义一个全局变量来方便判断动画收缩的效果,也就是放在最外面
        if(i==0){
            $(".layui-side").animate({width:'toggle'});
            $(".layui-body").animate({left:'0px'});
            $(".layui-footer").animate({left:'0px'});
            i++;
        }else{
            $(".layui-side").animate({width:'toggle'});
            $(".layui-body").animate({left:'200px'});
            $(".layui-footer").animate({left:'200px'});
            i--;
        }
    });
    //左侧导航栏收缩提示
    // $('#animation-left-nav').hover(function(){
    //     layer.tips('收缩左侧导航栏', '#animation-left-nav', {tips:[4,'#FF8000'],time:0});
    // },function(){
    //     layer.closeAll('tips');
    // });
</script>
