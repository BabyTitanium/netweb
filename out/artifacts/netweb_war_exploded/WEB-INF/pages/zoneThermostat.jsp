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
    <link rel="stylesheet" href="/colpicker/css/colpick.css">
    <script src="/colpicker/js/colpick.js"></script>
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
                    <li onclick="parameterSettingPage()">参数设置</li>
                    <li onclick="roomMeterInfoPage()">热量表管理</li>
                    <li onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li class="layui-this" onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">

                    <%--无线面板管理--%>
                    <div class="layui-tab-item layui-show">
                        <div id="thermostatButton">
                            <input type="text" id="thermostatOnlineState" hidden>
                            <button class='layui-btn layui-btn-sm ' id="allThermostatCount">全部<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="onlineThermostatCount">
                                在线<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="offlineThermostatCount">
                                离线<span></span></button>
                        </div>
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg5 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                无线面板列表
                                            </div>
                                            <div class="layui-col-lg7 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;"
                                                   onclick="downloadRoomThermostatTemplate()">下载模板</a>
                                                <a href="javascript:;" id="importRoomThermostat">导入无线面板信息</a>
                                                <a href="javascript:;" onclick="exportRoomThermostat()">导出Excel</a>


                                                <form class="layui-form " style=" width: 300px;float:right">
                                                    <div class="layui-inline">
                                                        <%--<div class="layui-input-block">--%>
                                                        <input type="text" id="roomThermostatSearch" class="layui-input"
                                                               style="height: 30px">
                                                        <%--</div>--%>
                                                    </div>
                                                    <div class="layui-inline" style="padding-left: 30px">
                                                        <button onclick="searchRoomThermostat()" type="button"
                                                                class="layui-btn layui-btn-sm layui-btn-primary">搜索
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>

                                            <%--</div>--%>
                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="roomThermostatList" lay-filter="operation7"></table>
                                        </div>
                                    </div>
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
    roomThermostatInfo();

    //无线面板

    function roomThermostatInfo() {
        $.ajax({
            url: "sysIndex/getThermostatCount.do?zone_id=" + zone_id,
            async: 'false',
            dataType: 'json',
            type: 'GET',
            success: function (res) {
                $("#allThermostatCount span ").html("(" + res.all + ")");
                $("#onlineThermostatCount span ").html("(" + res.online + ")");
                $("#offlineThermostatCount span ").html("(" + res.offline + ")");
            }
        })
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomThermostatList'
                , url: 'sysIndex/roomThermostatList.do?zone_id=' + zone_id

                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', minWidth: 80, sort: true}
                        , {field: 'node_addr', title: '面板地址', minWidth: 80}
                        , {field: 'thermostat_model', title: '面板型号', minWidth: 80}
                        , {field: 'data_time', title: '数据时间', minWidth: 100}
                        , {field: 'room_temp', title: '室内温度(°C)', minWidth: 80}
                        , {field: 'set_temp', title: '设置温度(°C)', minWidth: 80}
                        , {field: 'battery', title: '电池电压(V)', minWidth: 80}
                        , {field: 'fixture_num', title: '移动序号', minWidth: 80}
                        , {field: 'fixture', title: '固定标识', minWidth: 80}
                        , {field: 'err_list', title: '错误列表', minWidth: 80}
                    ]

                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10

            });


        })
    }

    layui.use('upload', function () {
        var upload = layui.upload;
        //执行实例
        var uploadInst = upload.render({
            elem: '#importRoomThermostat' //绑定元素
            , url: 'sysIndex/importRoomThermostat.do' //上传接口
            , exts: 'xlsx'
            , accept: 'file'
            , data: {
                zone_id: zone_id
            }
            , before: function (obj) { //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                layer.load(); //上传loading
            }
            , done: function (res) {
                //上传完毕回调
                if (res.code == 0) {
                    layer.closeAll('loading'); //关闭loading
                    layer.open({
                        title: "信息"
                        , content: res.message + "插入" + res.inserts + "条，更新" + res.updates + "条"
                    });
                }
                else {
                    layer.closeAll('loading'); //关闭loading
                    layer.open({
                        title: "信息"
                        , content: res.message
                    });
                }
                roomThermostatInfo();
            }
            , error: function (res) {
                //请求异常回调
                layer.msg(res.message);
            }
        });
    });

    function downloadRoomThermostatTemplate() {
        var url = "sysIndex/downloadRoomThermostatTemplate.do";
        window.open(url);
    }

    function exportRoomThermostat() {
        var thermostatOnlineState = $("#thermostatOnlineState").val();
        var url = "sysIndex/exportRoomThermostat.do?zone_id=" + zone_id + "&onlineState=" + thermostatOnlineState;
        window.open(url);
    }

    var roomThermostatListObj = new Array();

    function searchRoomThermostat() {
        var thermostatOnlineState = $("#thermostatOnlineState").val();
        $.ajax({
            url: 'sysIndex/allRoomThermostat.do',
            data: {zone_id: zone_id, onlineState: thermostatOnlineState},
            dataType: 'json',
            type: 'GET',
            async: false,
            success: function (res) {
                roomThermostatListObj = res;
            },
            error: function () {
            }
        });
        var key = $("#roomThermostatSearch").val();
        if (key != null && key != "") {
            var str = "";
            var temp = new Array();
            var l = roomThermostatListObj.length;
            for (var i = 0; i < l; i++) {
                for (var k in roomThermostatListObj[i]) {
                    str = JSON.stringify(roomThermostatListObj[i][k]);
                    //    console.log(str);
                    if (str.indexOf(key) != -1) {
                        temp.push(roomThermostatListObj[i]);
                        break;
                    }
                }
            }
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomThermostatList'
                    , data: temp
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', minWidth: 80, sort: true}
                            , {field: 'node_addr', title: '面板地址', minWidth: 80}
                            , {field: 'thermostat_model', title: '面板型号', minWidth: 80}
                            , {field: 'data_time', title: '数据时间', minWidth: 100}
                            , {field: 'room_temp', title: '室内温度(°C)', minWidth: 80}
                            , {field: 'set_temp', title: '设置温度(°C)', minWidth: 80}
                            , {field: 'battery', title: '电池电压(V)', minWidth: 80}
                            , {field: 'fixture_num', title: '移动序号', minWidth: 80}
                            , {field: 'fixture', title: '固定标识', minWidth: 80}
                            , {field: 'err_list', title: '错误列表', minWidth: 80}
                        ]
                    ]
                    , skin: 'row' //表格风格
                    , even: true
                    , page: true //是否显示分页
                    , limit: 10

                });

            })
        } else {
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomThermostatList'
                    , data: roomThermostatListObj
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', minWidth: 80, sort: true}
                            , {field: 'node_addr', title: '面板地址', minWidth: 80}
                            , {field: 'thermostat_model', title: '面板型号', minWidth: 80}
                            , {field: 'data_time', title: '数据时间', minWidth: 100}
                            , {field: 'room_temp', title: '室内温度(°C)', minWidth: 80}
                            , {field: 'set_temp', title: '设置温度(°C)', minWidth: 80}
                            , {field: 'battery', title: '电池电压(V)', minWidth: 80}
                            , {field: 'fixture_num', title: '移动序号', minWidth: 80}
                            , {field: 'fixture', title: '固定标识', minWidth: 80}
                            , {field: 'err_list', title: '错误列表', minWidth: 80}
                        ]
                    ]
                    , skin: 'row' //表格风格
                    , even: true
                    , page: true //是否显示分页
                    , limit: 10

                });

            })
        }
    }

    $("#thermostatButton button").on("click", function () {
        $("#thermostatButton button").addClass("layui-btn-primary");
        $(this).removeClass("layui-btn-primary");
        if (this.id == "onlineThermostatCount") {
            $("#thermostatOnlineState").val("online");
        } else if (this.id == "offlineThermostatCount") {
            $("#thermostatOnlineState").val("offline");
        } else {
            $("#thermostatOnlineState").val("");
        }
        var thermostatOnlineState = $("#thermostatOnlineState").val();
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomThermostatList'
                , url: 'sysIndex/roomThermostatList.do?zone_id=' + zone_id + "&onlineState=" + thermostatOnlineState
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', minWidth: 80, sort: true}
                        , {field: 'node_addr', title: '面板地址', minWidth: 80}
                        , {field: 'thermostat_model', title: '面板型号', minWidth: 80}
                        , {field: 'data_time', title: '数据时间', minWidth: 100}
                        , {field: 'room_temp', title: '室内温度(°C)', minWidth: 80}
                        , {field: 'set_temp', title: '设置温度(°C)', minWidth: 80}
                        , {field: 'battery', title: '电池电压(V)', minWidth: 80}
                        , {field: 'fixture_num', title: '移动序号', minWidth: 80}
                        , {field: 'fixture', title: '固定标识', minWidth: 80}
                        , {field: 'err_list', title: '错误列表', minWidth: 80}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10

            });
        })
    });

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

