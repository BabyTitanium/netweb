
<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/25
  Time: 13:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>组织架构管理</title>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script type="text/javascript" src="layui/jquery-2.2.4.min.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/style.css">
    <link rel="stylesheet" href="layui/css/my.css">
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

        <jsp:include page="header.jsp"/>
        <jsp:include page="left.jsp">
            <jsp:param value="sysIndex" name="type"/>
        </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="areachoose">
                <div class="layui-container area-top" style="">
                    <blockquote class="layui-elem-quote layui-text">
                        区域设置
                        <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
                    </blockquote>
                </div>
            </div>
            <div class="layui-container areas" >
                <div class="layui-card">
                    <div class="layui-card-header" style="background-color: #f2f2f2;">区域设置</div>
                    <div class="layui-card-body">
                        <%--<div class="layui-container">--%>
                            <div class="layui-row">
                                <div class="layui-col-lg4 layui-col-md4 layui-col-sm4 layui-col-xs12">
                                    <input type="text" hidden id="companyId">
                                    <input type="text" hidden id="areaId">
                                    <input type="text" hidden id="zoneId">

                                    <table class="layui-table" id="company">
                                        <colgroup>
                                            <col width="150">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>分公司</th>
                                        </tr>
                                        </thead>
                                        <tbody id="company_tb" style="margin-top: 2px;">

                                        </tbody>
                                    </table>
                                    <div class="addContent" id="addCom" style="display: none;">
                                        <input type="text" id="companyName" name="companyName" ><button onclick="submitCompany()">提交</button><button onclick="cancelAdd()">取消</button>
                                    </div>
                                    <div class="addDiv">
                                        <!-- layui 2.2.5 新增 -->
                                        <button class="layui-btn layui-btn-fluid addButton" onclick="addCompany();">增加</button>
                                    </div>
                                </div>
                                <div class="layui-col-lg4 layui-col-md4 layui-col-sm4 layui-col-xs12 ">
                                    <table class="layui-table" id="area">
                                        <colgroup>
                                            <col width="150">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>区域</th>
                                        </tr>
                                        </thead>
                                        <tbody id="area_tb">

                                        </tbody>
                                    </table>
                                    <div class="addContent" id="addArea" style="display: none;">
                                        <input type="text" id="areaName" name="areaName" ><button onclick="submitHeatArea()">提交</button><button onclick="cancelAdd()">取消</button>
                                    </div>
                                    <div class="addDiv">
                                        <!-- layui 2.2.5 新增 -->
                                        <button class="layui-btn layui-btn-fluid addButton" onclick="addArea();">增加</button>
                                    </div>

                                </div>
                                <div class="layui-col-lg4 layui-col-md4 layui-col-sm4 layui-col-xs12">
                                    <table class="layui-table" id="zone">
                                        <colgroup>
                                            <col width="150">

                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>小区</th>

                                        </tr>
                                        </thead>
                                        <tbody id="zone_tb">

                                        </tbody>
                                    </table>
                                    <div class="addContent" id="addZone" style="display: none;">
                                        <input type="text" id="zoneName" name="zoneName" ><button onclick="submitZones()">提交</button><button onclick="cancelAdd()">取消</button>
                                    </div>
                                    <div class="addDiv">
                                        <!-- layui 2.2.5 新增 -->
                                        <button class="layui-btn layui-btn-fluid addButton" onclick="addZone();">增加</button>
                                    </div>

                                </div>
                            </div>
                        <%--</div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="footer.jsp"/>
</div>
<%--修改分公司--%>
<form class="layui-form" id="editCompany" onsubmit="return submitComInfo();" hidden  style="padding: 10px;">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="id" hidden>
            <input type="text" name="name" required  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block">
            <input type="text" name="address"   lay-verify="required" placeholder="请输入地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center">
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeComLayer()">取消</button>
    </div>
</form>
<%--修改区域--%>
<form class="layui-form" id="editHeatArea" onsubmit="return submitHeatAreaInfo();" hidden  style="padding: 10px;">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="id" hidden>
            <input type="text" name="name" required  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block">
            <input type="text" name="address"   lay-verify="required" placeholder="请输入地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">起始日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="initial_heat" id="initial_heat">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">结束日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="end_heat" id="end_heat">
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center">
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeHeatAreaLayer()">取消</button>
    </div>
