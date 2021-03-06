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

            border-right:60px solid ;

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
                    <li class="layui-this" onclick="branchInfoPage()">分支管理</li>
                    <li onclick="alarmsInfoPage()">故障报警设置</li>
                    <li onclick="parameterSettingPage()">参数设置</li>

                    <li onclick="roomMeterInfoPage()">热量表管理</li>
                    <li onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">

                    <%--分支管理--%>
                    <div class="layui-tab-item layui-show">
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg3 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                分支列表
                                            </div>
                                            <div class="layui-col-lg9 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;" onclick="addBranch();">添加</a>
                                                <a href="javascript:;" onclick="batchStatisticBranch();">批量统计供暖信息</a>
                                            </div>
                                            <%--</div>--%>

                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="branchList" lay-filter="operation2"></table>
                                            <script type="text/html" id="dealC">
                                                <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
                                                <a class="layui-btn layui-btn-danger layui-btn-xs"
                                                   lay-event="del">删除</a>
                                                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="contact">房间关联</a>
                                                <a class="layui-btn layui-btn-info layui-btn-xs" lay-event="statistic">统计供暖信息</a>
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
    <form id="addBranch" class="layui-form" hidden onsubmit="return addBranchInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter5">
        <div class="layui-form-item">
            <label class="layui-form-label">分支名称</label>
            <div class="layui-input-block">
                <input type="text" name="branch_name" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计算方式</label>
            <div class="layui-input-block">
                <select name="cal_mode">
                    <option value=""> 请选择</option>
                    <option value="0"> 分户累加</option>
                    <option value="1"> 分支计算</option>
                    <option value="2"> 自身表记</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn layui-btn-sm" type="submit">确定</button>
            <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeAddBranchLayer()">取消
            </button>
        </div>
    </form>
    <form id="changeBranchInfo" class="layui-form" hidden onsubmit="return changeBranchInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter6">
        <div class="layui-form-item">
            <label class="layui-form-label">分支名称</label>
            <div class="layui-input-block">
                <input type="text" name="id" hidden>
                <input type="text" name="branch_name" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计算方式</label>
            <div class="layui-input-block">
                <select name="cal_mode" id="changeMode">
                    <option value=""> 请选择</option>
                    <option value="0"> 分户累加</option>
                    <option value="1"> 分支计算</option>
                    <option value="2"> 自身表记</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn layui-btn-sm" type="submit">确定</button>
            <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeChangeBranchLayer()">
                取消
            </button>
        </div>
    </form>
</div>

