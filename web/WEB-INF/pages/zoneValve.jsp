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
                    <li class="layui-this" onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">

                    <%--阀门管理--%>
                    <div class="layui-tab-item layui-show">
                        <div id="valveButton">
                            <input type="text" id="valveOnlineState" hidden>
                            <button class='layui-btn layui-btn-sm ' id="allValveCount">全部<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="onlineValveCount">
                                在线<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="offlineValveCount">
                                离线<span></span></button>
                        </div>
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg5 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                阀门列表
                                            </div>
                                            <div class="layui-col-lg7 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;" onclick="downloadRoomValveTemplate()">下载模板</a>
                                                <a href="javascript:;" id="importRoomValve">导入阀门信息</a>
                                                <a href="javascript:;" onclick="exportRoomValve()">导出Excel</a>


                                                <form class="layui-form " style=" width: 300px;float:right">
                                                    <div class="layui-inline">
                                                        <%--<div class="layui-input-block">--%>
                                                        <input type="text" id="roomValveSearch" class="layui-input"
                                                               style="height: 30px">
                                                        <%--</div>--%>
                                                    </div>
                                                    <div class="layui-inline" style="padding-left: 30px">
                                                        <button onclick="searchRoomValve()" type="button"
                                                                class="layui-btn layui-btn-sm layui-btn-primary">搜索
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>

                                            <%--</div>--%>
                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="roomValveList" lay-filter="operation6"></table>
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
    roomValveInfo();


    //阀门
    function roomValveInfo() {
        $.ajax({
            url: "sysIndex/getValveCount.do?zone_id=" + zone_id,
            async: 'false',
            dataType: 'json',
            type: 'GET',
            success: function (res) {
                $("#allValveCount span ").html("(" + res.all + ")");
                $("#onlineValveCount span ").html("(" + res.online + ")");
                $("#offlineValveCount span ").html("(" + res.offline + ")");
            }
        })
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomValveList'
                , url: 'sysIndex/roomValveList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                        , {field: 'valve_addr', title: '阀门地址', width: 80, maxWidth: 200}
                        , {field: 'valve_model', title: '阀门型号', width: 80, maxWidth: 200}
                        , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                        , {field: 'set_temp', title: '设置温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'room_temp', title: '室内温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'valve_state', title: '阀门状态', width: 80, maxWidth: 200}
                        , {field: 'open_hours', title: '开阀时间(h)', width: 80, maxWidth: 200}
                        , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'given_out_temp', title: '给定回水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'power_status', title: '电源状态', width: 80, maxWidth: 200}
                        , {field: '', title: '读取时间', width: 80, maxWidth: 200}
                        , {field: 'err_list', title: '故障信息', width: 80, maxWidth: 200}
                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
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
            elem: '#importRoomValve' //绑定元素
            , url: 'sysIndex/importRoomValve.do' //上传接口
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
                roomValveInfo();
            }
            , error: function (res) {
                //请求异常回调
                layer.msg(res.message);
            }
        });
    });

    function downloadRoomValveTemplate() {
        var url = "sysIndex/downloadRoomValveTemplate.do";
        window.open(url);
    }

    function exportRoomValve() {
        var valveOnlineState = $("#valveOnlineState").val();
        var url = "sysIndex/exportRoomValve.do?zone_id=" + zone_id + "&onlineState=" + valveOnlineState;
        window.open(url);
    }

    var roomValveListObj = new Array();

    function searchRoomValve() {
        var valveOnlineState = $("#valveOnlineState").val();
        $.ajax({
            url: 'sysIndex/allRoomValve.do',
            data: {zone_id: zone_id, onlineState: valveOnlineState},
            dataType: 'json',
            type: 'GET',
            async: false,
            success: function (res) {
                roomValveListObj = res;
            },
            error: function () {
            }
        });
        var key = $("#roomValveSearch").val();
        if (key != null && key != "") {
            var str = "";
            var temp = new Array();
            var l = roomValveListObj.length;
            for (var i = 0; i < l; i++) {
                for (var k in roomValveListObj[i]) {
                    str = JSON.stringify(roomValveListObj[i][k]);
                    //    console.log(str);
                    if (str.indexOf(key) != -1) {
                        temp.push(roomValveListObj[i]);
                        break;
                    }
                }
            }
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomValveList'
                    , data: temp
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                            , {field: 'valve_addr', title: '阀门地址', width: 80, maxWidth: 200}
                            , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                            , {field: 'set_temp', title: '设置温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'room_temp', title: '室内温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'valve_state', title: '阀门状态', width: 80, maxWidth: 200}
                            , {field: 'open_hours', title: '开阀时间(h)', width: 80, maxWidth: 200}
                            , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'given_out_temp', title: '给定回水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'power_status', title: '电源状态', width: 80, maxWidth: 200}
                            , {field: '', title: '读取时间', width: 80, maxWidth: 200}
                            , {field: 'err_list', title: '故障信息', width: 80, maxWidth: 200}
                            // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
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
                    elem: '#roomValveList'
                    , data: roomValveListObj
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                            , {field: 'valve_addr', title: '阀门地址', width: 80, maxWidth: 200}
                            , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                            , {field: 'set_temp', title: '设置温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'room_temp', title: '室内温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'valve_state', title: '阀门状态', width: 80, maxWidth: 200}
                            , {field: 'open_hours', title: '开阀时间(h)', width: 80, maxWidth: 200}
                            , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'given_out_temp', title: '给定回水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'power_status', title: '电源状态', width: 80, maxWidth: 200}
                            , {field: '', title: '读取时间', width: 80, maxWidth: 200}
                            , {field: 'err_list', title: '故障信息', width: 80, maxWidth: 200}
                            // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
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

    $("#valveButton button").on("click", function () {
        $("#valveButton button").addClass("layui-btn-primary");
        $(this).removeClass("layui-btn-primary");
        if (this.id == "onlineValveCount") {
            $("#valveOnlineState").val("online");
        } else if (this.id == "offlineValveCount") {
            $("#valveOnlineState").val("offline");
        } else {
            $("#valveOnlineState").val("");
        }
        var valveOnlineState = $("#valveOnlineState").val();
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomValveList'
                , url: 'sysIndex/roomValveList.do?zone_id=' + zone_id + "&onlineState=" + valveOnlineState
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                        , {field: 'valve_addr', title: '阀门地址', width: 80, maxWidth: 200}
                        , {field: 'data_time', title: '数据时间', width: 100, maxWidth: 200}
                        , {field: 'set_temp', title: '设置温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'room_temp', title: '室内温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'valve_state', title: '阀门状态', width: 80, maxWidth: 200}
                        , {field: 'open_hours', title: '开阀时间(h)', width: 80, maxWidth: 200}
                        , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'given_out_temp', title: '给定回水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'power_status', title: '电源状态', width: 80, maxWidth: 200}
                        , {field: '', title: '读取时间', width: 80, maxWidth: 200}
                        , {field: 'err_list', title: '故障信息', width: 80, maxWidth: 200}
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

