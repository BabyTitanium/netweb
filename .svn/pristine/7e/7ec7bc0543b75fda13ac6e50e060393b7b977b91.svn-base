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
                    <li class="layui-this" onclick="buildingInfoPage()">楼栋管理</li>
                    <li onclick="branchInfoPage()">分支管理</li>
                    <li onclick="alarmsInfoPage()">故障报警设置</li>
                    <li onclick="parameterSettingPage()">参数设置</li>

                    <li onclick="roomMeterInfoPage()">热量表管理</li>
                    <li onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">

                    <%--楼栋管理--%>
                    <div class="layui-tab-item layui-show">
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg3 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                楼栋列表
                                            </div>
                                            <div class="layui-col-lg9 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;" onclick="batchStatisticBuilding()">批量统计供暖信息</a>
                                            </div>

                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="buildingsList" lay-filter="operation1"></table>
                                            <script type="text/html" id="dealB">
                                                <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
                                                <a class="layui-btn layui-btn-danger layui-btn-xs"
                                                   lay-event="del">删除</a>
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

    <form id="editBuilding" class="layui-form" hidden onsubmit="return editBuildingInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter4">
        <div class="layui-form-item">
            <label class="layui-form-label">楼栋名称</label>
            <div class="layui-input-block">
                <input type="text" name="id" hidden>
                <input type="text" name="build_name" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计算方式</label>
            <div class="layui-input-block">
                <select name="cal_mode" id="cal_mode" lay-filter="cal_mode">
                    <option value=""> 请选择</option>
                    <option value="0"> 分户累加</option>
                    <option value="1"> 分支计算</option>

                </select>
            </div>
        </div>
        <div class="layui-form-item" id="haveBranch">
            <label class="layui-form-label"><a href="javascript:;" onclick="showBranchs()">显示分支</a></label>
            <div class="layui-input-block" id="addedBranch">

            </div>
        </div>
        <%--<div class="layui-form-item">--%>
        <%--<label class="layui-form-label">分支(+)</label>--%>
        <%--<div class="layui-input-block">--%>
        <%--<select name="branchPlus">--%>
        <%--</select>--%>
        <%--</div>--%>
        <%--</div>--%>
        <div class="layui-form-item" id="chooseBranch" style="display:none">
            <label class="layui-form-label"><span onclick="appendBranchPlus()"><img
                    src="<%=basePath%>layui/images/add.png"></span></label>
            <label class="layui-form-label"><span onclick="appendBranchMinus()"><img
                    src="<%=basePath%>layui/images/less.png"></span></label>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn layui-btn-sm" type="submit">确定</button>
            <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeEditBuildingLayer()">
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
    buildingInfo();

    //楼栋管理

    var htmlBuilding = "<option value=''>请选择</option>";
    layui.use(['layer', 'form'], function () {
        var layer = layui.layer
            , form = layui.form;
        form.on('select(cal_mode)', function (data) {
            // console.log(data);
            if (data.value == 1) {
                // showBranchList(zone_id);
                $("#chooseBranch").css("display", "block");
            } else {
                $("#chooseBranch").css("display", "none");
            }
        });
    });

    function appendBranchPlus() {
        var build_id = $("#editBuilding input[name='id']").val();
        var branchPlus = " <div class='layui-form-item appendBranch'>" +
            "<label class='layui-form-label'>分支(+)</label>" +
            "  <div class='layui-input-block'>" +
            "  <select name='branchPlus'>"
        $.ajax({
            url: 'sysIndex/getBranchNoSet.do',
            data: {zone_id: zone_id, build_id, build_id},
            dataType: 'json',
            async: false,
            type: "GET",
            success: function (res) {
                $(res).each(function (index) {
                    var m = res[index];
                    branchPlus += "<option value='" + m.id + "'>" + m.branch_name + "</option>"
                })
                branchPlus += "</select></div></div>";
                $("#chooseBranch").before(branchPlus);
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    form.render("select", "selFilter4");
                });
            }
        })

    }

    function appendBranchMinus() {
        var build_id = $("#editBuilding input[name='id']").val();
        var branchPlus = " <div class='layui-form-item appendBranch'>" +
            "<label class='layui-form-label'>分支(-)</label>" +
            "  <div class='layui-input-block'>" +
            "  <select name='branchMinus'>"
        $.ajax({
            url: 'sysIndex/getBranchNoSet.do',
            data: {zone_id: zone_id, build_id, build_id},
            dataType: 'json',
            async: false,
            type: "GET",
            success: function (res) {
                $(res).each(function (index) {
                    var m = res[index];
                    branchPlus += "<option value='" + m.id + "'>" + m.branch_name + "</option>"
                })
                branchPlus += "</select></div></div>";
                $("#chooseBranch").before(branchPlus);
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    form.render("select", "selFilter4");
                });
            }
        })

    }

    function showBranchs() {
        var build_id = $("#editBuilding input[name='id']").val();
        var b = "";
        $.ajax({
            url: 'sysIndex/getBuildingBranches.do',
            data: {build_id: build_id},
            dataType: 'json',
            type: 'GET',
            async: false,
            success: function (res) {
                if (res == "" || res == null) {
                    $("#addedBranch").html("没有分支");
                } else {
                    $(res).each(function (index) {
                        var s = res[index];
                        var f = s.plus_minus;
                        var p = "(+)";
                        if (f == 0) {
                            p = "(+)";
                        } else if (f == 1) {
                            p = "(-)";
                        }
                        b += "<span style='padding:0 10px'>" + s.branch_name + p + "<img src='<%=basePath%>layui/images/del.png' onclick=deleteBuildBranch(" + s.branch_id + ") id='" + s.branch_id + "'/>" + "</span>";
                    });
                    $("#addedBranch").html(b);
                }

            }
        });
    }

    function deleteBuildBranch(branch_id) {
        var build_id = $("#editBuilding input[name='id']").val();
        $.ajax({
            url: 'sysIndex/deleteBuildBranch.do',
            data: {build_id: build_id, branch_id: branch_id},
            dataType: 'json',
            type: 'GET',
            async: false,
            success: function (data) {
                layer.msg("操作成功");
                showBranchs();
            },
            error: function () {
                layer.msg("操作失败");
            }
        });
    }

    function buildingInfo() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#buildingsList'
                , url: 'sysIndex/buildingList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {field: 'build_num', title: '楼栋号', width: 100, value: '99'}
                        , {field: 'build_name', title: '楼栋名称', width: 100}
                        , {field: 'total_count', title: '总户数', width: 100}
                        , {field: 'total_room_area', title: '总建筑面积', width: 100}
                        , {field: 'total_heat_area', title: '总供暖面积', width: 100}
                        , {field: 'heat_count', title: '供暖户数', width: 100}
                        , {field: 'real_heat_area', title: '实际供暖面积', width: 120}
                        , {field: 'cal_mode', title: '计算方式', width: 100}
                        , {maxWidth: 300, minWidth: 220, title: '操作', align: 'center', toolbar: '#dealB'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10

            });
            table.on('tool(operation1)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'del') { //删除
                    layer.confirm('确定删除吗？', function (index) {
                        $.ajax({
                            url: 'sysIndex/deleteBuildingInfo.do?id=' + data.id
                            , dataType: 'json'
                            , async: false
                            , type: 'GET'
                            , success: function (res) {
                                layer.msg("操作成功");
                                layui.use('table', function () {
                                    var table = layui.table
                                        , form = layui.form;
                                    table.reload("buildingsList");
                                })
                            }
                            , error: function () {
                                layer.msg("操作失败");
                            }
                        });
                    })

                } else if (layEvent === 'edit') {
                    var id = data.id;
                    $.ajax({
                        url: 'sysIndex/getBuildingInfo.do?id=' + id
                        , dataType: 'json'
                        , async: false
                        , type: 'GET'
                        , success: function (res) {
                            $("#editBuilding input[name='id']").val(res.id);
                            $("#editBuilding input[name='build_name']").val(res.build_name);
                            $("#cal_mode").val(res.cal_mode);
                            if (res.cal_mode == 1) {
                                $("#chooseBranch").css("display", "block");
                                $("#haveBranch").css("display", "block");
                            }
                            layui.use('table', function () {
                                var table = layui.table
                                    , form = layui.form;
                                form.render("select", "selFilter4");
                            });
                        }
                    });
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editBuilding')
                    });
                } else if (layEvent === "statistic") {
                    $.ajax({
                        url: 'sysIndex/statisticBuilding.do?id=' + data.id
                        , dataType: 'json'
                        , async: false
                        , type: 'GET'
                        , success: function (res) {
                            layer.msg("操作成功")
                            layui.use('table', function () {
                                var table = layui.table
                                    , form = layui.form;
                                table.reload("buildingsList");
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

    function batchStatisticBuilding() {
        $.ajax({
            url: 'sysIndex/statisticAllBuilding.do?zone_id=' + zone_id
            , async: false
            , dataType: 'json'
            , type: 'GET'
            , success: function (data) {
                layer.msg("操作成功");
                buildingInfo();
            }
            , error: function () {
                layer.msg("操作失败");
            }
        })
    }

    function closeEditBuildingLayer() {
        $("#chooseBranch").css("display", "none");
        $("#editBuilding").css("display", "none");
        $("#editBuilding input").val("");
        $("#addedBranch").html("");
        $("#chooseBranch").css("display", "none");
        $("#haveBranch").css("display", "none");
        $(".appendBranch").html("");

        layer.close(index);
    }

    function editBuildingInfo() {
        var build = $("#editBuilding").serialize();
        $.ajax({
            url: 'sysIndex/editBuildingInfo.do'
            , data: build
            , dataType: 'json'
            , type: 'POST'
            , success: function (res) {
                layer.msg("操作成功");
                closeEditBuildingLayer();
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    table.reload("buildingsList");
                })
            }
            , error: function () {
                layer.msg("操作失败");
                closeEditBuildingLayer();
            }
        });
        return false;
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

