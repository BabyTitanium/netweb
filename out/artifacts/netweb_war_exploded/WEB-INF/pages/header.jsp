<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/25
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession s = request.getSession();
%>

<div class="layui-header">
    <div class="layui-logo">二次网平衡管理系统    <i id="animation-left-nav" class="layui-icon" style="color: white;">&#xe668;</i> </div>


<ul class="layui-nav layui-layout-right">
    <li class="layui-nav-item">
        <a id="user" href="javascript:;">
        </a>
    </li>
    <li class="layui-nav-item"><a href="index/logout.do">退出</a></li>
</ul>
</div>
<script type="text/javascript">
var user_name="<%=s.getAttribute("user_name")%>";
$("#user").html(user_name);
</script>
