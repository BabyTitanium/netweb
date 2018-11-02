<%--
  Created by IntelliJ IDEA.
  User: 天逸
  Date: 2018/7/9
  Time: 9:03
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
    <title>基站管理</title>
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
        <jsp:param value="device" name="type"/>
    </jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->


        <div class="areachoose">
            <div class="layui-container area-top" style="">
                <blockquote class="layui-elem-quote layui-text">
                   基站管理
                    <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location.reload()"><i class="layui-icon ">&#xe669;</i>  刷新</button>
                </blockquote>
            </div>
        </div>
        <div class="layui-container">
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <i class="layui-icon" style="font-size: 18px;">&#xe60e;</i>数据列表
                <button style="float: right;margin-top: -5px" class="layui-btn layui-btn-primary layui-btn-sm" onclick="addDevice()">  添加</button>
            </div>
            <div class="areachoose" style="margin-top: 20px;padding: 15px; ">
                <div id="deviceButton">
                    <button class='layui-btn layui-btn-sm btns' id="allDeviceCount"  onclick='allDevice()'>全部<span></span></button>
                    <button class='layui-btn layui-btn-sm layui-btn-primary btns'  id="onlineDeviceCount" onclick='onlineDevice()'>在线<span></span></button>
                    <button class='layui-btn layui-btn-sm layui-btn-primary btns' id="offlineDeviceCount"  onclick='offlineDevice()'>离线<span></span></button>

                            <div class="layui-inline">
                                <label class="layui-form-label">网络号</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input " id="netNum" type="text" name="device_net">
                                </div>
                            </div>
                            <div class="layui-inline" style="padding-left: 30px">
                                <button id="search" type="button" onclick="search()" class="layui-btn layui-btn-sm layui-btn-primary" >搜索</button>
                            </div>

                </div>
            </div>
            <table id="deviceList" lay-filter="operation4" ></table>
            <script type="text/html" id="dealE">
                <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>


        </div>


    </div>
    <jsp:include page="footer.jsp"/>
</div>
<form id="addDevice" class="layui-form" hidden onsubmit="return addDeviceInfo();"  style="padding: 10px;display: none"  lay-filter="selFilter7">
    <div class="layui-form-item">
        <label class="layui-form-label">基站网络号</label>
        <div class="layui-input-block" >
            <input type="text" name="device_net" id="device_net" class="layui-input"  required   >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备类型</label>
        <div class="layui-input-block">
            <select name="device_type" >
                <option value="" > 请选择</option>
                <option value="0" > 网络基站</option>
                <option value="1" > 集抄器</option>
                <%--<option value="2" > Lora基站</option>--%>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">安装位置</label>
        <div class="layui-input-block" >
            <input type="text" name="location" class="layui-input"  required   >
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn layui-btn-sm"  type="submit" >确定</button>
        <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeAddDeviceLayer()">取消</button>
    </div>
</form>
<form id="editDevice" class="layui-form" hidden onsubmit="return editDeviceInfo();"  style="padding: 10px;display: none"  lay-filter="selFilter8">
    <div class="layui-form-item">
        <label class="layui-form-label">基站网络号</label>
        <div class="layui-input-block" >
            <input type="text" name="device_net" class="layui-input"  required  readonly >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备类型</label>
        <div class="layui-input-block">
            <select name="device_type" id="device_type" >
                <option value="" > 请选择</option>
                <option value="0" > 网络基站</option>
                <option value="1" > 集抄器</option>
                <%--<option value="2" > Lora基站</option>--%>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">安装位置</label>
        <div class="layui-input-block" >
            <input type="text" name="location" class="layui-input"  required   >
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center" >
        <button class="layui-btn layui-btn-sm"  type="submit" >确定</button>
        <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" onclick="closeEditDeviceLayer()">取消</button>
    </div>
