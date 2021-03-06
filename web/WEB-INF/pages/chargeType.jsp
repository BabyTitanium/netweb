<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/26
  Time: 15:55
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
    <title>收费方式管理</title>
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
        <jsp:param value="chargeType" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="areachoose">
            <div class="layui-container area-top" style="">
                <blockquote class="layui-elem-quote layui-text">
                    收费方式管理
                    <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
                </blockquote>
            </div>
        </div>
        <div class="layui-container">
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <i class="layui-icon" style="font-size: 18px;">&#xe60e;</i>数据列表
                <button style="float: right;margin-top: -5px" class="layui-btn layui-btn-primary layui-btn-sm" onclick="addChargeType()">  添加</button>
            </div>
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <form class="layui-form">
                    <div class="layui-inline">
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="name" type="text" name="name">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">编码</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="code" type="text" name="code">
                        </div>
                    </div>
                    <div class="layui-inline" style="padding-left: 30px">
                        <button id="find" type="button" onclick="finds()" class="layui-btn layui-btn-primary" >搜索</button>
                    </div>
                </form>
            </div>
            <table id="chargeTypeList" lay-filter="operation" ></table>
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
<form class="layui-form myform" id="addChargeType" onsubmit="return submitChargeType();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" class="layui-input"  required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">编码</label>
        <div class="layui-input-block">
            <input type="text" name="code" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeAddLayer()">取消</button>
    </div>
</form>
<form class="layui-form myform" id="editChargeType" onsubmit="return editChargeType();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="id" hidden>
            <input type="text" name="name" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">编码</label>
        <div class="layui-input-block">
            <input type="text" name="code" class="layui-input" required>
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
        $("#addChargeType").css("display","none");
        $("#addChargeType input[name='id']").val("");
        $("#addChargeType input[name='name']").val("");
        $("#addChargeType input[name='code']").val("");
        layer.close(index);
    }
    function addChargeType() {
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '240px'], //宽高
            content: $('#addChargeType')
        });
    }
    function submitChargeType() {
        var ChargeType=$("#addChargeType").serialize();
        var id=$("#addChargeType input[name='id']").val();
        var name=$("#addChargeType input[name='name']").val();
        var code=$("#addChargeType input[name='code']").val();
        var namecheck=nameCheck(id,name);
        var codecheck=codeCheck(id,code);
        if(!namecheck){
            layer.tips('名称已存在', "#addChargeType input[name='name']");
        }
        else if(!codecheck){
            layer.tips('编码已存在', "#addChargeType input[name='code']");
        }
        else if(namecheck&&codecheck){
            $.ajax({
                type:"POST",
                dataType:"json",
                data:ChargeType,
                url:"chargeType/addChargeType.do",
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
    function  nameCheck(id,name) {
        var state=true;
        $.ajax({
            type:"GET",
            dataType:"json",
            data:{id:id,name:name},
            url:"chargeType/chargeTypeNameCheck.do",
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
    function  codeCheck(id,code) {
        var state=true;
        $.ajax({
            type:"GET",
            dataType:"json",
            data:{id:id,code:code},
            url:"chargeType/chargeTypeCodeCheck.do",
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
        $("#editChargeType").css("display","none");
        layer.close(index);
    }
    function editChargeType() {
        var ChargeType=$("#editChargeType").serialize();
        var id=$("#editChargeType input[name='id']").val();
        var name=$("#editChargeType input[name='name']").val();
        var code=$("#editChargeType input[name='code']").val();

        var namecheck=nameCheck(id,name);
        var codecheck=codeCheck(id,code);
        if(!namecheck){
            layer.tips('名称已存在', "#editChargeType input[name='name']");
        }
        else if(!codecheck){
            layer.tips('编码已存在', "#editChargeType input[name='code']");
        }
        else if(namecheck&&codecheck){
            $.ajax({
                type:"POST",
                dataType:"json",
                data:ChargeType,
                url:"chargeType/editChargeType.do",
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
        var name=$("#name").val();
        var code=$("#code").val();
        layui.use('table', function() {
            var table = layui.table
                ,form = layui.form;
            //第一个实例
            table.render({
                elem: '#chargeTypeList'
                , url: 'chargeType/chargeTypeList.do?code='+code+'&name='+name //数据接口
                , cols: [
                    [ //表头
                        {field: 'name', title: '名称', minWidth: 100,maxWidth:250}
                        , {field: 'code', title: '编码', minWidth: 100,maxWidth:250}
                        ,{field: 'available', title:'是否启用', minWidth:100 ,maxWidth:250,templet: '#switchTpl', unresize: true}
                        , {minWidth: 100,maxWidth:250, align: 'center', toolbar: '#deal'} //这里的toolbar值是模板元素的选择器
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
                                url:"chargeType/deleteChargeType.do",
                                async:false,
                                success:function (data) {
                                    layer.msg("操作成功");
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                }
                            });
                        });


                } else if(layEvent === 'edit'){ //编辑
                    $("#editChargeType input[name='id']").val("");
                    $("#editChargeType input[name='name']").val("");
                    $("#editChargeType input[name='code']").val("");
                    var id=data.id;
                    $.ajax({
                        dataType:"json",
                        data:{id:id},
                        url:"chargeType/getChargeType.do",
                        async:false,
                        success:function (data) {
                            $("#editChargeType input[name='id']").val(data.id);
                            $("#editChargeType input[name='name']").val(data.name);
                            $("#editChargeType input[name='code']").val(data.code);
                        }
                    });
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '240px'], //宽高
                        content: $('#editChargeType')
                    });

                }else if(layEvent==='click'){
                    if(data.available==0){
                        data.available=1;
                    }else
                        data.available=0;
                    $.ajax({
                        url:"chargeType/editChargeType.do"
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

