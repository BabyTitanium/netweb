<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/23
  Time: 10:27
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
    <title>阀门型号管理</title>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script type="text/javascript" src="layui/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="layui/layui.all.js"></script>
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
        <jsp:param value="valveModel" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="areachoose">
    <div class="layui-container area-top" style="">
        <blockquote class="layui-elem-quote layui-text">
            阀门型号管理
            <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
        </blockquote>
    </div>
</div>
        <div class="layui-container">
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <i class="layui-icon" style="font-size: 18px;">&#xe60e;</i>数据列表
                <button style="float: right;margin-top: -5px" class="layui-btn layui-btn-primary layui-btn-sm" onclick="addValveModel()">  添加</button>
            </div>
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <form class="layui-form">
                    <div class="layui-inline">
                        <label class="layui-form-label">型号名称</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="modelName" type="text" name="model_name">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">生产厂家</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="modelManu" type="text" name="model_manu">
                        </div>
                    </div>
                    <div class="layui-inline" style="padding-left: 30px">
                        <button id="find" type="button" onclick="finds()" class="layui-btn layui-btn-primary" >搜索</button>
                    </div>
                </form>
            </div>
            <table id="valveModelList" lay-filter="operation" ></table>
            <script type="text/html" id="switchTpl">
                <a lay-event="click">
                    <input type="checkbox"  name="available" value="{{d.available}}" lay-skin="switch" lay-text="ON|OFF" lay-filter="click" {{ d.available ==0 ? 'checked'  : ' ' }}>
                </a>
            </script>
            <script type="text/html" id="deal">

                <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>

        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<form class="layui-form " id="addValveModel" onsubmit="return submitValveModel();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">型号名称</label>
        <div class="layui-input-block">
            <input type="text" name="model_name" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">生产厂家</label>
        <div class="layui-input-block">
            <input type="text" name="model_manu" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">通讯方式</label>
        <div class="layui-input-block">
            <select name="comm_mode" lay-filter="comm" required>
                <option value="有线" selected> 有线</option>
                <option value="Lora">Lora</option>
                <option value="NBIot">NBIot</option>
                <option value="DTU">DTU</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">协议编号</label>
        <div class="layui-input-block">
            <input type="text" name="prot_num" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">阀门口径</label>
        <div class="layui-input-block">
            <input type="text" name="caliber" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开关控制时长</label>
        <div class="layui-input-block">
            <input type="text" name="ctrl_time" class="layui-input" required >
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeAddLayer()">取消</button>
    </div>
</form>
<form class="layui-form" id="editValveModel" onsubmit="return editValveModel();" style="padding: 10px;display: none" lay-filter="selFilter">
    <div class="layui-form-item">
        <label class="layui-form-label">型号名称</label>
        <div class="layui-input-block">
            <input type="text" name="id" hidden>
            <input type="text" name="model_name" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">生产厂家</label>
        <div class="layui-input-block">
            <input type="text" name="model_manu" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">通讯方式</label>
        <div class="layui-input-block">
            <select name="comm_mode" id="commMode" required>
                <option value="有线" > 有线</option>
                <option value="Lora">Lora</option>
                <option value="NBIot">NBIot</option>
                <option value="DTU">DTU</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">协议编号</label>
        <div class="layui-input-block">
            <input type="text" name="prot_num" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">阀门口径</label>
        <div class="layui-input-block">
            <input type="text" name="caliber" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开关控制时长</label>
        <div class="layui-input-block">
            <input type="text" name="ctrl_time" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeEditLayer()">取消</button>
    </div>
