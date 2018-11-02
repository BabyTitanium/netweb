<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/8/31
  Time: 14:02
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
    <title>角色管理</title>
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
    <style>
        .layui-table-cell {
            height: auto;
            line-height: 28px;
            padding: 0 15px;
            position: relative;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal;
            box-sizing: border-box;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="header.jsp"/>
    <jsp:include page="left.jsp">
        <jsp:param value="roleSet" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->

        <div class="areachoose">
            <div class="layui-container area-top" style="">
                <blockquote class="layui-elem-quote layui-text">
                    角色管理
                    <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
                </blockquote>
            </div>
        </div>
        <div class="layui-container">
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <i class="layui-icon" style="font-size: 18px;">&#xe60e;</i>数据列表
                <button style="float: right;margin-top: -5px" class="layui-btn layui-btn-primary layui-btn-sm" onclick="addRole()">  添加</button>
            </div>
            <table id="roleList" lay-filter="operation" ></table>
            <script type="text/html" id="switchTpl">
                <a lay-event="changeAdmin">
                  <input type="checkbox"  name="admin" value="{{d.ROLE_ADMIN}}" lay-skin="switch" lay-text="ON|OFF" lay-filter="changeAdmin" {{ d.ROLE_ADMIN ==1 ? 'checked'  : ' ' }}>权限管理<br/>
                </a>
                <a lay-event="changeOper">
                    <input type="checkbox"  name="oper" value="{{d.ROLE_OPER}}" lay-skin="switch" lay-text="ON|OFF" lay-filter="changeOper" {{ d.ROLE_OPER ==1 ? 'checked'  : ' ' }}>控制权限<br/>
                </a>
                <a lay-event="changeUser">
                    <input type="checkbox"  name="user" value="{{d.ROLE_USER}}" lay-skin="switch" lay-text="ON|OFF" lay-filter="changeUser" {{ d.ROLE_USER ==1 ? 'checked'  : ' ' }}>查询权限<br/>
                </a>
                <a lay-event="changeServ">
                    <input type="checkbox"  name="serv" value="{{d.ROLE_SERV}}" lay-skin="switch" lay-text="ON|OFF" lay-filter="changeServ" {{ d.ROLE_SERV ==1 ? 'checked'  : ' ' }}>客服权限</script>
                </a>
            <script type="text/html" id="deal">
            <a class="layui-btn layui-btn-xs" lay-event="permission">权限设置</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑角色</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>

        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>

<form class="layui-form myform" id="addRole" onsubmit="return submitRole();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">角色名称</label>
        <div class="layui-input-block">
            <input type="text" name="role_name" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">角色编码</label>
        <div class="layui-input-block">
            <input type="text" name="role_code" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn" type="submit">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeAddLayer()">取消</button>
    </div>
</form>
<form class="layui-form myform" id="editRole" onsubmit="return submitEditRole();" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="id" hidden>
            <input type="text" name="role_name" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">编码</label>
        <div class="layui-input-block">
            <input type="text" name="role_code" class="layui-input" required>
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
    function finds() {
        layui.use('table', function() {
            var table = layui.table
                ,form = layui.form;
            //第一个实例
            table.render({
                elem: '#roleList'
                , url: 'roleSet/roleList.do?' //数据接口
                , cols: [
                    [ //表头

                        {field: 'role_name', title: '角色名称', minWidth:100}
                        ,{field: 'role_code', title: '角色编码', minWidth:100}
                        ,{field: 'service', title:'是否启用',  width:160, templet: '#switchTpl', unresize: true}
                        ,{field: 'counts', title: '用户数量', minWidth:100}
                        ,{minWidth:100, align: 'center', toolbar: '#deal'} //这里的toolbar值是模板元素的选择器
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
                  if(haveUsers(data.id)){
                      deleteRole(data.id);
                      finds();
                      // layer.confirm("存在此角色的用户，是否确认删除",function (index) {
                      //     deleteRole(data.id);
                      //     layer.close(index);
                      // });
                  }else{
                      layer.msg("已存在此角色用户，不可删除");

                  }
                }else if(layEvent === 'edit'){ //编辑
                    $.ajax({
                        url:'roleSet/getRole.do?id='+data.id,
                        async:false,
                        type:"GET",
                        dataType:'json',
                        success:function (data) {
                            $("#editRole input[name='id']").val(data.id);
                            $("#editRole input[name='role_name']").val(data.role_name);
                            $("#editRole input[name='role_code']").val(data.role_code);
                        },
                        error:function (data) {
                            layer.msg("操作失败");
                        }
                    });
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '280px'], //宽高
                        content: $('#editRole')
                    })
                }else if(layEvent==='permission'){
                    var id=data.id;
                    layer.open({
                        type: 2,
                        area: ['650px', '500px'],
                        content: 'roleSet/permissionTree.do?role_id='+id //这里content是一个普通的String
                    });
                }else if(layEvent==='changeAdmin'){
                    if(data.ROLE_ADMIN==1){
                        deleteRoleService(data.ROLE_ADMIN_rid);
                    }else{
                        addRoleService(data.id,"ROLE_ADMIN");
                    }
                }else if(layEvent==='changeUser'){
                    if(data.ROLE_USER==1){
                        deleteRoleService(data.ROLE_USER_rid);
                    }else{
                        addRoleService(data.id,"ROLE_USER");
                    }
                }else if(layEvent==='changeServ'){
                    if(data.ROLE_SERV==1){
                        deleteRoleService(data.ROLE_SERV_rid);
                    }else{
                        addRoleService(data.id,"ROLE_SERV");
                    }
                }else if(layEvent==='changeOper'){
                    if(data.ROLE_OPER==1){
                        deleteRoleService(data.ROLE_OPER_rid);
                    }else{
                        addRoleService(data.id,"ROLE_OPER");
                    }
                }
            });
        })
    }
    function deleteRoleService(rid) {
        $.ajax({
            url:'roleSet/deleteRoleService.do?id='+rid,
            async:false,
            type:"GET",
            dataType:'json',
            success:function (data) {
                layer.msg("操作成功");
                finds();
            },
            error:function (data) {
                layer.msg("操作失败");
                finds();
            }
        });
    }
    function addRoleService(id,name){
        $.ajax({
            url:'roleSet/addRoleService.do?id='+id+"&name="+name,
            async:false,
            type:"GET",
            dataType:'json',
            success:function (data) {
                layer.msg("操作成功");
                finds();
            },
            error:function (data) {
                layer.msg("操作失败");
                finds();
            }
        });
    }
    function addRole() {
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '280px'], //宽高
            content: $('#addRole')
        })
    }
    function closeAddLayer() {
        $("#addRole input").val("");
        $("#addRole").css("display","none");
        layer.close(index);
    }
    function closeEditLayer() {
        $("#editRole input").val("");
        $("#editRole").css("display","none");
        layer.close(index);
    }
    function submitRole() {
        var roles=$("#addRole").serialize();
        var name=$("#addRole input[name='role_name']").val();
        var code=$("#addRole input[name='role_code']").val();
        if(checkRoleName(null,name)){
            if(checkRoleCode(null,code)){
                $.ajax({
                    url:'roleSet/addRole.do',
                    async:false,
                    data:roles,
                    dataType:'json',
                    type:'GET',
                    success:function (res) {
                        layer.msg("操作成功");
                        closeAddLayer();
                        finds();
                    },
                    error:function (res) {
                        layer.msg("操作失败");
                        closeAddLayer();
                    }
                });
            }else{
                layer.tips('编码已存在', "#addRole input[name='role_code']");
            }
        }else{
            layer.tips('名称已存在', "#addRole input[name='role_name']");
        }
        return false;
    }
    function checkRoleName(id,name){
        var state=false;
        if(id!=null){
            $.ajax({
                url:'roleSet/checkRole.do?id='+id+'&role_name='+name
                ,async:false
                ,dataType:'json'
                ,type:"GET"
                ,success:function (res) {
                    if(res.state=="success"){
                        state=true;
                    }else if(res.state=="error"){
                        state=false;
                    }
                },
                error:function () {
                    layer.msg("操作失败");
                    state=false;
                }
            });
        }else{
            $.ajax({
                url:'roleSet/checkRole.do?role_name='+name
                ,async:false
                ,dataType:'json'
                ,type:"GET"
                ,success:function (res) {
                    if(res.state=="success"){
                        state=true;
                    }else if(res.state=="error"){
                        state=false;
                    }
                },
                error:function () {
                    layer.msg("操作失败");
                    state=false;
                }
            });
        }
        return state;
    }
    function checkRoleCode(id,code) {
        var state=false;
        if(id!=null){
            $.ajax({
                url:'roleSet/checkRole.do?id='+id+'&role_code='+code
                ,async:false
                ,dataType:'json'
                ,type:"GET"
                ,success:function (res) {
                    if(res.state=="success"){
                        state=true;
                    }else if(res.state=="error"){
                        state=false;
                    }
                },
                error:function () {
                    layer.msg("操作失败");
                    state=false;
                }
            });
        }else{
      //      var state=false;
            $.ajax({
                url:'roleSet/checkRole.do?role_code='+code
                ,async:false
                ,dataType:'json'
                ,type:"GET"
                ,success:function (res) {
                    if(res.state=="success"){
                        state=true;
                    }else if(res.state=="error"){
                        state=false;
                    }
                },
                error:function () {
                    layer.msg("操作失败");
                    state=false;
                }
            });
        }
        return state;
    }
    function submitEditRole() {
        var data=$("#editRole").serialize();
        var id=$("#editRole input[name='id']").val();
        var name=$("#editRole input[name='role_name']").val();
        var code=$("#editRole input[name='role_code']").val();
        if(checkRoleName(id,name)){
            if(checkRoleCode(id,code)){
                $.ajax({
                    url:'roleSet/editRole.do',
                    data:data,
                    async:false,
                    dataType:'json',
                    type:'GET',
                    success:function (res) {
                        layer.msg("操作成功")
                        closeEditLayer();
                        finds();
                    },
                    error:function (res) {
                        layer.msg("操作失败");
                        closeEditLayer();
                    }
                })
            }else{
                layer.tips('编码已存在', "#editRole input[name='role_code']");
            }
        }else{
            layer.tips('编码已存在', "#editRole input[name='role_name']");
        }
        return false;
    }
    function haveUsers(role_id) {
        var state=false;
        $.ajax({
            url:'roleSet/getUsersByRole.do',
            async:false,
            data:{role_id:role_id},
            dataType:'json',
            type:'GET',
            success:function (res) {
                console.log(res);
                if(res.state=="success"){
                    state=true;
                }else{
                    state=false;
                }
            },
            error:function () {
                state=false;
            }
        });
        console.log(state);
        return state;
    }
    function deleteRole(role_id){
        $.ajax({
            url:'roleSet/deleteRole.do',
            async:false,
            data:{id:role_id},
            dataType:'json',
            type:'GET',
            success:function (res) {
                layer.msg("操作成功");
            },
            error:function () {
               layer.msg("操作失败");
            }
        });
    }
</script>
</body>
</html>

