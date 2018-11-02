<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/30
  Time: 17:21
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
    <link rel="stylesheet" href="layui/css/my.css">
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <%--颜色选择--%>
    <link rel="stylesheet" href="colpicker/css/colpick.css">
    <script src="colpicker/js/colpick.js"></script>
    <style>
        /*#buildings span{*/
        /*color: black;*/
        /*}*/
        .content .layui-card-header a {
            color: #009688;
            margin: 0 10px;
        }

        .content .layui-card-header .right {
            text-align: right;
        }

        .layui-table-cell {
            height: auto;
            line-height: 28px;
            padding: 0 10px;
            position: relative;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal;
            box-sizing: border-box;
        }

        @media screen and (min-width: 1400px) {
            .layui-container {
                width: 1200px;
            }
        }

        #buildings button {
            margin-top: 10px;
        }
        .intemp .layui-input{
            border:none;
        }
        /*.intemp .layui-input{*/
        /*border:none;*/
        /*}*/
        .colpick{
            z-index: 9999;
        }
        .picker {

            margin:0;

            padding:0;

            border:0;

            width:0px;

            height:25px;

            border-right:60px solid green;

            line-height:20px;

        }
        .roomTemp th{
            width:25%;
        }
        .roomTemp td{
            width:25%;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="header.jsp"/>
    <jsp:include page="left.jsp">
        <jsp:param value="sysIndex" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-container">
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title">
                    <li onclick="roomInfoPage()">房间信息管理</li>
                    <li onclick="buildingInfoPage()">楼栋管理</li>
                    <li onclick="branchInfoPage()">分支管理</li>
                    <li onclick="alarmsInfoPage()">故障报警设置</li>
                    <li class="layui-this" onclick="parameterSettingPage()">参数设置</li>

                    <li onclick="roomMeterInfoPage()">热量表管理</li>
                    <li onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">

                    <%--参数设置--%>
                    <div class="layui-tab-item layui-show">
                        <div >
                            <div class="layui-row">
                                <div class="layui-col-lg12">
                                    <form id="zoneBasicInfo" onsubmit="return zoneBasicInfo();"  style="width:100%">
                                        <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-1"
                                             style="">
                                            <div class="layui-table-box">
                                                <div class="layui-table-header" style="padding: 10px">
                                                    <table cellspacing="0" cellpadding="" border="0" class="layui-table">
                                                        <thead>
                                                        <span>基础信息</span>
                                                        <span style="float: right">
                                                         <button class="layui-btn layui-btn-primary layui-btn-sm" lay-submit type="submit" >保存</button>
                                                         <%--<button class="layui-btn layui-btn-primary layui-btn-sm" type="button" onclick="getZoneBasicInfo();">刷新</button>--%>
                                                        </span>
                                                        </thead>
                                                    </table>
                                                </div>
                                                <div class="layui-table-body layui-table-main">
                                                    <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%" >
                                                        <tbody>
                                                        <tr data-index="0" class="">
                                                            <td style="width:10%" >
                                                                <div class="layui-table-cell ">计量方式</div>
                                                            </td>

                                                            <td style="width:23%;">
                                                                <div class="layui-table-cell">
                                                                    <select lay-ignore name="heat_type" style="display: block;height: 28px;width:150px">

                                                                        <option value="0">温控一体化</option>
                                                                        <option value="2">通断时间面积法</option>
                                                                        <option value="1" >温度面积法</option>
                                                                    </select>
                                                                </div>

                                                            </td>
                                                            <td style="width:10%">
                                                                <div class="layui-table-cell ">小区地址</div>
                                                            </td>
                                                            <td  style="border-right: none; width: 53%">
                                                                <div class="layui-table-cell">
                                                                    <input type="text" name="address" class="layui-input" style="border:  none;">
                                                                </div>
                                                            </td>

                                                        </tr>

                                                        </tbody>
                                                    </table>
                                                    <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%" >
                                                        <tbody>
                                                        <tr data-index="1" class="">

                                                            <td style="width: 10%;">
                                                                <div class="layui-table-cell" >
                                                                    保障室温
                                                                </div>
                                                            </td>
                                                            <td style="width: 23%">
                                                                <div class="layui-table-cell" style="margin-right: 20px">
                                                                    <input type="text" name="min_indoor_temp" class="layui-input" style="border:  none;" placeholder="℃">
                                                                </div>
                                                            </td>
                                                            <td style="width: 10%">
                                                                <div class="layui-table-cell ">建议室温</div>
                                                            </td>
                                                            <td  style="width: 23%">
                                                                <div class="layui-table-cell ">
                                                                    <input type="text" name="adviced_indoor_temp" class="layui-input" style="border:  none;" placeholder="℃">
                                                                </div>
                                                            </td>
                                                            <td  style="width: 10%">
                                                                <div class="layui-table-cell">最高室温</div>
                                                            </td>
                                                            <td  style="width: 24%">
                                                                <div class="layui-table-cell ">
                                                                    <input type="text" name="max_indoor_temp" class="layui-input" style="border:  none;" placeholder="℃">
                                                                </div>
                                                            </td>

                                                        </tr>

                                                        </tbody>
                                                    </table>
                                                    <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%" >
                                                        <tbody>
                                                        <tr data-index="0" class="">
                                                            <td style="width:10%" >
                                                                <div class="layui-table-cell ">最大流量</div>
                                                            </td>

                                                            <td style="width:33%">
                                                                <div class="layui-table-cell" >
                                                                    <input type="text" name="max_flow" class="layui-input" style="border:  none;"  placeholder="m³">
                                                                </div>


                                                            </td>
                                                            <td style="width:10%">
                                                                <div class="layui-table-cell">最低回水温度</div>
                                                            </td>
                                                            <td  style="border-right: none; width: 33%">
                                                                <div class="layui-table-cell">
                                                                    <input type="text" name="min_return_temp" class="layui-input" style="border:  none;"  placeholder="℃">
                                                                </div>
                                                            </td>


                                                        </tr>

                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-col-lg5 layui-col-md5 layui-col-sm12 layui-col-xs12 roomTemp">
                                    <table class="layui-table intemp" lay-skin="" id="roomtemp" style="margin-bottom: 0">
                                        <colgroup>
                                            <col width="150">
                                            <col width="150">
                                            <col width="200">
                                            <col>
                                        </colgroup>
                                        <thead>

                                        <th colspan="2" style="border-right: none">室内温度区间设定</th>
                                        <th colspan="2" style="border-left:none">
                                            <button class="layui-btn layui-btn-primary layui-btn-sm"  type="button" onclick="addRoomTemp();" >添加</button>
                                            <%--<button class="layui-btn layui-btn-primary layui-btn-sm" type="button" onclick="getInTempInfo();">刷新</button>--%>
                                        </th>

                                        <tr>
                                            <th>起始值</th>
                                            <th>结束值</th>
                                            <th>颜色标识</th>
                                            <th></th>
                                        </tr>

                                        </thead>
                                    </table>
                                    <div id="tablecontent1">

                                    </div>

                                </div>
                                <div class="layui-col-lg5 layui-col-lg-offset1 layui-col-md-offset1 layui-col-md5 layui-col-sm12 layui-col-xs12 roomTemp">
                                    <table class="layui-table intemp" lay-skin="" id="outtemp" style="margin-bottom: 0">
                                        <colgroup>
                                            <col width="150">
                                            <col width="150">
                                            <col width="200">
                                            <col>
                                        </colgroup>
                                        <thead>

                                        <th colspan="2" style="border-right: none">回水温度区间设定</th>
                                        <th colspan="2" style="border-left:none">
                                            <button class="layui-btn layui-btn-primary layui-btn-sm"  type="button" onclick="addOutTemp();" >添加</button>
                                            <%--<button class="layui-btn layui-btn-primary layui-btn-sm" type="button" onclick="getOutTempInfo();">刷新</button>--%>
                                        </th>

                                        <tr>
                                            <th>起始值</th>
                                            <th>结束值</th>
                                            <th>颜色标识</th>
                                            <th></th>
                                        </tr>

                                        </thead>
                                    </table>
                                    <div id="tablecontent2">

                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-col-lg10 layui-col-md10 layui-col-sm10 layui-col-xs12">
                                    <fieldset  class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                                        <legend>数据源设置</legend>
                                    </fieldset>
                                    <form id="dataSource" lay-filter="dataSource" class="layui-form" onsubmit="return submitDataSource()">
                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <label class="layui-form-label"><strong>进水温度：</strong></label>
                                                <div class="layui-input-block" id="int">
                                                    <input type="radio" name="in_temp" value="1" title="热量表" >
                                                    <input type="radio" name="in_temp" value="2" title="阀门">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <label class="layui-form-label"><strong>回水温度：</strong></label>
                                                <div class="layui-input-inline" id="outt">
                                                    <input type="radio" name="out_temp" value="1" title="热量表" >
                                                    <input type="radio" name="out_temp" value="2" title="阀门">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <label class="layui-form-label"><strong>室内温度：</strong></label>
                                                <div class="layui-input-block" id="roomt">
                                                    <input type="radio" name="room_temp" value="1" title="阀门" >
                                                    <input type="radio" name="room_temp" value="2" title="无线面板">
                                                    <input type="radio" name="room_temp" value="4" title="测温节点" >
                                                    <input type="radio" name="room_temp" value="3" title="均值">
                                                </div>
                                            </div>

                                        </div>
                                        <div class="layui-form-item" style="padding-left: 40px">
                                            <button class="layui-btn" type="submit">提交</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>

</div>

<script type="text/javascript" src="layui/layui.all.js"></script>
<% String id = request.getParameter("id");%>
<script type="text/javascript">
    var ids = new Array();
    var table_data = new Array();
    var zone_id =<%=id%>;
    var index;
    parameterSetting();

    //参数设置
    function parameterSetting() {
        getZoneBasicInfo();
        getInTempInfo();
        getOutTempInfo();
        getDataSource();
    }
    function getZoneBasicInfo() {
        $.ajax({
            url:'sysIndex/getZoneBasicInfo.do',
            async:false,
            data:{zone_id:zone_id},
            type:"GET",
            dataType:'json',
            success:function (res) {
                $("#zoneBasicInfo select[name='heat_type']").val(res.heat_type);
                $("#zoneBasicInfo input[name='address']").val(res.address);
                $("#zoneBasicInfo input[name='min_indoor_temp']").val(res.min_indoor_temp);
                $("#zoneBasicInfo input[name='adviced_indoor_temp']").val(res.adviced_indoor_temp);
                $("#zoneBasicInfo input[name='max_indoor_temp']").val(res.max_indoor_temp);
                $("#zoneBasicInfo input[name='max_flow']").val(res.max_flow);
                $("#zoneBasicInfo input[name='min_return_temp']").val(res.min_return_temp);
            }
        });
    }
    function zoneBasicInfo() {
        var zones=$.param({"id":zone_id})+"&"+$("#zoneBasicInfo").serialize();
        var m=9;
        $.ajax({
            url:'sysIndex/zoneBasicInfo.do',
            async:false,
            data:zones,
            type:"POST",
            dataType:'json',
            success:function (res) {
                layer.msg("修改成功");
            },
            error:function () {
                layer.msg("修改失败");
            }
        });
        return false;
    }
    // initColor("#picker1")
    function initColor(name,color){
        if(color!=undefined&&color!=null&color.length!=0){
            $(name).colpick({
                layout:'hex',
                submit:0,
                colorScheme:'dark',
                color:color,
                onChange:function(hsb,hex,rgb,el,bySetColor) {
                    $(el).css('border-color','#'+hex);
                    // Fill the text box just if the color was set using the picker, and not the colpickSetColor function.
                    if(!bySetColor) $(el).val(hex);
                }
            }).keyup(function(){
                $(this).colpickSetColor(this.value);
            });
        }else{
            $(name).colpick({
                layout:'hex',
                submit:0,
                colorScheme:'dark',
                onChange:function(hsb,hex,rgb,el,bySetColor) {
                    $(el).css('border-color','#'+hex);
                    // Fill the text box just if the color was set using the picker, and not the colpickSetColor function.
                    if(!bySetColor) $(el).val(hex);
                }
            }).keyup(function(){
                $(this).colpickSetColor(this.value);
            });
        }
    }
    function getInTempInfo(){
        $.ajax({
            url:'sysIndex/getInTempInfo.do',
            async:false,
            data:{zone_id:zone_id},
            dataType:'json',
            type:'GET',
            success:function(res){
                var list=new Array();
                // if(res.length>0){
                var html="";
                var st=0;
                $(res).each(function (p) {

                    if(p==res.length-1){
                        var m=res[p];
                        html=html+"<form id='roomTemp"+m.id+"'><table class='layui-table' style='margin:0'><tr><td><input name='id' type='text' hidden value='"+m.id+"'>"+m.start+"</td>"
                            +"<td><input lay-verify='number' class='layui-input' type='text' name='end' style='min-width:30px;padding:0;height:30px' value='"+m.end+"'/></td>"
                            +"<td><input class='picker' lay-verify='required' name='color' type='text' id='picker"+m.id+"' value='"+m.color+"'/></td>"
                            +"<td style='min-width:30px'><i class='layui-icon' onclick='deleteRoomTemp("+m.id+")'>&#x1006;</i>  <i class='layui-icon' onclick='editRoomTemp(roomTemp"+m.id+")'>&#xe605;</i></td></tr></table></form>";
                        st=m.end;
                        var obj={"name":"#picker"+m.id,"color":m.color};
                        list.push(obj);
                    }else{
                        var m=res[p];
                        html=html+"<form id='roomTemp"+m.id+"'><table class='layui-table' style='margin:0'><tr><td><input name='id' type='text' hidden value='"+m.id+"'>"+m.start+"</td>"
                            +"<td>"+m.end+"</td>"
                            +"<td><input class='picker' lay-verify='required'  name='color' type='text' id='picker"+m.id+"' value='"+m.color+"'/></td>"
                            +"<td style='min-width:30px;'><i class='layui-icon' onclick=editRoomTemp('#roomTemp"+m.id+"')>&#xe605;</i></td></tr></table></form>";
                        st=m.end;
                        var obj={"name":"#picker"+m.id,"color":m.color};
                        list.push(obj);
                    }
                });
                $("#tablecontent1").html(html+"<form hidden id='addRoomTemp'><table class='layui-table' style='margin:0'><tr><td><input class='layui-input' type='text' name='start' readonly style='min-width:30px;padding:0;height:30px' value='"+st+"'/></td>"
                    +"<td><input lay-verify='number' class='layui-input' type='text' name='end' style='min-width:30px;padding:0;height:30px'/></td>"
                    +"<td><input class='picker' lay-verify='required' type='text' name='color' id='addpicker'/></td>"
                    +"<td style='min-width:30px;'><i class='layui-icon' onclick='cancelAddRoomTemp()'>&#x1006;</i>  <i class='layui-icon' onclick='submitRoomTemp();'>&#xe605;</i></td></tr></table></form>");
                $(list).each(function (c) {
                    var obj=list[c];
                    initColor(obj.name,obj.color);
                    $(obj.name).css("border-color","#"+obj.color);
                })
                if(res.length<=0){
                    $("#addRoomTemp").css("display","block");
                }

            }
        });
        initColor("#addpicker");
    }
    function addRoomTemp() {
        $("#addRoomTemp").css("display","block");
    }
    function cancelAddRoomTemp() {
        $("#addRoomTemp").css("display","none");
    }
    function submitRoomTemp(){

        var roomTemp=$.param({zone_id:zone_id})+"&"+$("#addRoomTemp").serialize();
        $.ajax({
            url:'sysIndex/addRoomTemp.do',
            data:roomTemp,
            dataType:'json',
            async:false,
            type:'GET',
            success:function(res){
                layer.msg("操作成功");
                getInTempInfo();
            },
            error:function(){
                layer.msg("操作失败");
            }
        });
    }

    function editRoomTemp(formid){
        var roomTemp=$(formid).serialize();
        console.log(roomTemp);
        $.ajax({
            url:'sysIndex/editRoomTemp.do',
            data:roomTemp,
            type:'POST',
            dataType:'json',
            async:false,
            success:function(res){
                layer.msg("操作成功");
                getInTempInfo();
            },
            error:function(res){
                layer.msg("操作失败");
            }
        })
    }
    function deleteRoomTemp(id){
        $.ajax({
            url:'sysIndex/deleteRoomTemp.do',
            data:{id:id},
            type:'POST',
            dataType:'json',
            async:false,
            success:function(res){
                layer.msg("操作成功");
                getInTempInfo();
            },
            error:function(res){
                layer.msg("操作失败");
            }
        });
    }

    function getOutTempInfo(){
        $.ajax({
            url:'sysIndex/getOutTempInfo.do',
            async:false,
            data:{zone_id:zone_id},
            dataType:'json',
            type:'GET',
            success:function(res){
                var list=new Array();
                // if(res.length>0){
                var html="";
                var st=0;
                $(res).each(function (p) {

                    if(p==res.length-1){
                        var m=res[p];
                        html=html+"<form class='layui-form' id='outTemp"+m.id+"'><table class='layui-table' style='margin:0'><tr><td><input name='id' type='text' hidden value='"+m.id+"'>"+m.start+"</td>"
                            +"<td><input lay-verify='number' class='layui-input' type='text' name='end' style='min-width:30px;padding:0;height:30px' value='"+m.end+"'/></td>"
                            +"<td><input class='picker' lay-verify='required' name='color' type='text' id='pickers"+m.id+"' value='"+m.color+"'/></td>"
                            +"<td style='min-width:30px'><i class='layui-icon' onclick='deleteOutTemp("+m.id+")'>&#x1006;</i>  <i class='layui-icon' onclick='editOutTemp(outTemp"+m.id+")'>&#xe605;</i></td></tr></table></form>";
                        st=m.end;
                        var obj={"name":"#pickers"+m.id,"color":m.color};
                        list.push(obj);
                    }else{
                        var m=res[p];
                        html=html+"<form id='outTemp"+m.id+"'><table class='layui-table' style='margin:0'><tr><td><input hidden type='text' name='id' value='"+m.id+"'>"+m.start+"</td>"
                            +"<td>"+m.end+"</td>"
                            +"<td><input class='picker' lay-verify='required'  name='color' type='text' id='pickers"+m.id+"' value='"+m.color+"'/></td>"
                            +"<td style='min-width:30px;'><i class='layui-icon' onclick=editOutTemp('#outTemp"+m.id+"')>&#xe605;</i></td></tr></table></form>";
                        st=m.end;
                        var obj={"name":"#pickers"+m.id,"color":m.color};
                        list.push(obj);
                    }
                });
                $("#tablecontent2").html(html+"<form hidden id='addOutTemp'><table class='layui-table' style='margin:0'><tr><td><input class='layui-input' type='text' name='start' readonly style='min-width:30px;padding:0;height:30px' value='"+st+"'/></td>"
                    +"<td><input lay-verify='number' class='layui-input' type='text' name='end' style='min-width:30px;padding:0;height:30px'/></td>"
                    +"<td><input class='picker layui-input' lay-verify='required' type='text' name='color' id='addpickers'/></td>"
                    +"<td style='min-width:30px;'><i class='layui-icon' onclick='cancelAddOutTemp()'>&#x1006;</i>  <i class='layui-icon' onclick='submitOutTemp();'>&#xe605;</i></td></tr></table></form>");
                $(list).each(function (c) {
                    var obj=list[c];
                    initColor(obj.name,obj.color);
                    $(obj.name).css("border-color","#"+obj.color);
                })
                if(res.length<=0){
                    $("#addOutTemp").css("display","block");
                }

            }
        });
        initColor("#addpickers");

    }
    function addOutTemp() {
        $("#addOutTemp").css("display","block");
    }
    function cancelAddOutTemp() {
        $("#addOutTemp").css("display","none");
    }
    function submitOutTemp(){

        var outTemp=$.param({zone_id:zone_id})+"&"+$("#addOutTemp").serialize();
        $.ajax({
            url:'sysIndex/addOutTemp.do',
            data:outTemp,
            dataType:'json',
            async:false,
            type:'GET',
            success:function(res){
                layer.msg("操作成功");
                getOutTempInfo();
            },
            error:function(){
                layer.msg("操作失败");
            }
        });
    }

    function editOutTemp(formid){
        var outTemp=$(formid).serialize();

        $.ajax({
            url:'sysIndex/editOutTemp.do',
            data:outTemp,
            type:'POST',
            dataType:'json',
            async:false,
            success:function(res){
                layer.msg("操作成功");
                getOutTempInfo();
            },
            error:function(res){
                layer.msg("操作失败");
            }
        })
    }
    function deleteOutTemp(id){
        $.ajax({
            url:'sysIndex/deleteOutTemp.do',
            data:{id:id},
            type:'GET',
            dataType:'json',
            async:false,
            success:function(res){
                layer.msg("操作成功");
                getOutTempInfo();
            },
            error:function(res){
                layer.msg("操作失败");
            }
        });
    }



    function submitDataSource() {
        var dataSource=$.param({zone_id:zone_id})+"&"+$("#dataSource").serialize();
        $.ajax({
            url:'sysIndex/submitDataSource.do',
            data:dataSource,
            async:false,
            type:'GET',
            dataType:'json',
            success:function(){
                layer.msg("操作成功");
                getDataSource();
            },
            error:function(){
                layer.msg("操作失败");
            }
        });
        return false;
    }
    function getDataSource(){
        $.ajax({
            url:'sysIndex/getDataSource.do',
            data:{zone_id:zone_id},
            async:false,
            type:'GET',
            dataType:'json',
            success:function(res){

                $("#int input[value='"+res.in_temp+"']").attr("checked","checked");
                $("#outt input[value='"+res.out_temp+"']").attr("checked","checked");
                $("#roomt input[value='"+res.room_temp+"']").attr("checked","checked");
            },
            error:function(){

            }
        });
        layui.use('form', function() {
            var form = layui.form;
            form.render(null, 'dataSource');
        });
    }
    function roomInfoPage(){
        var url = "sysIndex/zoneRoomsManage.do?id="+zone_id;
        window.location.href=url;
    }
    function buildingInfoPage(){
        var url = "sysIndex/buildingInfoPage.do?id="+zone_id;
        window.location.href=url;
    }
    function branchInfoPage(){
        var url = "sysIndex/branchInfoPage.do?id="+zone_id;
        window.location.href=url;
    }
    function alarmsInfoPage(){
        var url = "sysIndex/alarmsInfoPage.do?id="+zone_id;
        window.location.href=url;
    }
    function parameterSettingPage(){
        var url = "sysIndex/parameterSettingPage.do?id="+zone_id;
        window.location.href=url;
    }

    function  roomMeterInfoPage(){
        var url = "sysIndex/roomMeterInfoPage.do?id="+zone_id;
        window.location.href=url;
    }

    function roomValveInfoPage(){
        var url = "sysIndex/roomValveInfoPage.do?id="+zone_id;
        window.location.href=url;
    }
    function roomTempInfoPage(){
        var url = "sysIndex/roomTempInfoPage.do?id="+zone_id;
        window.location.href=url;
    }
    function roomThermostatInfoPage(){
        var url = "sysIndex/roomThermostatInfoPage.do?id="+zone_id;
        window.location.href=url;
    }
</script>
</body>
</html>