<script type="text/javascript" src="layui/layui.all.js"></script>
<% String id = request.getParameter("id");%>
<script type="text/javascript">
    var ids = new Array();
    var table_data = new Array();
    var zone_id =<%=id%>;
    var index;
    branchInfo();


    //分支管理
    function branchInfo() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#branchList'
                , url: 'sysIndex/getBranchList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {field: 'branch_name', title: '分支名称', width: 100}
                        , {field: 'total_count', title: '总户数', width: 100}
                        , {field: 'total_room_area', title: '总建筑面积', width: 100}
                        , {field: 'total_heat_area', title: '总供暖面积', width: 100}
                        , {field: 'heat_count', title: '供暖户数', width: 100}
                        , {field: 'real_heat_area', title: '实际供暖面积', width: 120}
                        , {field: 'cal_mode', title: '计算方式', width: 100}
                        , {width: 300, title: '操作', align: 'center', toolbar: '#dealC'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            table.on('tool(operation2)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'del') { //删除
                    var id = data.id;
                    layer.confirm('确定删除吗？', function (index) {
                        deleteBranch(id);
                        layui.use('table', function () {
                            var table = layui.table
                                , form = layui.form;
                            table.reload("branchList");
                        })
                    })
                } else if (layEvent === 'edit') {
                    var id = data.id;
                    getBranchInfo(id);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#changeBranchInfo')
                    });
                } else if (layEvent === 'contact') {
                    var id = data.id;
                    layer.open({
                        type: 2,
                        area: ['650px', '500px'],
                        content: 'sysIndex/roomTree.do?zone_id=' + zone_id + '&branch_id=' + id //这里content是一个普通的String
                    });
                } else if (layEvent === 'statistic') {
                    $.ajax({
                        url: 'sysIndex/statisticBranch.do?branch_id=' + data.id
                        , dataType: 'json'
                        , async: false
                        , type: 'GET'
                        , success: function (res) {
                            layer.msg("操作成功")
                            layui.use('table', function () {
                                var table = layui.table
                                    , form = layui.form;
                                table.reload("branchList");
                            })
                        }
                        , error: function () {
                            layer.msg("操作失败")
                        }
                    })
                }
            });
        })
    }

    function addBranch() {
        index = layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['350px', '300px'], //宽高
            content: $('#addBranch')
        });
    }

    function closeAddBranchLayer() {
        $("#addBranch").css("display", "none");
        $("#addBranch input").val("");
        layer.close(index);
    }

    function closeChangeBranchLayer() {
        $("#changeBranchInfo").css("display", "none");
        $("#changeBranchInfo input").val("");
        layer.close(index);
    }

    function addBranchInfo() {
        var data = $("#addBranch").serialize();
        if (checkBranchName(data)) {
            $.ajax({
                url: 'sysIndex/addBranchInfo.do?zone_id=' + zone_id,
                data: data,
                async: false,
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    layer.msg("操作成功");
                    closeAddBranchLayer();
                    layui.use('table', function () {
                        var table = layui.table
                            , form = layui.form;
                        table.reload("branchList");
                    })
                },
                error: function () {
                    layer.msg("操作失败");
                    closeAddBranchLayer();
                }
            });
        } else {
            layer.tips('名称已存在', "#addBranch input[name='branch_name']");
        }

        return false;
    }

    function checkBranchName(data) {
        var state = true;
        $.ajax({
            type: "GET",
            dataType: "json",
            data: data,
            url: "sysIndex/branchNameCheck.do?zone_id="+zone_id,
            async: false,
            success: function (data) {
                if (data.state == "success") {
                    state = true;
                } else {
                    state = false;
                }
            },
            error: function () {
                layer.msg("操作失败");
                state = false;
            }
        });
        return state;
    }

    function getBranchInfo(id) {
        $.ajax({
            url: 'sysIndex/getBranchInfo.do?id=' + id
            , dataType: 'json'
            , async: false
            , type: 'GET'
            , success: function (res) {
                $("#changeBranchInfo input[name='id']").val(res.id);
                $("#changeBranchInfo input[name='branch_name']").val(res.branch_name);
                $("#changeMode").val(res.cal_mode);
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    form.render("select", "selFilter6");
                });
            }
        });
    }

    function changeBranchInfo() {
        var data = $("#changeBranchInfo").serialize();
        if (checkBranchName(data)) {
            $.ajax({
                url: 'sysIndex/changeBranchInfo.do',
                data: data,
                dataType: 'json',
                type: 'POST',
                async: false,
                success: function (res) {
                    layer.msg("操作成功");
                    closeChangeBranchLayer();
                    layui.use('table', function () {
                        var table = layui.table
                            , form = layui.form;
                        table.reload("branchList");
                    })
                },
                error: function () {
                    layer.msg("操作失败");
                }

            });
        } else {
            layer.tips('名称已存在', "#changeBranchInfo input[name='branch_name']");
        }
        return false;
    }

    function deleteBranch(id) {
        $.ajax({
            url: 'sysIndex/deleteBranchInfo.do?id=' + id,
            dataType: 'json',
            type: 'POST',
            async: false,
            success: function (res) {
                layer.msg("操作成功");
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    table.reload("branchList");
                })
            },
            error: function () {
                layer.msg("操作失败");
            }
        });
    }

    function batchStatisticBranch() {
        $.ajax({
            url: 'sysIndex/statisticAllBranch.do?zone_id=' + zone_id
            , async: false
            , dataType: 'json'
            , type: 'GET'
            , success: function (data) {
                layer.msg("操作成功");
                branchInfo();
            }
            , error: function () {
                layer.msg("操作失败");
            }
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

