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
                    <li class="layui-this" onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">
                    <%--测温节点管理--%>
                    <div class="layui-tab-item layui-show">
                        <div id="tempButton">
                            <input type="text" id="tempOnlineState" hidden>
                            <button class='layui-btn layui-btn-sm ' id="allTempCount">全部<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="onlineTempCount">
                                在线<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="offlineTempCount">
                                离线<span></span></button>
                        </div>
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg5 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                测温节点列表
                                            </div>
                                            <div class="layui-col-lg7 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;" onclick="downloadRoomTempTemplate()">下载模板</a>
                                                <a href="javascript:;" id="importRoomTemp">导入测温节点信息</a>
                                                <a href="javascript:;" onclick="exportRoomTemp()">导出Excel</a>


                                                <form class="layui-form " style=" width: 300px;float:right">
                                                    <div class="layui-inline">
                                                        <%--<div class="layui-input-block">--%>
                                                        <input type="text" id="roomTempSearch" class="layui-input"
                                                               style="height: 30px">
                                                        <%--</div>--%>
                                                    </div>
                                                    <div class="layui-inline" style="padding-left: 30px">
                                                        <button onclick="searchRoomTemp()" type="button"
                                                                class="layui-btn layui-btn-sm layui-btn-primary">搜索
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>

                                            <%--</div>--%>
                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="roomTempList" lay-filter="operation7"></table>
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
    roomTempInfo();

    //测温节点
    function roomTempInfo() {
        $.ajax({
            url: "sysIndex/getTempCount.do?zone_id=" + zone_id,
            async: 'false',
            dataType: 'json',
            type: 'GET',
            success: function (res) {
                $("#allTempCount span ").html("(" + res.all + ")");
                $("#onlineTempCount span ").html("(" + res.online + ")");
                $("#offlineTempCount span ").html("(" + res.offline + ")");
            }
        })
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomTempList'
                , url: 'sysIndex/roomTempList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', minWidth: 100, sort: true}
                        , {field: 'temp_addr', title: '节点地址', minWidth: 100}
                        , {field: 'temp_model', title: '节点型号', minWidth: 100}
                        , {field: 'data_time', title: '数据时间', minWidth: 100}
                        , {field: 'temp', title: '室内温度(°C)', minWidth: 100}
                        , {field: 'battery', title: '电池电压(V)', minWidth: 100}
                        , {field: 'fixture_num', title: '移动序号', minWidth: 100}
                        , {field: 'fixture', title: '固定标识', minWidth: 100}
                        , {field: 'err_list', title: '错误列表', minWidth: 150}
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
            elem: '#importRoomTemp' //绑定元素
            , url: 'sysIndex/importRoomTemp.do' //上传接口
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
                roomTempInfo();
            }
            , error: function (res) {
                //请求异常回调
                layer.msg(res.message);
            }
        });
    });

    function downloadRoomTempTemplate() {
        var url = "sysIndex/downloadRoomTempTemplate.do";
        window.open(url);
    }

    function exportRoomTemp() {
        var tempOnlineState = $("#tempOnlineState").val();
        var url = "sysIndex/exportRoomTemp.do?zone_id=" + zone_id + "&onlineState=" + tempOnlineState;
        window.open(url);
    }

    var roomTempListObj = new Array();

    function searchRoomTemp() {
        var tempOnlineState = $("#tempOnlineState").val();
        $.ajax({
            url: 'sysIndex/allRoomTemp.do',
            data: {zone_id: zone_id, onlineState: tempOnlineState},
            dataType: 'json',
            type: 'GET',
            async: false,
            success: function (res) {
                roomTempListObj = res;
            },
            error: function () {
            }
        });
        var key = $("#roomTempSearch").val();
        if (key != null && key != "") {
            var str = "";
            var temp = new Array();
            var l = roomTempListObj.length;
            for (var i = 0; i < l; i++) {
                for (var k in roomTempListObj[i]) {
                    str = JSON.stringify(roomTempListObj[i][k]);
                    //    console.log(str);
                    if (str.indexOf(key) != -1) {
                        temp.push(roomTempListObj[i]);
                        break;
                    }
                }
            }
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomTempList'
                    , data: temp
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', width: 100, maxWidth: 200, sort: true}
                            , {field: 'temp_addr', title: '节点地址', width: 100, maxWidth: 200}
                            , {field: 'temp_model', title: '节点型号', width: 100, maxWidth: 200}
                            , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                            , {field: 'temp', title: '室内温度(°C)', width: 100, maxWidth: 200}
                            , {field: 'battery', title: '电池电压(V)', width: 100, maxWidth: 200}
                            , {field: 'fixture_num', title: '移动序号', width: 100, maxWidth: 200}
                            , {field: 'fixture', title: '固定标识', width: 100, maxWidth: 200}
                            , {field: 'err_list', title: '错误列表', width: 100, maxWidth: 200}
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
                    elem: '#roomTempList'
                    , data: roomTempListObj
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', width: 100, maxWidth: 200, sort: true}
                            , {field: 'temp_addr', title: '节点地址', width: 100, maxWidth: 200}
                            , {field: 'temp_model', title: '节点型号', width: 100, maxWidth: 200}
                            , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                            , {field: 'temp', title: '室内温度(°C)', width: 100, maxWidth: 200}
                            , {field: 'battery', title: '电池电压(V)', width: 100, maxWidth: 200}
                            , {field: 'fixture_num', title: '移动序号', width: 100, maxWidth: 200}
                            , {field: 'fixture', title: '固定标识', width: 100, maxWidth: 200}
                            , {field: 'err_list', title: '错误列表', width: 100, maxWidth: 200}
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

    $("#tempButton button").on("click", function () {
        $("#tempButton button").addClass("layui-btn-primary");
        $(this).removeClass("layui-btn-primary");
        if (this.id == "onlineTempCount") {
            $("#tempOnlineState").val("online");
        } else if (this.id == "offlineTempCount") {
            $("#tempOnlineState").val("offline");
        } else {
            $("#tempOnlineState").val("");
        }
        var tempOnlineState = $("#tempOnlineState").val();
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomTempList'
                , url: 'sysIndex/roomTempList.do?zone_id=' + zone_id + "&onlineState=" + tempOnlineState
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', width: 100, maxWidth: 200, sort: true}
                        , {field: 'temp_addr', title: '节点地址', width: 100, maxWidth: 200}
                        , {field: 'temp_model', title: '节点型号', width: 100, maxWidth: 200}
                        , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                        , {field: 'temp', title: '室内温度(°C)', width: 100, maxWidth: 200}
                        , {field: 'battery', title: '电池电压(V)', width: 100, maxWidth: 200}
                        , {field: 'fixture_num', title: '移动序号', width: 100, maxWidth: 200}
                        , {field: 'fixture', title: '固定标识', width: 100, maxWidth: 200}
                        , {field: 'err_list', title: '错误列表', width: 100, maxWidth: 200}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10

            });
        })
    });
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

