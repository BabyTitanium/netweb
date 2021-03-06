<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/20
  Time: 9:07
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
    <title>采暖季管理</title>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script type="text/javascript" src="layui/jquery-2.2.4.min.js"></script>

    <link rel="stylesheet" href="layui/css/layui.css">
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
        <jsp:param value="heatSeason" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->
<div class="areachoose">
    <div class="layui-container area-top" style="">
        <blockquote class="layui-elem-quote layui-text">
            采暖季管理
            <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
        </blockquote>
    </div>
</div>
<div class="layui-container">
    <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
        <i class="layui-icon" style="font-size: 18px;">&#xe60e;</i>数据列表
        <button style="float: right;margin-top: -5px" class="layui-btn layui-btn-primary layui-btn-sm" onclick="addHeatSeason()">  添加</button>
    </div>
    <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
        <form class="layui-form">
            <div class="layui-inline">
                <label class="layui-form-label">名称</label>
                <div class="layui-input-inline">
                    <input class="layui-input" id="name" type="text" name="name" required>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">起始日期</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="start_date" id="start_date" required>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束日期</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="end_date" id="end_date" required>
                </div>
            </div>
            <div class="layui-inline" style="padding-left: 30px">
                <button id="find" type="button" onclick="finds()" class="layui-btn layui-btn-primary" >搜索</button>
            </div>
        </form>
    </div>
    <table id="heatSeasonList" lay-filter="operation" ></table>
    <script type="text/html" id="deal">

        <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>

</div>
    </div>

    <jsp:include page="footer.jsp"/>
</div>
<form class="layui-form " id="addHeatSeason" onsubmit="return submitHeatSeason();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="season_name" class="layui-input" required>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" >起始日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="start_date" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" >结束日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="end_date" required>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeAddLayer()">取消</button>
    </div>
</form>
<form class="layui-form " id="editHeatSeason" onsubmit="return editHeatSeason();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="season_id" hidden>
            <input type="text" name="season_name" class="layui-input" required>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" >起始日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="start_date" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" >结束日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="end_date" required>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeEditLayer()">取消</button>
    </div>
