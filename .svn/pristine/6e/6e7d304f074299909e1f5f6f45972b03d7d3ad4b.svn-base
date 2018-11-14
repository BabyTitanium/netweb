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
                    <li class="layui-this" onclick="roomInfoPage()">房间信息管理</li>
                    <li onclick="buildingInfoPage()">楼栋管理</li>
                    <li onclick="branchInfoPage()">分支管理</li>
                    <li onclick="alarmsInfoPage()">故障报警设置</li>
                    <li onclick="parameterSettingPage()">参数设置</li>

                    <li onclick="roomMeterInfoPage()">热量表管理</li>
                    <li onclick="roomValveInfoPage()">阀门管理</li>
                    <li onclick="roomTempInfoPage()">测温节点管理</li>
                    <li onclick="roomThermostatInfoPage()">无线面板管理</li>
                </ul>
                <div class="layui-tab-content">
                    <%--房间信息管理--%>
                    <div class="layui-tab-item layui-show">
                        <div id="buildings">
                        </div>
                        <input type="text" hidden id="buildingId">
                        <input type="text" hidden id="buildingNum">
                        <div style="padding-top: 30px;">
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <div class="layui-col-md8 layui-col-lg10 layui-col-sm4 layui-col-xs4"><i
                                                    class="layui-icon">&#xe615;</i>筛选查询
                                            </div>
                                            <div class="layui-col-md2 layui-col-lg1 layui-col-sm4 layui-col-xs4"><i
                                                    class="layui-icon" onclick="toggleChose();"
                                                    id="toggleIcon">&#xe61a;</i>收起筛选
                                            </div>
                                            <div class="layui-col-md1  layui-col-lg1 layui-col-sm4  layui-col-xs4">
                                                <button class="layui-btn layui-btn-primary  layui-btn-sm">高级筛选</button>
                                            </div>
                                        </div>
                                        <div class="layui-card-body" id="chose">
                                            <form class="layui-form" lay-filter="selFilter0">
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">供暖状态</label>
                                                    <div class="layui-input-block">
                                                        <select name="is_supply" id="isSupply">
                                                            <option value="">请选择</option>
                                                            <option value="1"> 供暖</option>
                                                            <option value="0">报停</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">计量方式</label>
                                                    <div class="layui-input-block">
                                                        <select name="charge_mode" id="chargeMode">
                                                            <option value="">请选择</option>
                                                            <option value="0"> 面积</option>
                                                            <option value="1">热量</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">房间号</label>
                                                    <div class="layui-input-block">
                                                        <input class="layui-input" type="text" name="roomnum"
                                                               id="roomnum" placeholder="请输入搜索内容">
                                                    </div>
                                                </div>
                                                <div class="layui-inline" style="padding-left: 30px">
                                                    <button id="find" type="button" class="layui-btn layui-btn-primary"
                                                            data-type="reload">搜索
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg3 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                房间列表
                                            </div>
                                            <div class="layui-col-lg9 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;" onclick="downloadTemplate();">下载模板</a>
                                                <a href="javascript:;" id="uploadIsSupply">导入供暖状态</a>
                                                <a href="javascript:;" onclick="editSelected();">批量修改</a>
                                                <a href="javascript:;" onclick="batchDeleteSubmit();">批量删除</a>
                                                <a href="javascript:;" id="uploadAll">导入信息</a>
                                                <a href="javascript:;" onclick="exportRoomExcel()">导出Excel</a>
                                                <a href="javascript:;" onclick="addRoomInfo()">添加</a>
                                            </div>
                                            <%--</div>--%>

                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="roomsList" lay-filter="operation"></table>
                                            <script type="text/html" id="deal">
                                                <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
                                                <a class="layui-btn layui-btn-danger layui-btn-xs"
                                                   lay-event="del">删除</a>
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
    <form id="roomInfo" class="layui-form" hidden onsubmit=" return submitRoomInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter">
        <div class="layui-form-item">
            <label class="layui-form-label">房间号</label>
            <div class="layui-input-block">
                <input type="text" name="room_num" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">楼号</label>
            <div class="layui-input-block">
                <input type="text" id="b_num" name="b_num" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">单元</label>
            <div class="layui-input-block">
                <input type="text" name="unit_num" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">户主</label>
            <div class="layui-input-block">
                <input type="text" name="host_name" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房间位置</label>
            <div class="layui-input-block">
                <select name="location" id="location" required>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">住户类型</label>
            <div class="layui-input-block">
                <select name="user_type" id="user_type" required>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">收费编码</label>
            <div class="layui-input-block">
                <input type="text" name="user_code" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">采暖方式</label>
            <div class="layui-input-block">
                <select name="heat_type" id="heat_type" required>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房屋面积</label>
            <div class="layui-input-block">
                <input type="text" name="room_area" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">供暖面积</label>
            <div class="layui-input-block">
                <input type="text" name="heat_area" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">供暖状态</label>
            <div class="layui-input-block">
                <select name="is_supply" id="is_supply" required>
                    <option value="1"> 供暖</option>
                    <option value="0"> 报停</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计量方式</label>
            <div class="layui-input-block">
                <select name="charge_mode" id="charge_mode" required>
                    <option value="1"> 热量</option>
                    <option value="0"> 面积</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系电话</label>
            <div class="layui-input-block">
                <input type="text" name="contact_info" class="layui-input" lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">特殊标识</label>
            <div class="layui-input-block">
                <input type="text" name="special_mark" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn " lay-submit type="submit">保存</button>
            <button class="layui-btn layui-btn-primary" type="button" onclick="closeAddLayer()">取消</button>
        </div>
    </form>
    <form id="changeRoomInfo" class="layui-form" hidden onsubmit=" return editRoomInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter1">
        <div class="layui-form-item">
            <label class="layui-form-label">房间号</label>
            <div class="layui-input-block">
                <input type="text" name="id" hidden>
                <input type="text" name="r_num" class="layui-input" required lay-verify="number" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">楼号</label>
            <div class="layui-input-block">
                <input type="text" name="b_num" class="layui-input" required lay-verify="number" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">单元</label>
            <div class="layui-input-block">
                <input type="text" name="u_num" class="layui-input" required lay-verify="number" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">户主</label>
            <div class="layui-input-block">
                <input type="text" name="host_name" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房间位置</label>
            <div class="layui-input-block">
                <select name="location" id="changeLocation" required>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">住户类型</label>
            <div class="layui-input-block">
                <select name="user_type" id="changeUserType" required>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">收费编码</label>
            <div class="layui-input-block">
                <input type="text" name="user_code" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">采暖方式</label>
            <div class="layui-input-block">
                <select name="heat_type" id="changeHeatType" required>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房屋面积</label>
            <div class="layui-input-block">
                <input type="text" name="room_area" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">供暖面积</label>
            <div class="layui-input-block">
                <input type="text" name="heat_area" class="layui-input" required lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">供暖状态</label>
            <div class="layui-input-block">
                <select name="is_supply" id="changeIsSupply" required>
                    <option value="1"> 供暖</option>
                    <option value="0"> 报停</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计量方式</label>
            <div class="layui-input-block">
                <select name="charge_mode" id="changeChargeMode" required>
                    <option value="1"> 热量</option>
                    <option value="0"> 面积</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系电话</label>
            <div class="layui-input-block">
                <input type="text" name="contact_info" class="layui-input" lay-verify="number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">特殊标识</label>
            <div class="layui-input-block">
                <input type="text" name="special_mark" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn " lay-submit type="submit">保存</button>
            <button class="layui-btn layui-btn-primary" type="button" onclick="closeEditLayer()">取消</button>
        </div>
    </form>
    <form id="batchEdit" class="layui-form" hidden onsubmit=" return batchEditSubmit();"
          style="padding: 10px;display: none" lay-filter="selFilter2">
        <div class="layui-form-item">
            <label class="layui-form-label">房间位置</label>
            <div class="layui-input-block">
                <select name="location" id="sLocation">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">住户类型</label>
            <div class="layui-input-block">
                <select name="user_type" id="schangeUserType">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">采暖方式</label>
            <div class="layui-input-block">
                <select name="heat_type" id="schangeHeatType">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">供暖状态</label>
            <div class="layui-input-block">
                <select name="is_supply" id="sisSupply">
                    <option value="">请选择</option>
                    <option value="1"> 供暖</option>
                    <option value="0"> 报停</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计量方式</label>
            <div class="layui-input-block">
                <select name="charge_mode" id="schargeMode">
                    <option value="">请选择</option>
                    <option value="1"> 热量</option>
                    <option value="0"> 面积</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">特殊标识</label>
            <div class="layui-input-block">
                <input type="text" name="special_mark" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn " lay-submit type="submit">保存</button>
            <button class="layui-btn layui-btn-primary" type="button" onclick="closeBatchEdit()">取消</button>
        </div>
    </form>
    <form id="choseTemplate" class="layui-form" hidden onsubmit="return submitTemplate();" lay-filter="selFilter3">
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin-left: 30px">
                <input type="radio" name="template" value="1" title="《用户信息导入模板》" checked>
                <input type="radio" name="template" value="2" title="《供暖状态更新模板》">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn layui-btn-sm" type="submit">确定</button>
            <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeTemplateLayer()">取消
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
    roomInfo();
    //房间信息管理
    function roomInfo() {
        $.ajax({
            url: "sysIndex/getZoneBuildings.do",
            type: "GET",
            dataType: "json",
            data: {zone_id: zone_id},
            async: false,
            success: function (data) {
                var html = "<button class='layui-btn layui-btn-sm' id='allRooms' onclick='findAll()'>全部<span></span></button>";
                $(data).each(function (index) {
                    var temp = data[index];
                    html += "<button id='" + temp.id + "' class='layui-btn layui-btn-sm layui-btn-primary building '>" + temp.build_name + "(<span id='" + temp.build_num + "'>" + temp.num + "</span>)</button>"
                });
                $("#buildings").html(html);
            }
        });

        $("#buildings .building").on("click", function () {
            $("#buildings button").addClass("layui-btn-primary");
            $(this).removeClass("layui-btn-primary");
            var id = this.id;
            var b_num = $(this).children("span").attr("id");
            //    console.log(b_num);
            $("#isSupply").val("");
            $("#chargeMode").val("");

            $("#buildingId").val(id);
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                form.render("select", "selFilter0");
            });
            $("#buildingNum").val(b_num);
            finds();
        });
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomsList'
                , url: 'sysIndex/roomsList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {type: 'checkbox'}
                        , {field: 'r_num', title: '房间号', width: 60, sort: true}
                        , {field: 'user_code', title: '收费编码', width: 100}
                        , {field: 'host_name', title: '户主', width: 65}
                        , {field: 'locationName', title: '房间位置', width: 60}
                        , {field: 'floor', title: '楼层', width: 60}
                        , {field: 'custom_typeName', title: '住户类型', width: 60}
                        , {field: 'heat_typeName', title: '采暖方式', width: 60}
                        , {field: 'room_area', title: '房屋面积', width: 60}
                        , {field: 'heat_area', title: '供暖面积', width: 60}
                        , {field: 'is_supply', title: '供暖状态', width: 60}
                        , {field: 'charge_mode', title: '计量方式', width: 60}
                        , {field: 'contact_info', title: '联系电话', width: 110}
                        , {field: 'special_mark', title: '特殊标识', width: 50}
                        , {width: 120, title: '操作', align: 'center', toolbar: '#deal'}
                        , {field: 'update_time', title: '更新时间', maxWidth: 100}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                , done: function (res) {
                    //设置全部数据到全局变量
                    table_data = res.data;
                    $("#allRooms span").html("(" + res.count + ")");
                }
            });
            table.on('tool(operation)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'del') { //删除
                    var id = data.id;
                    layer.confirm('确定删除吗？', function (index) {
                        deleteRoom(id);
                        roomInfo();
                        findAll();
                    })
                } else if (layEvent === 'edit') {
                    var id = data.id;
                    getRoomInfo(id);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '540px'], //宽高
                        content: $('#changeRoomInfo')
                    });
                }
            });
            table.on('checkbox(operation)', function (obj) {
                console.log(obj);
                if (obj.checked == true) {
                    if (obj.type == 'one') {
                        ids.push(obj.data.id);
                    } else {
                        for (var i = 0; i < table_data.length; i++) {
                            ids.push(table_data[i].id);
                        }
                    }
                } else {
                    if (obj.type == 'one') {
                        for (var i = 0; i < ids.length; i++) {
                            if (ids[i] == obj.data.id) {
                                ids.splice(i, 1);
                            }
                        }
                    } else {
                        for (var i = 0; i < ids.length; i++) {
                            for (var j = 0; j < table_data.length; j++) {
                                if (ids[i] == table_data[j].id) {
                                    ids.splice(i, 1);
                                }
                            }
                        }
                    }
                }
                console.log(ids);
            });


        })
    }

    $('#find').on('click', function () {
        var build_id = $("#buildingId").val();
        var key = $("#roomnum").val();
        var charge_mode = $("#chargeMode").val();
        var is_supply = $("#isSupply").val()
        if (key == "" || key == null || key == undefined) {

            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomsList'
                    ,
                    url: 'sysIndex/roomsList.do?zone_id=' + zone_id + '&build_id=' + build_id + '&charge_mode=' + charge_mode + '&is_supply=' + is_supply
                    ,
                    cols: [
                        [ //表头
                            {type: 'checkbox'}
                            , {field: 'r_num', title: '房间号', width: 60, sort: true}
                            , {field: 'user_code', title: '收费编码', width: 100}
                            , {field: 'host_name', title: '户主', width: 65}
                            , {field: 'locationName', title: '房间位置', width: 60}
                            , {field: 'floor', title: '楼层', width: 60}
                            , {field: 'custom_typeName', title: '住户类型', width: 60}
                            , {field: 'heat_typeName', title: '采暖方式', width: 60}
                            , {field: 'room_area', title: '房屋面积', width: 60}
                            , {field: 'heat_area', title: '供暖面积', width: 60}
                            , {field: 'is_supply', title: '供暖状态', width: 60}
                            , {field: 'charge_mode', title: '计量方式', width: 60}
                            , {field: 'contact_info', title: '联系电话', width: 110}
                            , {field: 'special_mark', title: '特殊标识', width: 50}
                            , {width: 120, title: '操作', align: 'center', toolbar: '#deal'}
                            , {field: 'update_time', title: '更新时间', maxWidth: 100}
                        ]
                    ]
                    ,
                    skin: 'row' //表格风格
                    ,
                    even: true
                    ,
                    page: true //是否显示分页
                    ,
                    limit: 10

                });
                table.on('tool(operation)', function (obj) {
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象
                    if (layEvent === 'del') { //删除
                        var id = data.id;
                        layer.confirm('确定删除吗？', function (index) {
                            deleteRoom(id);
                            roomInfo();
                            findAll();
                        })
                    } else if (layEvent === 'edit') {
                        var id = data.id;
                        getRoomInfo(id);
                        index = layer.open({
                            type: 1,
                            closeBtn: 0,
                            skin: 'layui-layer-rim', //加上边框
                            area: ['420px', '540px'], //宽高
                            content: $('#changeRoomInfo')
                        });
                    }
                });
                table.on('checkbox(operation)', function (obj) {
                    console.log(obj);
                    if (obj.checked == true) {
                        if (obj.type == 'one') {
                            ids.push(obj.data.id);
                        } else {
                            for (var i = 0; i < table_data.length; i++) {
                                ids.push(table_data[i].id);
                            }
                        }
                    } else {
                        if (obj.type == 'one') {
                            for (var i = 0; i < ids.length; i++) {
                                if (ids[i] == obj.data.id) {
                                    ids.splice(i, 1);
                                }
                            }
                        } else {
                            for (var i = 0; i < ids.length; i++) {
                                for (var j = 0; j < table_data.length; j++) {
                                    if (ids[i] == table_data[j].id) {
                                        ids.splice(i, 1);
                                    }
                                }
                            }
                        }
                    }
                    console.log(ids);
                });
            })
        }
        else {

            $.ajax({
                url: 'sysIndex/roomsList.do?zone_id=' + zone_id + '&build_id=' + build_id
                , async: false
                , type: "GET"
                , dataType: 'json'
                , data: {
                    charge_mode: charge_mode,
                    is_supply: is_supply,
                }
                , success: function (res) {
                    var roomListSearch = res.data;
                    var str = "";
                    var temp = new Array();
                    var l = roomListSearch.length;
                    for (var i = 0; i < l; i++) {
                        for (var k in roomListSearch[i]) {
                            if(k=="r_num"){
                                str = JSON.stringify(roomListSearch[i][k]);
                                console.log(k);
                                if (str.indexOf(key) != -1) {
                                    temp.push(roomListSearch[i]);
                                    break;
                                }
                            }

                        }
                    }
                    layui.use('table', function () {
                        var table = layui.table
                            , form = layui.form;
                        table.render({
                            elem: '#roomsList'
                            , data: temp
                            , cols: [
                                [ //表头
                                    {type: 'checkbox'}
                                    , {field: 'r_num', title: '房间号', width: 60, sort: true}
                                    , {field: 'user_code', title: '收费编码', width: 100}
                                    , {field: 'host_name', title: '户主', width: 65}
                                    , {field: 'locationName', title: '房间位置', width: 60}
                                    , {field: 'floor', title: '楼层', width: 60}
                                    , {field: 'custom_typeName', title: '住户类型', width: 60}
                                    , {field: 'heat_typeName', title: '采暖方式', width: 60}
                                    , {field: 'room_area', title: '房屋面积', width: 60}
                                    , {field: 'heat_area', title: '供暖面积', width: 60}
                                    , {field: 'is_supply', title: '供暖状态', width: 60}
                                    , {field: 'charge_mode', title: '计量方式', width: 60}
                                    , {field: 'contact_info', title: '联系电话', width: 110}
                                    , {field: 'special_mark', title: '特殊标识', width: 50}
                                    , {width: 120, title: '操作', align: 'center', toolbar: '#deal'}
                                    , {field: 'update_time', title: '更新时间', maxWidth: 100}
                                ]
                            ]
                            , skin: 'row' //表格风格
                            , even: true
                            , page: true //是否显示分页
                            , limit: 10
                        });
                        table.on('tool(operation)', function (obj) {
                            var data = obj.data; //获得当前行数据
                            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                            var tr = obj.tr; //获得当前行 tr 的DOM对象
                            if (layEvent === 'del') { //删除
                                var id = data.id;
                                layer.confirm('确定删除吗？', function (index) {
                                    deleteRoom(id);
                                    roomInfo();
                                    findAll();
                                })
                            } else if (layEvent === 'edit') {
                                var id = data.id;
                                getRoomInfo(id);
                                index = layer.open({
                                    type: 1,
                                    closeBtn: 0,
                                    skin: 'layui-layer-rim', //加上边框
                                    area: ['420px', '540px'], //宽高
                                    content: $('#changeRoomInfo')
                                });
                            }
                        });
                        table.on('checkbox(operation)', function (obj) {
                            console.log(obj);
                            if (obj.checked == true) {
                                if (obj.type == 'one') {
                                    ids.push(obj.data.id);
                                } else {
                                    for (var i = 0; i < table_data.length; i++) {
                                        ids.push(table_data[i].id);
                                    }
                                }
                            } else {
                                if (obj.type == 'one') {
                                    for (var i = 0; i < ids.length; i++) {
                                        if (ids[i] == obj.data.id) {
                                            ids.splice(i, 1);
                                        }
                                    }
                                } else {
                                    for (var i = 0; i < ids.length; i++) {
                                        for (var j = 0; j < table_data.length; j++) {
                                            if (ids[i] == table_data[j].id) {
                                                ids.splice(i, 1);
                                            }
                                        }
                                    }
                                }
                            }
                            console.log(ids);
                        });
                    })
                }
                , error: function () {
                    layer.msg("未找到数据");
                }
            });
        }

    });
    var i = 0;

    function toggleChose() {
        if (i == 0) {
            $("#toggleIcon").html("&#xe619;");
            $("#chose").slideUp();
            i++;
        } else {
            $("#toggleIcon").html("&#xe61a;");
            $("#chose").slideDown();
            i--;
        }
    }

    function finds() {
        var build_id = $("#buildingId").val();
        // var is_supply=$("#isSupply").val();
        // var charge_mode=$("#chargeMode").val();
        // var is_supply=null;
        // var charge_mode=null;
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            //第一个实例
            // if(build_id==null||build_id==undefined||build_id==""){

            // }else{
            table.render({
                elem: '#roomsList'
                , url: 'sysIndex/roomsList.do?build_id=' + build_id
                //+"&is_supply="+is_supply+"&charge_mode="+charge_mode //数据接口
                , cols: [
                    [ //表头
                        {type: 'checkbox'}
                        , {field: 'r_num', title: '房间号', width: 60}
                        , {field: 'user_code', title: '收费编码', width: 100}
                        , {field: 'host_name', title: '户主', width: 65}
                        , {field: 'locationName', title: '房间位置', width: 60}
                        , {field: 'floor', title: '楼层', width: 60}
                        , {field: 'custom_typeName', title: '住户类型', width: 60}
                        , {field: 'heat_typeName', title: '采暖方式', width: 60}
                        , {field: 'room_area', title: '房屋面积', width: 60}
                        , {field: 'heat_area', title: '供暖面积', width: 60}
                        , {field: 'is_supply', title: '供暖状态', width: 60}
                        , {field: 'charge_mode', title: '计量方式', width: 60}
                        , {field: 'contact_info', title: '联系电话', width: 110}
                        , {field: 'special_mark', title: '特殊标识', width: 50}
                        , {width: 120, title: '操作', align: 'center', toolbar: '#deal'}
                        , {field: 'update_time', title: '更新时间', maxWidth: 100}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                , done: function (res) {
                    //设置全部数据到全局变量
                    table_data = res.data;
                }
            });
            // }
            table.on('tool(operation)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'del') { //删除
                    var id = data.id;
                    layer.confirm('确定删除吗？', function (index) {
                        deleteRoom(id);
                        //        roomInfo();
                        // findAll();

                        table.reload('roomsList');
                    })
                } else if (layEvent === 'edit') {
                    var id = data.id;
                    getRoomInfo(id);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '540px'], //宽高
                        content: $('#changeRoomInfo')
                    });
                }
            });
            table.on('checkbox(operation)', function (obj) {
                console.log(obj);
                if (obj.checked == true) {
                    if (obj.type == 'one') {
                        ids.push(obj.data.id);
                    } else {
                        for (var i = 0; i < table_data.length; i++) {
                            ids.push(table_data[i].id);
                        }
                    }
                } else {
                    if (obj.type == 'one') {
                        for (var i = 0; i < ids.length; i++) {
                            if (ids[i] == obj.data.id) {
                                ids.splice(i, 1);
                            }
                        }
                    } else {
                        for (var i = 0; i < ids.length; i++) {
                            for (var j = 0; j < table_data.length; j++) {
                                if (ids[i] == table_data[j].id) {
                                    ids.splice(i, 1);
                                }
                            }
                        }
                    }
                }
                console.log(ids);
            });

            //搜索加载--数据表格重载
            var $ = layui.$, active = {
                reload: function () {
                    //执行重载
                    table.reload('roomsList', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            charge_mode: $("#chargeMode").val(),
                            is_supply: $("#isSupply").val()
                        }
                    });
                }
            };
            $('#find').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        })
    }

    var index;

    function addRoomInfo() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            var m = "#location";
            var n = "#user_type";
            var j = "#heat_type";
            getRoomLocation(m);
            getCustomType(n);
            getHeatType(j);
            form.render("select", "selFilter");
            var build_num = $("#buildingNum").val();
            $("#roomInfo input[name='b_num']").val(build_num);
            index = layer.open({
                type: 1,
                closeBtn: 0,
                skin: 'layui-layer-rim', //加上边框
                area: ['420px', '540px'], //宽高
                content: $('#roomInfo')
            });
        })
    }

    function closeAddLayer() {
        $("#roomInfo").css("display", "none");
        $("#roomInfo input").val("");
        layer.close(index);
    }

    function closeEditLayer() {
        $("#changeRoomInfo").css("display", "none");
        $("#changeRoomInfo input").val("");
        layer.close(index);
    }

    function closeBatchEdit() {
        $("#batchEdit").css("display", "none");
        $("#batchEdit input").val("");
        layer.close(index);
    }

    function getRoomLocation(m) {
        var html = "";
        $.ajax(
            {
                url: "sysIndex/roomLocationList.do",
                type: "GET",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data.data);
                    var d = data.data;
                    $(d).each(function (index) {
                        var temp = d[index];
                        html += "  <option value='" + temp.id + "' >" + temp.location + "</option>";
                    });
                    $(m).html(html);
                }
            }
        );
    }

    function getCustomType(n) {
        var html = "";
        $.ajax(
            {
                url: "sysIndex/customTypeList.do",
                type: "GET",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data.data);
                    var d = data.data;
                    $(d).each(function (index) {
                        var temp = d[index];
                        html += "  <option value='" + temp.id + "' >" + temp.type_name + "</option>";
                    });
                    $(n).html(html);
                }
            }
        );
    }

    function getHeatType(j) {
        var html = "";
        $.ajax(
            {
                url: "sysIndex/heatTypeList.do",
                type: "GET",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data.data);
                    var d = data.data;
                    $(d).each(function (index) {
                        var temp = d[index];
                        html += "  <option value='" + temp.id + "' >" + temp.type_name + "</option>";
                    });
                    $(j).html(html);
                }
            }
        );
    }

    function submitRoomInfo() {
        var build_num = $("#b_num").val();

        $.ajax({
            url: "sysIndex/checkBuilding.do",
            data: {zone_id: zone_id, build_num: build_num},
            type: "POST",
            dataType: "json",
            async: false,
            success: function (f) {
                if (f.state == "success") {
                    checkUnit(f.build_id);
                } else if (f.state == "error") {
                    $.ajax({
                        url: "sysIndex/addBuilding.do",
                        data: {zone_id: zone_id, build_num: build_num},
                        type: "POST",
                        dataType: "json",
                        async: false,
                        success: function (w) {
                            //    roomInfo();
                            //     var build_id=$("#buildingId").val();
                            checkUnit(w.build_id);
                            return false;
                        },
                        error: function (e) {
                            layer.msg("添加楼栋失败");
                            return false;
                        }
                    })
                }
            },
            error: function (e) {
                layer.msg("操作失败");
                return false;
            }
        });


        return false;
    }

    function checkUnit(build_id) {
        var data = $.param({"build_id": build_id}) + "&" + $("#roomInfo").serialize();
        $.ajax({
            url: "sysIndex/checkUnit.do",
            type: "POST",
            dataType: "json",
            data: data,
            async: false,
            success: function (d) {
                if (d.state == "success") {
                    //   data.unit_id=d.unit_id;
                    var unit_id = d.unit_id;
                    var c = $.param({"unit_id": unit_id}) + "&" + data;
                    submitRoom(c);
                } else if (d.state == "error") {
                    $.ajax({
                        url: "sysIndex/addUnit.do",
                        type: "POST",
                        dataType: "json",
                        data: data,
                        async: false,
                        success: function (e) {
                            var unit_id = e.unit_id;
                            var s = $.param({"unit_id": unit_id}) + "&" + data;
                            submitRoom(s);
                        }
                    });
                }
            },
            error: function () {
                layer.msg("添加单元失败");
            }
        });
    }

    function submitRoom(data) {
        $.ajax({
            url: "sysIndex/checkRoom.do",
            data: data,
            async: false,
            dataType: "json",
            type: "POST",
            success: function (r) {
                if (r.state == "success") {
                    addRoom(data);
                } else if (r.state == "error") {
                    layer.msg("此房间已存在");
                }
            },
            error: function () {
                layer.msg("操作失败");
            }
        });
    }

    function addRoom(data) {
        $.ajax(
            {
                url: "sysIndex/addRoomInfo.do",
                type: "POST",
                dataType: "json",
                data: data,
                async: false,
                success: function (data) {
                    if (data.state == "success") {
                        layer.msg("操作成功");
                        roomInfo();
                        //  findAll();
                        closeAddLayer();
                    }
                },
                error: function () {
                    layer.msg("操作失败");
                }
            }
        );
    }

    function deleteRoom(id) {
        $.ajax({
            url: 'sysIndex/deleteRoom.do',
            type: "GET",
            dataType: 'json',
            async: false,
            data: {id: id},
            success: function (result) {
                layer.msg("操作成功！");
                roomInfo();
                //   findAll();
            },
            error: function () {
                layer.msg("操作失败");
            }
        })
    }

    function getRoomInfo(id) {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            $.ajax({
                url: "sysIndex/getRoomInfo.do",
                dataType: 'json',
                data: {id: id},
                async: false,
                success: function (data) {
                    getRoomLocation("#changeLocation");
                    getCustomType("#changeUserType");
                    getHeatType("#changeHeatType");
                    $("#changeRoomInfo input[name='id']").val(data.id);
                    $("#changeRoomInfo input[name='r_num']").val(data.r_num);
                    $("#changeRoomInfo input[name='b_num']").val(data.b_num);
                    $("#changeRoomInfo input[name='u_num']").val(data.u_num);
                    $("#changeRoomInfo input[name='host_name']").val(data.host_name);
                    $("#changeLocation").val(data.location);
                    $("#changeUserType").val(data.user_type);
                    $("#changeRoomInfo input[name='user_code']").val(data.user_code);
                    $("#changeHeatType").val(data.heat_type);
                    $("#changeRoomInfo input[name='room_area']").val(data.room_area);
                    $("#changeRoomInfo input[name='heat_area']").val(data.heat_area);
                    $("#changeIsSupply").val(data.is_supply);
                    $("#changeChargeMode").val(data.charge_mode);
                    $("#changeRoomInfo input[name='contact_info']").val(data.contact_info);
                    $("#changeRoomInfo input[name='special_mark']").val(data.special_mark);
                    form.render("select", "selFilter1");

                }
            });
        })
    }

    function editRoomInfo() {
        var data = $("#changeRoomInfo").serialize();
        $.ajax({
            url: 'sysIndex/changeRoomInfo.do',
            type: "POST",
            dataType: 'json',
            async: false,
            data: data,
            success: function (result) {
                layer.msg("操作成功！");
                closeEditLayer();
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    table.reload("roomsList");
                })

            },
            error: function () {
                layer.msg("操作失败");
            }
        });
        return false;
    }

    function editSelected() {
        if (ids.length <= 0) {
            layer.msg("请选择数据！")
        } else {
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                getHeatType("#schangeHeatType");
                $("#schangeHeatType").prepend("<option value='' selected></option>");
                getCustomType("#schangeUserType");
                $("#schangeUserType").prepend("<option value='' selected></option>");
                getRoomLocation("#sLocation");
                $("#sLocation").prepend("<option value='' selected></option>");
                $("#schargeMode").val("");
                $("#sisSupply").val("");
                form.render("select", "selFilter2");
            });
            index = layer.open({
                type: 1,
                closeBtn: 0,
                skin: 'layui-layer-rim', //加上边框
                area: ['420px', '440px'], //宽高
                content: $('#batchEdit')
            });
        }
    }

    function batchEditSubmit() {

        //    var data=$("#batchEdit").serialize();
        var data = $.param({"ids": JSON.stringify(ids)}) + "&" + $("#batchEdit").serialize();
        console.log(data);
        $.ajax({
            url: "sysIndex/batchEdit.do",
            data: data,
            dataType: "json",
            contentType: "application/json",
            async: false,
            success: function () {
                layer.msg("操作成功！");
                closeBatchEdit();
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    table.reload("roomsList");
                })
            },
            error: function () {
                layer.msg("操作失败！");
                closeBatchEdit();
            }

        });
        ids = [];
        return false;
    }

    function batchDeleteSubmit() {
        if (ids.length <= 0) {
            layer.msg("请选择数据！")
        } else {
            layer.confirm('确定删除吗？', function (index) {
                var data = $.param({"ids": JSON.stringify(ids)});
                $.ajax({
                    url: "sysIndex/batchDelete.do",
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function () {
                        layer.msg("操作成功！");
                        findAll();
                    },
                    error: function () {
                        layer.msg("操作失败！");
                    }

                });
                ids = [];
                return false;
            })
        }
        //    var data=$("#batchEdit").serialize();


    }

    function exportRoomExcel() {

        var build_id = $("#buildingId").val();
        var is_supply = $("#isSupply").val();
        var change_mode = $("#chargeMode").val();
        var url = "sysIndex/exportRoomExcel.do?build_id=" + build_id + "&zone_id=" + zone_id + "&is_supply=" + is_supply + "&charge_mode=" + change_mode;
        window.open(url);
    }

    function findAll() {
        $("#buildings button").addClass("layui-btn-primary");
        $("#allRooms").removeClass("layui-btn-primary");
        $("#isSupply").val("");
        $("#chargeMode").val("");
        $("#buildingId").val("");
        $("#buildingNum").val("");
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomsList'
                , url: 'sysIndex/roomsList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {type: 'checkbox'}
                        , {field: 'r_num', title: '房间号', width: 60}
                        , {field: 'user_code', title: '收费编码', width: 100}
                        , {field: 'host_name', title: '户主', width: 65}
                        , {field: 'locationName', title: '房间位置', width: 60}
                        , {field: 'floor', title: '楼层', width: 60}
                        , {field: 'custom_typeName', title: '住户类型', width: 60}
                        , {field: 'heat_typeName', title: '采暖方式', width: 60}
                        , {field: 'room_area', title: '房屋面积', width: 60}
                        , {field: 'heat_area', title: '供暖面积', width: 60}
                        , {field: 'is_supply', title: '供暖状态', width: 60}
                        , {field: 'charge_mode', title: '计量方式', width: 60}
                        , {field: 'contact_info', title: '联系电话', width: 110}
                        , {field: 'special_mark', title: '特殊标识', width: 50}
                        , {width: 120, title: '操作', align: 'center', toolbar: '#deal'}
                        , {field: 'update_time', title: '更新时间', maxWidth: 100}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                , done: function (res) {
                    //设置全部数据到全局变量
                    table_data = res.data;
                    // $("#allRooms span").html("("+res.count+")");
                }
            });
            table.on('tool(operation)', function (obj) {
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'del') { //删除
                    var id = data.id;
                    layer.confirm('确定删除吗？', function (index) {
                        deleteRoom(id);
                        roomInfo();
                        findAll();
                    })
                } else if (layEvent === 'edit') {
                    var id = data.id;
                    getRoomInfo(id);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '540px'], //宽高
                        content: $('#changeRoomInfo')
                    });
                }
            });
            table.on('checkbox(operation)', function (obj) {
                console.log(obj);
                if (obj.checked == true) {
                    if (obj.type == 'one') {
                        ids.push(obj.data.id);
                    } else {
                        for (var i = 0; i < table_data.length; i++) {
                            ids.push(table_data[i].id);
                        }
                    }
                } else {
                    if (obj.type == 'one') {
                        for (var i = 0; i < ids.length; i++) {
                            if (ids[i] == obj.data.id) {
                                ids.splice(i, 1);
                            }
                        }
                    } else {
                        for (var i = 0; i < ids.length; i++) {
                            for (var j = 0; j < table_data.length; j++) {
                                if (ids[i] == table_data[j].id) {
                                    ids.splice(i, 1);
                                }
                            }
                        }
                    }
                }
                console.log(ids);
            });

            //搜索加载--数据表格重载
            var $ = layui.$, active = {
                reload: function () {
                    //执行重载
                    table.reload('roomsList', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            charge_mode: $("#chargeMode").val(),
                            is_supply: $("#isSupply").val()
                        }
                    });
                }
            };
            $('#find').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        })
    }

    function downloadTemplate() {
        index = layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['300px', '200px'], //宽高
            content: $('#choseTemplate')
        });
    }

    function closeTemplateLayer() {
        layer.close(index);
        $("#choseTemplate").css("display", "none");
    }

    function submitTemplate() {
        var template = $("#choseTemplate").serialize();
        var url = "sysIndex/downloadTemplate.do?" + template;
        window.open(url);
        closeTemplateLayer();
        return false;
    }

    layui.use('upload', function () {
        var upload = layui.upload;
        //执行实例
        var uploadInst = upload.render({
            elem: '#uploadAll' //绑定元素
            , url: 'sysIndex/uploadRoomInfo.do' //上传接口
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
                roomInfo();
                findAll();
            }
            , error: function (res) {
                //请求异常回调
                layer.msg(res.message);
            }
        });
    });
    layui.use('upload', function () {
        var upload = layui.upload;
        //执行实例
        var uploadInst = upload.render({
            elem: '#uploadIsSupply' //绑定元素
            , url: 'sysIndex/uploadIsSupply.do' //上传接口
            , exts: 'xlsx'
            , accept: 'file'
            , data: {
                zone_id: zone_id
            }
            , before: function (obj) { //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                layer.load(); //上传loading
            }
            , done: function (res) {
                layer.closeAll('loading'); //关闭loading
                //上传完毕回调
                if (res.code == 0) {
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
                roomInfo();
                findAll();
            }
            , error: function (res) {
                layer.closeAll('loading'); //关闭loading
                //请求异常回调
                layer.msg(res.message);
            }
        });
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

