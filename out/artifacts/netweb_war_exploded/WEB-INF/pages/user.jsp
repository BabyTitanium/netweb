<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/9/4
  Time: 15:18
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
    <title>用户管理</title>
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
        <jsp:param value="userSet" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->

        <div class="areachoose">
            <div class="layui-container area-top" style="">
                <blockquote class="layui-elem-quote layui-text">
                    用户管理
                    <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
                </blockquote>
            </div>
        </div>
        <div class="layui-container">
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <i class="layui-icon" style="font-size: 18px;">&#xe60e;</i>数据列表
                <button style="float: right;margin-top: -5px" class="layui-btn layui-btn-primary layui-btn-sm" onclick="addUser()">  添加</button>
            </div>
            <table id="userList" lay-filter="operation" ></table>
            <script type="text/html" id="deal">
                <a class="layui-btn layui-btn-xs" lay-event="setStation">设置区域权限</a>
                <a class="layui-btn layui-btn-xs" lay-event="editUser">修改用户</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delUser">删除用户</a>
            </script>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>

<form class="layui-form myform" id="addUser" onsubmit="return submitUser();" style="padding: 10px;display: none" lay-filter="selFilter">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="user_name" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="password" name="user_passwd" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">真实姓名</label>
        <div class="layui-input-block">
            <input type="text" name="real_name"  class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">电子邮件</label>
        <div class="layui-input-block">
            <input type="text" name="email" lay-verify="email|required"  class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">电话</label>
        <div class="layui-input-block">
            <input type="text" name="phone" lay-verify="number|required" class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">角色</label>
        <div class="layui-input-block">
            <select name="role_id" id="choseRole" >
             
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button  class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="closeAddLayer()">取消</button>
    </div>
</form>
<form class="layui-form myform" id="editUser" onsubmit="return submitEditUser();" lay-filter="selFilter1" style="padding: 10px;display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="id"  hidden>
            <input type="text" name="user_name" class="layui-input" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="password" name="user_passwd" class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">真实姓名</label>
        <div class="layui-input-block">
            <input type="text" name="real_name"  class="layui-input" required>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">电子邮件</label>
        <div class="layui-input-block">
            <input type="text" name="email" lay-verify="email|required"  class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">电话</label>
        <div class="layui-input-block">
            <input type="text" name="phone" lay-verify="number|required" class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">角色</label>
        <div class="layui-input-block">
            <select name="role_id" id="choseRole1" >

            </select>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button  class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
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
                elem: '#userList'
                , url: 'userSet/userList.do?' //数据接口
                , cols: [
                    [ //表头
                        {field: 'user_name', title: '用户名', minWidth:80}
                        ,{field: 'user_passwd', title: '密码', minWidth:80}
                        ,{field: 'real_name', title:'用户姓名',  minWidth:80, templet: '#switchTpl'}
                        ,{field: 'email', title: '用户邮箱', minWidth:100}
                        ,{field: 'phone', title: '联系电话', minWidth:100}
                        ,{field: 'role_name', title: '用户角色', minWidth:80}
                        ,{field: 'stationNames', title: '区域权限', minWidth:100}
                        ,{minWidth:100, align: 'center', toolbar: '#deal'} //这里的toolbar值是模板元素的选择器
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                , id: 'userList'

            });
            //监听工具条
            table.on('tool(operation)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象

                if(layEvent === 'setStation'){ //
                    index=layer.open({
                        type: 2,
                        area: ['650px', '500px'],
                        content: 'userSet/areaPermission.do?user_id='+data.id, //这里content是一个普通的String

                    });

                }else if(layEvent === 'editUser'){ //编辑
                    getUserInfo(data.id);
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '480px'], //宽高
                        content: $('#editUser')
                    });
                }else if(layEvent==='delUser'){  //删除用户
                    layer.confirm('确定删除吗？', function(index){
                        $.ajax({
                            url:'userSet/deleteUsers.do',
                            data:{id:data.id},
                            async:false,
                            dataType:'json',
                            type:'GET',
                            success:function (obj) {
                                layer.msg("操作成功");
                                layui.use('table', function() {
                                    var table = layui.table
                                        , form = layui.form;
                                    table.reload("userList");
                                })
                            },
                            error:function () {
                                layer.msg("操作失败");
                            }
                        })
                    })

                }
            });

            //监听提交
            form.on('submit(sel)', function(data){
                layer.msg(JSON.stringify(data.field));
                return false;
            });
        })
    }

    function addUser() {
        $.ajax({
            url:'userSet/roleList.do',
            async:false,
            dataType:'json',
            type:'GET',
            success:function (res) {
                var html="   <option value=''>请选择</option>";
                $(res.data).each(function (index) {
                    var m=res.data[index];
                    html+="<option value='"+m.id+"'>"+m.role_name+"</option>";
                })
                $("#choseRole").html(html);
            }
        });
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            form.render("select","selFilter");
        })
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '480px'], //宽高
            content: $('#addUser')
        })
    }
    function closeAddLayer() {
        layer.close(index);
        $("#addUser").css("display","none");
        $("#addUser input").val("");
    }
    function submitUser() {
        var user_name=$("#addUser input[name='user_name']").val();
        var users=$("#addUser").serialize();
        if(checkUsername(user_name)){
            $.ajax({
                url:'userSet/addUser.do',
                data:users,
                async:false,
                dataType:'json',
                type:'POST',
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
            layer.tips("用户名已存在","#addUser input[name='user_name']");
        }
        return false;
    }
    function checkUsername(user_name) {
        var state=false;
        $.ajax({
            url:'userSet/checkUsername.do',
            async:false,
            data:{user_name,user_name},
            dataType:'json',
            type:'GET',
            success:function (res) {
               if(res.state=="success"){
                   state=true;
               } else if(res.state=="error"){
                   state=false;
               }
            },
            error:function () {
                state=false;
            }
        });
        return state;
    }
    
    function getUserInfo(id) {
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            $.ajax({
                url:'userSet/roleList.do',
                async:false,
                dataType:'json',
                type:'GET',
                success:function (res) {
                    var html="   <option value=''>请选择</option>";
                    $(res.data).each(function (index) {
                        var m=res.data[index];
                        html+="<option value='"+m.id+"'>"+m.role_name+"</option>";
                    })
                    $("#choseRole1").html(html);
                }
            });

            $.ajax({
                url:'userSet/getUserInfo.do',
                data:{id:id},
                async:false,
                dataType:'json',
                type:'GET',
                success:function (obj) {
                    Object.keys(obj).forEach(function(key){
                        //console.log(key,obj[key]);
                        $("#editUser input[name='"+key+"']").val(obj[key]);
                    });
                    $("#choseRole1").val(obj.role_id);

                }
            })
            form.render("select","selFilter1");
        })

    }
    function closeEditLayer() {
        layer.close(index);
        $("#editUser").css("display","none");
        $("#editUser input").val("");
    }

    function submitEditUser() {
        var users=$("#editUser").serialize();
        $.ajax({
            url:'userSet/editUsers.do',
            data:users,
            async:false,
            dataType:'json',
            type:'GET',
            success:function (obj) {
                layer.msg("操作成功");
                closeEditLayer();
                layui.use('table', function() {
                    var table = layui.table
                        , form = layui.form;
                    table.reload("userList");
                })
            }
        })
        return false;
    }
</script>
</body>
</html>


