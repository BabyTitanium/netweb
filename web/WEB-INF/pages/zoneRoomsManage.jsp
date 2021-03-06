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
                    <li class="layui-this" onclick="roomInfo()">房间信息管理</li>
                    <li onclick="buildingInfo()">楼栋管理</li>
                    <li onclick="branchInfo()">分支管理</li>
                    <li onclick="alarmsInfo()">故障报警设置</li>
                    <li onclick="parameterSetting()">参数设置</li>

                    <li onclick="roomMeterInfo()">热量表管理</li>
                    <li onclick="roomValveInfo()">阀门管理</li>
                    <li onclick="roomTempInfo()">测温节点管理</li>
                    <li onclick="roomThermostatInfo()">无线面板管理</li>
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
                    <%--楼栋管理--%>
                    <div class="layui-tab-item">
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
                    <%--分支管理--%>
                    <div class="layui-tab-item">
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
                    <%--故障报警设置--%>
                    <div class="layui-tab-item canshu">
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
                    <%--参数设置--%>
                    <div class="layui-tab-item">
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

                    <%--热量表管理--%>
                    <div class="layui-tab-item">
                        <div id="meterButton">
                            <input type="text" id="meterOnlineState" hidden>
                            <button class='layui-btn layui-btn-sm ' id="allMeterCount">全部<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="onlineMeterCount">
                                在线<span></span></button>
                            <button class='layui-btn layui-btn-sm layui-btn-primary' id="offlineMeterCount">
                                离线<span></span></button>
                        </div>
                        <div>
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12 layui-col-sm12 layui-col-xs12 layui-col-lg12 content">
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <%--<div class="layui-row">--%>
                                            <div class="layui-col-lg5 layui-col-md1 layui-col-sm12 layui-col-xs12">
                                                热量表列表
                                            </div>
                                            <div class="layui-col-lg7 layui-col-md11 layui-col-sm12 layui-col-xs12 right">
                                                <a href="javascript:;" onclick="downloadRoomMeterTemplate()">下载模板</a>
                                                <a href="javascript:;" id="importRoomMeter">导入表具</a>
                                                <a href="javascript:;" onclick="exportRoomMeter()">导出Excel</a>


                                                <form class="layui-form " style=" width: 300px;float:right">
                                                    <div class="layui-inline">
                                                        <%--<div class="layui-input-block">--%>
                                                        <input type="text" id="roomMeterSearch" class="layui-input"
                                                               style="height: 30px">
                                                        <%--</div>--%>
                                                    </div>
                                                    <div class="layui-inline" style="padding-left: 30px">
                                                        <button onclick="searchRoomMeter()" type="button"
                                                                class="layui-btn layui-btn-sm layui-btn-primary">搜索
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>

                                            <%--</div>--%>
                                        </div>
                                        <div class="layui-card-body layui-col-xs12" style="padding: 0;">
                                            <table id="roomMeterList" lay-filter="operation5"></table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--阀门管理--%>
                    <div class="layui-tab-item">
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
                    <%--测温节点管理--%>
                    <div class="layui-tab-item">
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
                    <%--无线面板管理--%>
                    <div class="layui-tab-item">
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
    <form id="addDevice" class="layui-form" hidden onsubmit="return addDeviceInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter7">
        <div class="layui-form-item">
            <label class="layui-form-label">基站网络号</label>
            <div class="layui-input-block">
                <input type="text" name="device_net" id="device_net" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">设备类型</label>
            <div class="layui-input-block">
                <select name="device_type">
                    <option value=""> 请选择</option>
                    <option value="0"> 网络基站</option>
                    <option value="1"> 集抄器</option>
                    <%--<option value="2" > Lora基站</option>--%>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">安装位置</label>
            <div class="layui-input-block">
                <input type="text" name="location" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn layui-btn-sm" type="submit">确定</button>
            <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeAddDeviceLayer()">取消
            </button>
        </div>
    </form>
    <form id="editDevice" class="layui-form" hidden onsubmit="return editDeviceInfo();"
          style="padding: 10px;display: none" lay-filter="selFilter8">
        <div class="layui-form-item">
            <label class="layui-form-label">基站网络号</label>
            <div class="layui-input-block">
                <input type="text" name="device_net" class="layui-input" required readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">设备类型</label>
            <div class="layui-input-block">
                <select name="device_type" id="device_type">
                    <option value=""> 请选择</option>
                    <option value="0"> 网络基站</option>
                    <option value="1"> 集抄器</option>
                    <%--<option value="2" > Lora基站</option>--%>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">安装位置</label>
            <div class="layui-input-block">
                <input type="text" name="location" class="layui-input" required>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center">
            <button class="layui-btn layui-btn-sm" type="submit">确定</button>
            <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeEditDeviceLayer()">取消
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
            url: "sysIndex/branchNameCheck.do",
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

    //基站管理
    function deviceInfo() {
        $.ajax({
            url: "sysIndex/getDeviceCount.do",
            async: 'false',
            dataType: 'json',
            type: 'GET',
            success: function (res) {
                $("#allDeviceCount span ").html("(" + res.all + ")");
                $("#onlineDeviceCount span ").html("(" + res.online + ")");
                $("#offlineDeviceCount span ").html("(" + res.offline + ")");
            }
        })
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#deviceList'
                , url: 'sysIndex/deviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号', width: 150, maxWidth: 200}
                        , {field: 'location', title: '基站安装位置', width: 200, maxWidth: 200}
                        , {field: 'device_ip', title: '基站IP', width: 200, maxWidth: 200}
                        , {field: 'device_port', title: '基站端口号', width: 200, maxWidth: 200}
                        , {field: 'heart_time', title: '心跳包时间', width: 200, maxWidth: 200}
                        , {maxWidth: 300, minWidth: 150, title: '操作', align: 'center', toolbar: '#dealE'}

                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            //监听锁定操作
            table.on('tool(operation4)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'edit') {
                    var device_net = data.device_net;
                    getDeviceInfo(device_net);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    });
                } else if (layEvent === 'del') {
                    layer.confirm('确定删除吗？', function (index) {
                        deleteDevice(data.device_net);
                    })
                }
            });
        })
    }

    function closeEditDeviceLayer() {
        $("#editDevice").css("display", "none");
        $("#editDevice input").val("");
        layer.close(index);
    }

    function getDeviceInfo(device_net) {
        $.ajax({
            url: 'sysIndex/getDeviceInfo.do?device_net=' + device_net
            , dataType: 'json'
            , async: false
            , type: 'GET'
            , success: function (res) {
                $("#editDevice input[name='device_net']").val(res.device_net);
                $("#editDevice input[name='location']").val(res.location);
                $("#device_type").val(res.device_type);
                layui.use('table', function () {
                    var table = layui.table
                        , form = layui.form;
                    form.render("select", "selFilter8");
                });
            }
        });
    }

    function addDevice() {
        index = layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['350px', '300px'], //宽高
            content: $('#addDevice')
        });
    }

    function checkDeviceNet(device_net) {
        var state = true;
        $.ajax({
            type: "GET",
            dataType: "json",
            data: {device_net: device_net},
            url: "sysIndex/checkDeviceNet.do",
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

    function closeAddDeviceLayer() {
        $("#addDevice").css("display", "none");
        $("#addDevice input").val("");
        layer.close(index);
    }

    function addDeviceInfo() {
        var device = $("#addDevice").serialize();
        var device_net = $("#device_net").val();
        console.log(1);
        if (checkDeviceNet(device_net)) {
            $.ajax({
                url: 'sysIndex/addDeviceInfo.do',
                data: device,
                async: false,
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    layer.msg("操作成功");
                    closeAddDeviceLayer();
                    deviceInfo();
                },
                error: function () {
                    layer.msg("操作失败");
                    closeAddDeviceLayer();
                }
            });
        } else {
            layer.tips('名称已存在', "#addDevice input[name='device_net']");
        }
        return false;
    }

    function editDeviceInfo() {
        var device = $("#editDevice").serialize();
        $.ajax({
            url: 'sysIndex/editDevice.do',
            data: device,
            dataType: 'json',
            type: 'POST',
            async: false,
            success: function (res) {
                layer.msg("操作成功");
                closeEditDeviceLayer();
                deviceInfo();
            },
            error: function () {
                layer.msg("操作失败");
            }

        });
        return false;
    }

    function allDevice() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#deviceList'
                , url: 'sysIndex/deviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号', width: 150, maxWidth: 200}
                        , {field: 'location', title: '基站安装位置', width: 200, maxWidth: 200}
                        , {field: 'device_ip', title: '基站IP', width: 200, maxWidth: 200}
                        , {field: 'device_port', title: '基站端口号', width: 200, maxWidth: 200}
                        , {field: 'heart_time', title: '心跳包时间', width: 200, maxWidth: 200}
                        , {maxWidth: 300, minWidth: 150, title: '操作', align: 'center', toolbar: '#dealE'}

                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            //监听锁定操作
            table.on('tool(operation4)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'edit') {
                    var device_net = data.device_net;
                    getDeviceInfo(device_net);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    });
                } else if (layEvent === 'del') {
                    layer.confirm('确定删除吗？', function (index) {
                        deleteDevice(data.device_net);
                    })
                }
            });
        })
    }

    $("#deviceButton button").on("click", function () {
        $("#deviceButton button").addClass("layui-btn-primary");
        $(this).removeClass("layui-btn-primary");
    })

    function onlineDevice() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#deviceList'
                , url: 'sysIndex/onlineDeviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号', width: 150, maxWidth: 200}
                        , {field: 'location', title: '基站安装位置', width: 200, maxWidth: 200}
                        , {field: 'device_ip', title: '基站IP', width: 200, maxWidth: 200}
                        , {field: 'device_port', title: '基站端口号', width: 200, maxWidth: 200}
                        , {field: 'heart_time', title: '心跳包时间', width: 200, maxWidth: 200}
                        , {maxWidth: 300, minWidth: 150, title: '操作', align: 'center', toolbar: '#dealE'}

                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            //监听锁定操作
            table.on('tool(operation4)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'edit') {
                    var device_net = data.device_net;
                    getDeviceInfo(device_net);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    });
                } else if (layEvent === 'del') {
                    layer.confirm('确定删除吗？', function (index) {
                        deleteDevice(data.device_net);
                    })
                }
            });
        })
    }

    function offlineDevice() {
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#deviceList'
                , url: 'sysIndex/offlineDeviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号', width: 150, maxWidth: 200}
                        , {field: 'location', title: '基站安装位置', width: 200, maxWidth: 200}
                        , {field: 'device_ip', title: '基站IP', width: 200, maxWidth: 200}
                        , {field: 'device_port', title: '基站端口号', width: 200, maxWidth: 200}
                        , {field: 'heart_time', title: '心跳包时间', width: 200, maxWidth: 200}
                        , {maxWidth: 300, minWidth: 150, title: '操作', align: 'center', toolbar: '#dealE'}
                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            //监听锁定操作
            table.on('tool(operation4)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if (layEvent === 'edit') {
                    var device_net = data.device_net;
                    getDeviceInfo(device_net);
                    index = layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    });
                } else if (layEvent === 'del') {
                    layer.confirm('确定删除吗？', function (index) {
                        deleteDevice(data.device_net);
                    })
                    ;

                }
            });
        })
    }

    function deleteDevice(device_net) {
        $.ajax({
            url: 'sysIndex/deleteDevice.do',
            type: "GET",
            dataType: 'json',
            async: false,
            data: {device_net: device_net},
            success: function (result) {
                layer.msg("操作成功！");
                deviceInfo();
            },
            error: function () {
                layer.msg("操作失败");
            }
        })
    }

    //热量表
    function roomMeterInfo() {
        $.ajax({
            url: "sysIndex/getMeterCount.do?zone_id=" + zone_id,
            async: 'false',
            dataType: 'json',
            type: 'GET',
            success: function (res) {
                $("#allMeterCount span ").html("(" + res.all + ")");
                $("#onlineMeterCount span ").html("(" + res.online + ")");
                $("#offlineMeterCount span ").html("(" + res.offline + ")");
            }
        })
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomMeterList'
                , url: 'sysIndex/roomMeterList.do?zone_id=' + zone_id
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                        , {field: 'meter_model', title: '型号', width: 80, maxWidth: 200}
                        , {field: 'meter_addr', title: '热量表地址', width: 80, maxWidth: 200}
                        , {field: 'cu_heat', title: '累计热量(kWh)', width: 80, maxWidth: 200}
                        , {field: 'heat_power', title: '热功率(kW)', width: 80, maxWidth: 200}
                        , {field: 'cu_flow', title: '累计流量(m³)', width: 80, maxWidth: 200}
                        , {field: 'flow_rate', title: '瞬时流速(m³/h)', width: 80, maxWidth: 200}
                        , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'hours', title: '工作时间(h)', width: 80, maxWidth: 200}
                        , {field: 'battery_status', title: '电池状态', width: 80, maxWidth: 200}
                        , {field: 'data_time', title: '数据时间', width: 90, maxWidth: 200}
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
            elem: '#importRoomMeter' //绑定元素
            , url: 'sysIndex/importRoomMeter.do' //上传接口
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
                roomMeterInfo();
                findAll();
            }
            , error: function (res) {
                //请求异常回调
                layer.msg(res.message);
            }
        });
    });

    function downloadRoomMeterTemplate() {
        var url = "sysIndex/downloadRoomMeterTemplate.do";
        window.open(url);
    }

    function exportRoomMeter() {
        var meterOnlineState = $("#meterOnlineState").val();
        var url = "sysIndex/exportRoomMeter.do?zone_id=" + zone_id + "&onlineState=" + meterOnlineState;
        window.open(url);
    }

    var roomMeterListObj = new Array();

    function searchRoomMeter() {
        var meterOnlineState = $("#meterOnlineState").val();
        $.ajax({
            url: 'sysIndex/allRoomMeter.do',
            data: {zone_id: zone_id, onlineState: meterOnlineState},
            dataType: 'json',
            type: 'GET',
            async: false,
            success: function (res) {
                roomMeterListObj = res;
            },
            error: function () {
            }
        });
        var key = $("#roomMeterSearch").val();
        if (key != null && key != "") {
            var str = "";
            var temp = new Array();
            var l = roomMeterListObj.length;
            for (var i = 0; i < l; i++) {
                for (var k in roomMeterListObj[i]) {
                    str = JSON.stringify(roomMeterListObj[i][k]);
                    //    console.log(str);
                    if (str.indexOf(key) != -1) {
                        temp.push(roomMeterListObj[i]);
                        break;
                    }
                }
            }
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomMeterList'
                    , data: temp
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                            , {field: 'meter_model', title: '型号', width: 80, maxWidth: 200}
                            , {field: 'meter_addr', title: '热量表地址', width: 80, maxWidth: 200}
                            , {field: 'cu_heat', title: '累计热量(kWh)', width: 80, maxWidth: 200}
                            , {field: 'heat_power', title: '热功率(kW)', width: 80, maxWidth: 200}
                            , {field: 'cu_flow', title: '累计流量(m³)', width: 80, maxWidth: 200}
                            , {field: 'flow_rate', title: '瞬时流速(m³/h)', width: 80, maxWidth: 200}
                            , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'hours', title: '工作时间(h)', width: 80, maxWidth: 200}
                            , {field: 'battery_status', title: '电池状态', width: 80, maxWidth: 200}
                            , {field: 'data_time', title: '数据时间', width: 90, maxWidth: 200}
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
        } else {
            layui.use('table', function () {
                var table = layui.table
                    , form = layui.form;
                table.render({
                    elem: '#roomMeterList'
                    , data: roomMeterListObj
                    , cols: [
                        [ //表头
                            {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                            , {field: 'meter_model', title: '型号', width: 80, maxWidth: 200}
                            , {field: 'meter_addr', title: '热量表地址', width: 80, maxWidth: 200}
                            , {field: 'cu_heat', title: '累计热量(kWh)', width: 80, maxWidth: 200}
                            , {field: 'heat_power', title: '热功率(kW)', width: 80, maxWidth: 200}
                            , {field: 'cu_flow', title: '累计流量(m³)', width: 80, maxWidth: 200}
                            , {field: 'flow_rate', title: '瞬时流速(m³/h)', width: 80, maxWidth: 200}
                            , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                            , {field: 'hours', title: '工作时间(h)', width: 80, maxWidth: 200}
                            , {field: 'battery_status', title: '电池状态', width: 80, maxWidth: 200}
                            , {field: 'data_time', title: '数据时间', width: 90, maxWidth: 200}
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
        }
    }

    $("#meterButton button").on("click", function () {
        $("#meterButton button").addClass("layui-btn-primary");
        $(this).removeClass("layui-btn-primary");
        if (this.id == "onlineMeterCount") {
            $("#meterOnlineState").val("online");
        } else if (this.id == "offlineMeterCount") {
            $("#meterOnlineState").val("offline");
        } else {
            $("#meterOnlineState").val("");
        }
        var meterOnlineState = $("#meterOnlineState").val();
        layui.use('table', function () {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#roomMeterList'
                , url: 'sysIndex/roomMeterList.do?zone_id=' + zone_id + "&onlineState=" + meterOnlineState
                , cols: [
                    [ //表头
                        {field: 'r_num', title: '房间号', width: 80, maxWidth: 200, sort: true}
                        , {field: 'meter_model', title: '型号', width: 80, maxWidth: 200}
                        , {field: 'meter_addr', title: '热量表地址', width: 80, maxWidth: 200}
                        , {field: 'cu_heat', title: '累计热量(kWh)', width: 80, maxWidth: 200}
                        , {field: 'heat_power', title: '热功率(kW)', width: 80, maxWidth: 200}
                        , {field: 'cu_flow', title: '累计流量(m³)', width: 80, maxWidth: 200}
                        , {field: 'flow_rate', title: '瞬时流速(m³/h)', width: 80, maxWidth: 200}
                        , {field: 'in_temp', title: '进水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'out_temp', title: '回水温度(°C)', width: 80, maxWidth: 200}
                        , {field: 'hours', title: '工作时间(h)', width: 80, maxWidth: 200}
                        , {field: 'battery_status', title: '电池状态', width: 80, maxWidth: 200}
                        , {field: 'data_time', title: '数据时间', width: 90, maxWidth: 200}
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
    });

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
</script>
</body>
</html>