</form>
<script type="text/javascript" src="layui/layui.all.js"></script>
<script type="text/javascript">

    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start_date' //指定元素
            ,format: 'yyyy-MM-dd' //可任意组合
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#end_date' //指定元素
            ,format: 'yyyy-MM-dd' //可任意组合
        });
        //执行一个laydate实例
        laydate.render({
            elem: "#addHeatSeason input[name='start_date']" //指定元素
            ,format: "yyyy-MM-dd"//可任意组合
        });
        //执行一个laydate实例
        laydate.render({
            elem: "#addHeatSeason input[name='end_date']" //指定元素
            ,format: 'yyyy-MM-dd' //可任意组合
        });
        //执行一个laydate实例
        laydate.render({
            elem: "#editHeatSeason input[name='start_date']" //指定元素
            ,format: "yyyy-MM-dd"//可任意组合
        });
        //执行一个laydate实例
        laydate.render({
            elem: "#editHeatSeason input[name='end_date']" //指定元素
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });
    var index;
    finds();
    function closeAddLayer() {
        $("#addHeatSeason").css("display","none");
        $("#addHeatSeason input[name='season_name']").val("");
        $("#addHeatSeason input[name='start_date']").val("");
        $("#addHeatSeason input[name='end_date']").val("");
        layer.close(index);
    }
    function addHeatSeason() {
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['450px', '300px'], //宽高
            content: $('#addHeatSeason')
        });
    }
    function submitHeatSeason() {
        var heatSeason=$("#addHeatSeason").serialize();
        console.log(heatSeason);
        var id=$("#addHeatSeason input[name='season_id']").val();
        var season_name=$("#addHeatSeason input[name='season_name']").val();
        var namecheck=nameCheck(id,season_name);
        if(!namecheck){
            layer.tips('名称已存在', "#addHeatSeason input[name='season_name']");
        }
        else {
            $.ajax({
                type:"POST",
                dataType:"json",
                data:heatSeason,
                url:"heatSeason/addHeatSeason.do",
                async:false,
                success:function (data) {
                    if (data.state == "success") {
                        layer.msg("操作成功",{time:1000},function () {
                            window.location.reload();
                        });
                        return false;
                    } else {
                        layer.msg("操作失败");
                        return false;
                    }
                },
                error:function () {
                    layer.msg("操作失败");
                    return false;
                }
            });
        }
        return false;
    }
    function  nameCheck(id,season_name) {
        var state=true;
        $.ajax({
            type:"GET",
            dataType:"json",
            data:{season_id:id,season_name:season_name},
            url:"heatSeason/HeatSeasonNameCheck.do",
            async:false,
            success:function (data) {
                if (data.state == "success") {
                    state=true;
                } else {
                    state=false;
                }
            },
            error:function () {
                layer.msg("操作失败");
                state=false;
            }
        });
        return state;
    }

    function closeEditLayer() {
        $("#editHeatSeason").css("display","none");
        layer.close(index);
    }
    function editHeatSeason() {
        var heatSeason=$("#editHeatSeason").serialize();
        console.log(heatSeason);
        var season_id=$("#editHeatSeason input[name='season_id']").val();
        var season_name=$("#editHeatSeason input[name='season_name']").val();
        var namecheck=nameCheck(season_id,season_name);
        if(!namecheck){
            layer.tips('名称已存在', "#editHeatSeason input[name='season_name']");
        }
        else {
            $.ajax({
                type:"POST",
                dataType:"json",
                data:heatSeason,
                url:"heatSeason/editHeatSeason.do",
                async:false,
                success:function (data) {
                    if (data.state == "success") {
                        layer.msg("操作成功",{time:1000},function () {
                            window.location.reload();
                        });
                        return false;
                    } else {
                        layer.msg("操作失败");
                        return false;
                    }
                },
                error:function () {
                    layer.msg("操作失败");
                    return false;
                }
            });
        }
        return false;
    }

    function finds() {
        var season_name=$("#name").val();
        var start_date=$("#start_date").val();
        var end_date=$("#end_date").val();
        layui.use('table', function() {
            var table = layui.table
                ,form = layui.form;
            //第一个实例
            table.render({
                elem: '#heatSeasonList'
                , url: 'heatSeason/heatSeasonList.do?season_name='+season_name+'&start_date='+start_date+'&end_date=' +end_date//数据接口
                , cols: [
                    [ //表头
                        {field: 'season_name', title: '采暖季名称',  minWidth: 100}
                        , {field: 'start_date', title: '起始时间',  minWidth: 100}
                        , {field: 'end_date', title: '结束时间',  minWidth: 100}
                        , { minWidth: 100, align: 'center', toolbar: '#deal'} //这里的toolbar值是模板元素的选择器
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10

            });


            //监听工具条
            table.on('tool(operation)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if(layEvent === 'del'){ //删除
                    var id=data.season_id;
                    //先判断是否有此住户类型的住户
                        layer.confirm('确定删除吗？', function(index){
                            layer.close(index);
                            //向服务端发送删除指令
                            $.ajax({
                                dataType:"json",
                                data:{season_id:id},
                                url:"heatSeason/deleteHeatSeason.do",
                                async:false,
                                success:function (data) {
                                    layer.msg("操作成功");
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                }
                            });
                        });

                } else if(layEvent === 'edit'){ //编辑
                    $("#editHeatSeason input[name='season_id']").val("");
                    $("#editHeatSeason input[name='season_name']").val("");
                    $("#editHeatSeason input[name='start_date']").val("");
                    $("#editHeatSeason input[name='end_date']").val("");
                    var id=data.season_id;
                    console.log(id);
                    $.ajax({
                        dataType:"json",
                        data:{id:id},
                        url:"heatSeason/getHeatSeason.do",
                        async:false,
                        success:function (data) {
                            $("#editHeatSeason input[name='season_id']").val(data.season_id);
                            $("#editHeatSeason input[name='season_name']").val(data.season_name);
                            $("#editHeatSeason input[name='start_date']").val(data.start_date);
                            $("#editHeatSeason input[name='end_date']").val(data.end_date);
                        }
                    });
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['450px', '300px'], //宽高
                        content: $('#editHeatSeason')
                    });

                }
            });
        })
    }
</script>
</body>
</html>