</form>
<script type="text/javascript" src="layui/layui.all.js"></script>
<script type="text/javascript">
    var index;
    finds();
    function closeAddLayer() {
        layer.close(index);
        $("#addValveModel").css("display","none");
        $("#addValveModel input").val("");
    }
    function addValveModel() {
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['450px'], //宽高
            content: $('#addValveModel'),

        });
    }
    function submitValveModel() {
        var customType=$("#addValveModel").serialize();
        var id=$("#addValveModel input[name='id']").val();
        var model_name=$("#addValveModel input[name='model_name']").val();
        var namecheck=nameCheck(id,model_name);
        if(!namecheck){
            layer.tips('名称已存在', "#addValveModel input[name='model_name']");
        }
        else {
            $.ajax({
                type:"POST",
                dataType:"json",
                data:customType,
                url:"valveModel/addValveModel.do",
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
    function  nameCheck(id,model_name) {
        var state=true;
        $.ajax({
            type:"GET",
            dataType:"json",
            data:{id:id,model_name:model_name},
            url:"valveModel/modelNameCheck.do",
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
        $("#editValveModel").css("display","none");
        layer.close(index);
    }
    function editValveModel() {
        var valveModel=$("#editValveModel").serialize();
        var id=$("#editValveModel input[name='id']").val();
        var model_name=$("#editValveModel input[name='model_name']").val();
        var namecheck=nameCheck(id,model_name);
        if(!namecheck){
            layer.tips('名称已存在', "#editCustomType input[name='model_name']");
        }
        else {
            $.ajax({
                type:"POST",
                dataType:"json",
                data:valveModel,
                url:"valveModel/editValveModel.do",
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
        var model_name=$("#modelName").val();
        var model_manu=$("#modelManu").val();
        layui.use('table', function() {
            var table = layui.table
                ,form = layui.form;
            form.render();
            //第一个实例
            table.render({
                elem: '#valveModelList'
                , url: 'valveModel/valveModelList.do?model_name='+model_name+'&model_manu='+model_manu //数据接口
                , cols: [
                    [ //表头
                        {field: 'model_name', title: '型号名称',  minWidth: 100}
                        ,{field: 'model_manu', title: '生产厂家',  minWidth: 100}
                        ,{field: 'comm_mode',title:'通讯方式', minWidth: 100}
                        ,{field:'prot_num',title:'协议编号', minWidth: 100}
                        ,{field:'caliber',title:'阀门口径(mm)', minWidth: 100}
                        ,{field:'ctrl_time',title:'开关控制时长(s)', minWidth: 100}
                        ,{field: 'available', title:'是否启用',  minWidth: 100, templet: '#switchTpl', unresize: true}
                        ,{minWidth: 100, align: 'center', toolbar: '#deal'} //这里的toolbar值是模板元素的选择器
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
                    var id=data.id;
                    //先判断是否有此住户类型的住户
                        layer.confirm('确定删除吗？', function(index){
                            layer.close(index);
                            //向服务端发送删除指令
                            $.ajax({
                                dataType:"json",
                                data:{id:id},
                                url:"valveModel/deleteValveModel.do",
                                async:false,
                                success:function (data) {
                                    layer.msg("操作成功");
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                }
                            });
                        });


                } else if(layEvent === 'edit'){ //编辑
                    $("#editValveModel input[name='id']").val("");
                    $("#editValveModel input[name='model_name']").val("");
                    $("#editValveModel input[name='model_manu']").val("");
                    $("#editValveModel input[name='comm_mode']").val("");
                    $("#editValveModel input[name='prot_num']").val("");
                    $("#editValveModel input[name='caliber']").val("");
                    $("#editValveModel input[name='ctrl_time']").val("");
                    var id=data.id;
                    $.ajax({
                        dataType:"json",
                        data:{id:id},
                        url:"valveModel/getValveModel.do",
                        async:false,
                        success:function (data) {
                            $("#editValveModel input[name='id']").val(data.id);
                            $("#editValveModel input[name='model_name']").val(data.model_name);
                            $("#editValveModel input[name='model_manu']").val(data.model_manu);
                            $("#commMode").val(data.comm_mode);
                           form.render("select","selFilter");
                            var comm_mode=data.comm_mode;
                            console.log(comm_mode);
                            $("#editValveModel input[name='prot_num']").val(data.prot_num);
                            $("#editValveModel input[name='caliber']").val(data.caliber);
                            $("#editValveModel input[name='ctrl_time']").val(data.ctrl_time);
                        }
                    });
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['450px', '500px'], //宽高
                        content: $('#editValveModel')
                    });

                }else if(layEvent==='click'){
                    if(data.available==0){
                        data.available=1;
                    }else
                        data.available=0;
                    $.ajax({
                        url:"valveModel/editValveModel.do"
                        ,data:data
                        ,dataType:"json"
                        , async:false
                        ,type:"POST"
                        ,success:function (data) {
                            layer.msg("操作成功",{time:1000},function () {
                                window.location.reload();
                            });
                        },
                        error:function (data) {
                            layer.msg("操作失败");
                        }
                    });
                }
            });
        })
    }
</script>
</body>
</html>