</form>
<%--修改小区--%>
<form class="layui-form" id="editZones" onsubmit="return submitZonesInfo();" hidden  style="padding: 10px;">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="id" hidden>
            <input type="text" name="z_name" required  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block">
            <input type="text" name="address"   lay-verify="required" placeholder="请输入地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center">
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeZonesLayer()">取消</button>
    </div>
</form>

<script type="text/javascript" src="layui/layui.all.js"></script>
<script type="text/javascript">
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#initial_heat' //指定元素
            ,format: 'MM-dd' //可任意组合
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#end_heat' //指定元素
            ,format: 'MM-dd' //可任意组合
        });
    });
    $(function (){

        var index;
        getBranchCompanyList();
    });
    function getBranchCompanyList(){
        $.ajax({
            type:"GET",
            url:"sysIndex/companyList.do",
            dataType:"json",
            async:false,
            success:function(data){
                var html="";
                $(data).each(function (index){
                    var val=data[index];
                    if(index==0){
                        html+="<tr><td class='chosed' id='"+val.id+"'>"+val.name+"<span onclick='deleteBranchCompany("+val.id+")'><i class='layui-icon'>&#x1006;</i></span><span onclick='changeComInfo("+val.id+")'><i class='layui-icon'>&#xe642;</i></span></td></tr> ";
                        $("#companyId").attr("value",val.id);
                        getAreaByCompanyId(val.id);
                    }else{
                        html+="<tr><td  id='"+val.id+"'>"+val.name+"<span onclick='deleteBranchCompany("+val.id+")'><i class='layui-icon'>&#x1006;</i></span><span onclick='changeComInfo("+val.id+")'><i class='layui-icon'>&#xe642;</i></span></td></tr> ";
                    }
                });
                $("#company_tb").html(html);
            }
        });
    }
    $(document).on("click","#company tr td",function () {
        $("#company tr td").removeClass("chosed");
        $(this).addClass("chosed");
        var companyId= this.id;
        $("#companyId").attr("value",companyId);
        $("#areaId").attr("value","");
        $("#area_tb").html("");
        $("#zoneId").attr("value","");
        $("#zone_tb").html("");
        getAreaByCompanyId(companyId);
    });
    $(document).on("click","#area tr td",function () {
        $("#area tr td").removeClass("chosed");
        var areaId=this.id;
        $("#areaId").attr("value",areaId);
        $(this).addClass("chosed");
        getZoneByAreaId($("#areaId").val());
    });
    $(document).on("click","#zone tr td",function () {
        $("#zone tr td").removeClass("chosed");
        var zoneId=this.id;
        $("#zoneId").attr("value",zoneId);
        $(this).addClass("chosed");
    });

    function   getAreaByCompanyId(companyId) {
        $.ajax({
            type:"GET",
            url:"sysIndex/areaList.do",
            dataType:"json",
            async:false,
            data:{companyId:companyId},
            success:function(data){
                var html="";
                $(data).each(function (index){
                    var val=data[index];
                    if(index==0){
                        html+="<tr><td class='chosed' id='"+val.id+"'>"+val.name+"<span onclick='deleteHeatArea("+val.id+")'><i class='layui-icon'>&#x1006;</i></span><span onclick='changeHeatAreaInfo("+val.id+")'><i class='layui-icon'>&#xe642;</i></span></td></tr> ";
                        $("#areaId").attr("value",val.id);
                        getZoneByAreaId(val.id);
                    }else{
                        html+="<tr><td  id='"+val.id+"'>"+val.name+"<span onclick='deleteHeatArea("+val.id+")'><i class='layui-icon'>&#x1006;</i></span><span onclick='changeHeatAreaInfo("+val.id+")'><i class='layui-icon'>&#xe642;</i></span></td></tr> ";
                    }
                });
                $("#area_tb").html(html);
            }
        });
    }
    function   getZoneByAreaId(areaId) {
        $.ajax({
            type:"GET",
            url:"sysIndex/zoneList.do",
            dataType:"json",
            async:false,
            data:{areaId:areaId},
            success:function(data){
                var html="";
                $(data).each(function (index){
                    var val=data[index];
                    if(index==0){
                        html+="<tr><td class='chosed' id='"+val.id+"'>"+"<a href='sysIndex/zoneRoomsManage.do?id="+val.id+"'>"+val.z_name+"</a>"+"<span onclick='deleteZones("+val.id+")'><i class='layui-icon'>&#x1006;</i></span><span  onclick='changeZonesInfo("+val.id+")'><i class='layui-icon'>&#xe642;</i></span></td></tr> ";
                        $("#zoneId").attr("value",val.id);
                    }else{
                        html+="<tr><td  id='"+val.id+"'>"+"<a href='sysIndex/zoneRoomsManage.do?id="+val.id+"'>"+val.z_name+"</a>"+"<span onclick='deleteZones("+val.id+")'><i class='layui-icon'>&#x1006;</i></span><span  onclick='changeZonesInfo("+val.id+")'><i class='layui-icon'>&#xe642;</i></span></td></tr> ";
                    }
                });
                $("#zone_tb").html(html);
            }
        });
    }
    function addCompany(){

        $(".addContent").css("display","none");
        $("#addCom").css("display","block");

    }
    function cancelAdd(){
        $(".addContent input").val("");
        $(".addContent").css("display","none");
    }
    function addArea(){
        $(".addContent").css("display","none");
        $("#addArea").css("display","block");

    }

    function addZone(){
        $(".addContent").css("display","none");
        $("#addZone").css("display","block");

    }

    function submitCompany() {
        var companyName=$("#companyName").val();
        $.ajax({
            type:"GET",
            dataType:"json",
            url:"sysIndex/addBranchCompany.do",
            data:{companyName:companyName},
            async:false,
            success:function (data) {
                if(data.state=="success"){
                    layer.msg("添加成功",{
                        time:1000
                    },function () {
                        $(".addContent").css("display","none");
                        getBranchCompanyList();
                        //
                    });
                }else {
                    layer.msg("添加失败");
                }
            },
            error:function (data) {
                layer.msg("添加失败");
            }
        });
        $(".addContent input").val("");
    }
    function submitHeatArea() {
        var branch_company_id=$("#companyId").val();
        var areaName=$("#areaName").val();
        $.ajax({
            type:"GET",
            dataType:"json",
            url:"sysIndex/addHeatArea.do",
            data:{
                branch_company_id:branch_company_id,
                areaName:areaName
            },
            async:false,
            success:function (data) {
                if(data.state=="success"){
                    layer.msg("添加成功",{
                        time:1000
                    },function () {
                        $(".addContent").css("display","none");
                        var companyId=$("#companyId").val();
                        getAreaByCompanyId(companyId);
                    });

                }else {
                    layer.msg("添加失败");
                }
            },
            error:function (data) {
                layer.msg("添加失败");
            }
        });
        $(".addContent input").val("");
    }

    function submitZones() {
        var heat_e_station_id=$("#areaId").val();
        var zonesName=$("#zoneName").val();
        $.ajax({
            type:"GET",
            dataType:"json",
            url:"sysIndex/addZones.do",
            data:{
                heat_e_station_id:heat_e_station_id,
                zonesName:zonesName
            },
            async:false,
            success:function (data) {
                if(data.state=="success"){
                    layer.msg("添加成功",{
                        time:1000
                    },function () {
                        $(".addContent").css("display","none");
                        var areaId=$("#areaId").val();
                        getZoneByAreaId(areaId);
                    });

                }else {
                    layer.msg("添加失败");
                }
            },
            error:function (data) {
                layer.msg("添加失败");
            }
        });
        $(".addContent input").val("");
    }
    function changeComInfo(id) {
        $.ajax({
            type:"GET",
            dataType:"json",
            url:"sysIndex/getBranchCompany.do",
            data:{
                id:id
            },
            async:false,
            success:function (data) {
                $("#editCompany input[name='id']").attr("value",data.id);
                $("#editCompany input[name='name']").attr("value",data.name);
                $("#editCompany input[name='address']").attr("value",data.address);
            },
            error:function (data) {

            }

        });
        //页面层
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '240px'], //宽高
            content: $('#editCompany'),
        });
    }

    function closeComLayer() {
        $("#editCompany").css("display","none");
        layer.close(index);
    }
    function submitComInfo() {
        var branchCompany=$("#editCompany").serialize();

        $.ajax({
            type:"POST",
            dataType:"json",
            url:"sysIndex/editBranchCompany.do",
            data:branchCompany,
            success:function (data) {
                if(data.state=="success"){
                    layer.msg("修改成功",{time:1000},function () {
                        closeComLayer();
                        getBranchCompanyList();
                    });
                }
                else
                    layer.msg("修改失败");
            }
        });
        return false;
    }


    function changeHeatAreaInfo(id) {
        $.ajax({
            type:"GET",
            dataType:"json",
            url:"sysIndex/getHeatArea.do",
            data:{
                id:id
            },
            async:false,
            success:function (data) {
                $("#editHeatArea input[name='id']").attr("value",data.id);
                $("#editHeatArea input[name='name']").attr("value",data.name);
                $("#editHeatArea input[name='address']").attr("value",data.address);
                $("#editHeatArea input[name='initial_heat']").attr("value",data.initial_heat);
                $("#editHeatArea input[name='end_heat']").attr("value",data.end_heat);
            },
            error:function (data) {

            }

        });
        //页面层
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '400px'], //宽高
            content: $('#editHeatArea'),
        });
    }

    function closeHeatAreaLayer() {
        $("#editHeatArea").css("display","none");
        layer.close(index);
    }
    function submitHeatAreaInfo() {
        var heatArea=$("#editHeatArea").serialize();
        $.ajax({
            type:"POST",
            dataType:"json",
            url:"sysIndex/editHeatArea.do",
            data:heatArea,
            success:function (data) {
                if(data.state=="success"){
                    layer.msg("修改成功",{time:1000},function () {
                        closeHeatAreaLayer();
                        var companyId=$("#companyId").val();
                        getAreaByCompanyId(companyId);
                    });
                }
                else
                    layer.msg("修改失败");
            }
        });
        return false;
    }
    function changeZonesInfo(id) {
        $.ajax({
            type:"GET",
            dataType:"json",
            url:"sysIndex/getZones.do",
            data:{
                id:id
            },
            async:false,
            success:function (data) {
                $("#editZones input[name='id']").attr("value",data.id);
                $("#editZones input[name='z_name']").attr("value",data.z_name);
                $("#editZones input[name='address']").attr("value",data.address);
            },
            error:function (data) {

            }

        });
        //页面层
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '240px'], //宽高
            content: $('#editZones'),
        });
    }

    function closeZonesLayer() {
        $("#editZones").css("display","none");
        layer.close(index);
    }
    function submitZonesInfo() {
        var zones=$("#editZones").serialize();

        $.ajax({
            type:"POST",
            dataType:"json",
            url:"sysIndex/editZones.do",
            data: zones,
            success:function (data) {
                if(data.state=="success"){

                    layer.msg("修改成功",{time:1000},function () {
                        closeZonesLayer();
                        var areaId=$("#areaId").val();
                        getZoneByAreaId(areaId);
                    });
                }
                else
                    layer.msg("修改失败");
            }
        });
        return false;
    }

    function deleteBranchCompany(id) {
        layer.confirm('确定删除吗?', function(index){
            $.ajax({
                type:"GET",
                dataType:"json",
                url:"sysIndex/deleteBranchCompany.do",
                data:{
                    id:id
                },
                async:false,
                success:function (data) {
                    if(data.state=="success"){
                        layer.msg("操作成功");
                        getBranchCompanyList();
                    }else {
                        layer.msg("操作失败");
                    }
                },
                error:function (data) {
                    layer.msg("操作失败");
                }
            });
        });

    }
    function deleteHeatArea(id) {
        layer.confirm('确定删除吗?', function(index){
            $.ajax({
                type:"GET",
                dataType:"json",
                url:"sysIndex/deleteHeatArea.do",
                data:{
                    id:id
                },
                async:false,
                success:function (data) {
                    if(data.state=="success"){
                        layer.msg("操作成功");
                        var companyId=$("#companyId").val();
                        getAreaByCompanyId(companyId);
                        //   get
                    }else {
                        layer.msg("操作失败");
                    }
                },
                error:function (data) {
                    layer.msg("操作失败");
                }
            });
        });

    }
    function deleteZones(id) {
        layer.confirm('确定删除吗?', function(index){
            $.ajax({
                type:"GET",
                dataType:"json",
                url:"sysIndex/deleteZones.do",
                data:{
                    id:id
                },
                async:false,
                success:function (data) {
                    if(data.state=="success"){
                        layer.msg("操作成功");
                        var areaId=$("#areaId").val();
                        getZoneByAreaId(areaId);
                    }else {
                        layer.msg("操作失败");
                    }
                },
                error:function (data) {
                    layer.msg("操作失败");
                }
            });
        });

    }
</script>
</body>
</html>