</form>
<script type="text/javascript" src="layui/layui.all.js"></script>
<script type="text/javascript">
    var index;
    var isOnline="all";
    var tableIns ;
    deviceInfo();
    function deviceInfo() {
        $.ajax({
            url:"device/getDeviceCount.do",
            async:'false',
            dataType:'json',
            type:'GET',
            success:function (res) {
                $("#allDeviceCount span ").html("("+res.all+")");
                $("#onlineDeviceCount span ").html("("+res.online+")");
                $("#offlineDeviceCount span ").html("("+res.offline+")");
            }
        })
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#deviceList'
                , url: 'device/deviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号',width:150,maxWidth:200}
                        , {field: 'location', title: '基站安装位置',width:200,maxWidth:200}
                        , {field: 'device_ip', title: '基站IP',width:200,maxWidth:200}
                        , {field: 'device_port', title: '基站端口号',width:200,maxWidth:200}
                        , {field: 'heart_time', title: '心跳包时间',width:200,maxWidth:200}
                        ,{maxWidth:300, minWidth:150,title:'操作',align: 'center', toolbar: '#dealE'}

                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
            });
            //监听锁定操作
            table.on('tool(operation4)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if(layEvent==='edit'){
                    var device_net=data.device_net;
                    getDeviceInfo(device_net);
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    } );
                }else if(layEvent==='del') {
                    layer.confirm('确定删除吗？', function (index) {
                        deleteDevice(data.device_net);
                    })
                }
            });
        })
    }
    function closeEditDeviceLayer() {
        $("#editDevice").css("display","none");
        $("#editDevice input").val("");
        layer.close(index);
    }
    function getDeviceInfo(device_net) {
        $.ajax({
            url:'device/getDeviceInfo.do?device_net='+device_net
            ,dataType:'json'
            ,async:false
            ,type:'GET'
            ,success:function (res) {
                $("#editDevice input[name='device_net']").val(res.device_net);
                $("#editDevice input[name='location']").val(res.location);
                $("#device_type").val(res.device_type);
                layui.use('table', function() {
                    var table = layui.table
                        , form = layui.form;
                    form.render("select", "selFilter8");
                });
            }
        });
    }
    function addDevice() {
        index=layer.open({
            type: 1,
            closeBtn: 0,
            skin: 'layui-layer-rim', //加上边框
            area: ['350px', '300px'], //宽高
            content: $('#addDevice')
        });
    }
    function checkDeviceNet(device_net){
        var state=true;
        $.ajax({
            type:"GET",
            dataType:"json",
            data:{device_net:device_net},
            url:"device/checkDeviceNet.do",
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
    function closeAddDeviceLayer() {
        $("#addDevice").css("display","none");
        $("#addDevice input").val("");
        layer.close(index);
    }
    function addDeviceInfo() {
        var device = $("#addDevice").serialize();
        var device_net = $("#device_net").val();
        console.log(1);
        if (checkDeviceNet(device_net)) {
            $.ajax({
                url: 'device/addDeviceInfo.do',
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
        var device=$("#editDevice").serialize();
        $.ajax({
            url:'device/editDevice.do',
            data:device,
            dataType:'json',
            type:'POST',
            async:false,
            success:function (res) {
                layer.msg("操作成功");
                closeEditDeviceLayer();
                deviceInfo();
            },
            error:function () {
                layer.msg("操作失败");
            }

        });
        return false;
    }
    function allDevice() {
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            table.render({
                elem: '#deviceList'
                , url: 'device/deviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号',width:150,maxWidth:200}
                        , {field: 'location', title: '基站安装位置',width:200,maxWidth:200}
                        , {field: 'device_ip', title: '基站IP',width:200,maxWidth:200}
                        , {field: 'device_port', title: '基站端口号',width:200,maxWidth:200}
                        , {field: 'heart_time', title: '心跳包时间',width:200,maxWidth:200}
                        ,{maxWidth:300, minWidth:150,title:'操作',align: 'center', toolbar: '#dealE'}

                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                ,id:'deviceList'
            });
            //监听锁定操作
            table.on('tool(operation4)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if(layEvent==='edit'){
                    var device_net=data.device_net;
                    getDeviceInfo(device_net);
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    } );
                }else if(layEvent==='del'){
                    layer.confirm('确定删除吗？', function(index){
                        deleteDevice(data.device_net);
                    })
                }
            });
        })
    }
    $("#deviceButton .btns").on("click",function () {
        $("#deviceButton .btns").addClass("layui-btn-primary");
        $(this).removeClass("layui-btn-primary");
    })
    function onlineDevice() {
        isOnline="online";
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            tableIns= table.render({
                elem: '#deviceList'
                , url: 'device/onlineDeviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号',width:150,maxWidth:200}
                        , {field: 'location', title: '基站安装位置',width:200,maxWidth:200}
                        , {field: 'device_ip', title: '基站IP',width:200,maxWidth:200}
                        , {field: 'device_port', title: '基站端口号',width:200,maxWidth:200}
                        , {field: 'heart_time', title: '心跳包时间',width:200,maxWidth:200}
                        ,{maxWidth:300, minWidth:150,title:'操作',align: 'center', toolbar: '#dealE'}

                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                ,id:'deviceList'
            });
            //监听锁定操作
            table.on('tool(operation4)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if(layEvent==='edit'){
                    var device_net=data.device_net;
                    getDeviceInfo(device_net);
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    } );
                }else if(layEvent==='del'){
                    layer.confirm('确定删除吗？', function(index){
                        deleteDevice(data.device_net);
                    })
                }
            });
        })
    }
    function offlineDevice() {
        isOnline="offline";
        layui.use('table', function() {
            var table = layui.table
                , form = layui.form;
            tableIns=  table.render({
                elem: '#deviceList'
                , url: 'device/offlineDeviceList.do'
                , cols: [
                    [ //表头
                        {field: 'device_net', title: '基站网络号',width:150,maxWidth:200}
                        , {field: 'location', title: '基站安装位置',width:200,maxWidth:200}
                        , {field: 'device_ip', title: '基站IP',width:200,maxWidth:200}
                        , {field: 'device_port', title: '基站端口号',width:200,maxWidth:200}
                        , {field: 'heart_time', title: '心跳包时间',width:200,maxWidth:200}
                        ,{maxWidth:300, minWidth:150,title:'操作',align: 'center', toolbar: '#dealE'}
                        // ,{maxWidth:300, minWidth:220,title:'操作',align: 'center', toolbar: '#dealD'}
                    ]
                ]
                , skin: 'row' //表格风格
                , even: true
                , page: true //是否显示分页
                , limit: 10
                , id:'deviceList'
            });
            //监听锁定操作
            table.on('tool(operation4)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                if(layEvent==='edit'){
                    var device_net=data.device_net;
                    getDeviceInfo(device_net);
                    index=layer.open({
                        type: 1,
                        closeBtn: 0,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['350px', '300px'], //宽高
                        content: $('#editDevice')
                    } );
                }else if(layEvent==='del'){
                    layer.confirm('确定删除吗？', function(index){
                        deleteDevice(data.device_net);
                    })
                    ;

                }
            });
        })
    }
    function deleteDevice(device_net) {
        $.ajax({
            url:'device/deleteDevice.do',
            type:"GET",
            dataType:'json',
            async:false,
            data:{device_net:device_net},
            success:function (result) {
                layer.msg("操作成功！");
                deviceInfo();
            },
            error:function () {
                layer.msg("操作失败");
            }
        })
    }


    function  search() {
      var device_net=$("#netNum").val();

         if(isOnline=="online"){
          layui.use('table', function() {
              var table = layui.table
                  , form = layui.form;
              table.reload('deviceList', {
                  url: 'device/onlineDeviceList.do'
                  ,where: {
                      device_net: device_net
                  } //设定异步数据接口的额外参数
                  //,height: 300
              });
          });
      }else if(isOnline=="offline"){
          layui.use('table', function() {
              var table = layui.table
                  , form = layui.form;
              table.reload('deviceList', {
                  url: 'device/offlineDeviceList.do'
                  ,where: {
                      device_net: device_net
                  } //设定异步数据接口的额外参数
                  //,height: 300
              });
          });
      }else{
          layui.use('table', function() {
              var table = layui.table
                  , form = layui.form;
              table.reload('deviceList', {
                  url: 'device/deviceList.do'
                  ,where: {
                      device_net: device_net
                  } //设定异步数据接口的额外参数
                  //,height: 300
              });
          });
      }

    }
</script>
</body>
</html>
