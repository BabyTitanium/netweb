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
                    <li class="layui-this" onclick="alarmsInfoPage()">故障报警设置</li>
                    <li onclick="parameterSettingPage()">参数设置</li>

                    <li onclick="roomMeterInfoPage()">热量表管理</li>
                    <li onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">

                    <%--故障报警设置--%>
                    <div class="layui-tab-item layui-show canshu">
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg3 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                故障报警列表
                                            </div>
                                            <%--</div>--%>

                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="alarmsList" lay-filter="operation3"></table>
                                            <script type="text/html" id="switchTpl1">
                                                <a lay-event="click">
                                                    <input type="checkbox" name="available" value="{{d.available}}"
                                                           lay-skin="switch" lay-text="ON|OFF" {{ d.available==0 ?
                                                    'checked' : ' ' }}>
                                                </a>
                                            </script>
                                            <script type="text/html" id="dealD">
                                                <a class="layui-btn layui-btn-xs" lay-event="save">保存</a>
                                                <a class="layui-btn layui-btn-danger layui-btn-xs"
                                                   lay-event="cancel">取消</a>
                                            </script>
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
    alarmsInfo();

    //故障报警管理
    function alarmsInfo() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#alarmsList'
                , url: 'sysIndex/alarmsList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {field: 'alarm_code', title: '故障编码', width: 120}
                        , {field: 'alarm_name', title: '故障名称', width: 200}
                        , {field: 'alarm_note', title: '故障说明', width: 300}
                        , {
                        field: 'available',
                        title: '是否启用',
                        minWidth: 150,
                        templet: '#switchTpl1',
                        unresize: true,
                        align: 'center'
                    }
                        , {field: 'alarm_value', edit: 'text', title: '设定值', minWidth: 150}
                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            //监听单元格编辑
            table.on('edit(operation3)', function (obj) {
                var value = obj.value //得到修改后的值
                    , data = obj.data //得到所在行所有键值
                    , field = obj.field; //得到字段
                $.ajax({
                    url: 'sysIndex/editAlarmValue.do',
                    async: 'false',
                    data: {
                        zone_id: zone_id,
                        alarm_code: data.alarm_code,
                        alarm_value: value
                    },
                    dataType: 'json',
                    type: 'POST',
                    success: function (res) {
                        layer.msg("操作成功");
                    },
                    error: function () {
                        layer.msg("操作失败");
                    }
                });
                // layer.msg('小区ID: '+ data.zone_id +'   alarm_code:' + data.alarm_code+'     alarm_value:'+value);
            });
            //监听锁定操作
            table.on('tool(operation3)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'click') {
                    if (data.available == 0) {
                        data.available = 1;
                    } else
                        data.available = 0;

                    $.ajax({
                        url: 'sysIndex/editAlarmValue.do',
                        async: 'false',
                        data: {
                            zone_id: zone_id,
                            alarm_code: data.alarm_code,
                            available: data.available
                        },
                        dataType: 'json',
                        type: 'POST',
                        success: function (res) {
                            layer.msg("操作成功");
                            layui.use('table', function () {
                                var table = layui.table
                                    , form = layui.form;
                                table.reload("alarmsList");
                            })
                        },
                        error: function () {
                            layer.msg("操作失败");

                        }
                    });
                }
            });
        })
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

