package com.ps.net.controller;

import com.ps.net.changeObject.ExcelUntil;
import com.ps.net.changeObject.ExtraBean;
import com.ps.net.changeObject.ExtraMethod;
import com.ps.net.dao.*;
import com.ps.net.model.Zones;
import com.ps.net.service.ZoneBuildingService;
import com.ps.net.service.ZoneRoomMeterService;
import com.ps.net.service.ZoneRoomService;
import com.ps.net.service.ZoneRoomValveService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("sysIndex")
public class ZoneMeterController {
    @Autowired
    private ZoneRoomService zoneRoomService;
    @Autowired
    private RoomLocationMapper roomLocationMapper;
    @Autowired
    private CustomTypeMapper customTypeMapper;
    @Autowired
    private HeatTypeMapper heatTypeMapper;
    @Autowired
    private BuildsMapper buildsMapper;
    @Autowired
    private ZonesMapper zonesMapper;
    @Autowired
    private ZoneBuildingService zoneBuildingService;
    @Autowired
    private ZoneRoomMeterService zoneRoomMeterService;
    @Autowired
    private ZoneRoomValveService zoneRoomValveService;
    @RequestMapping(value = "roomMeterList")
    @RequiresPermissions("sysIndex")
    public @ResponseBody
    Map<String,Object> roomMeterList(@RequestParam Map map){
        try {
            List<Map<String,Object>> list=zoneRoomMeterService.getRoomMeterList(map);
            for(int i=0;i<list.size();i++){
                Map<String,Object> roomMeter=list.get(i);
                String battery_status=String.valueOf(roomMeter.get("battery_status"));
                if(battery_status.equals("0")){
                    roomMeter.put("battery_status","正常");
                }else if(battery_status.equals("1")){
                    roomMeter.put("battery_status","欠压");
                }
                //房间号
                String b_num = String.valueOf(roomMeter.get("b_num"));
                String u_num = String.valueOf(roomMeter.get("u_num"));
                String r_num = String.valueOf(roomMeter.get("r_num"));
                String rnum = b_num + "-" + u_num + "-" + r_num;
                roomMeter.put("r_num", rnum);

            }
            Integer count=zoneRoomMeterService.getRoomMeterListCount(map);
            return ExtraMethod.returnList(list,count);
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "downloadRoomMeterTemplate")
    @RequiresPermissions("sysIndex")
    public void downloadRoomMeterTemplate(HttpServletResponse response, HttpServletRequest request) throws Exception{
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        String path = request.getServletContext().getRealPath("/WEB-INF/templates");
        path+="/房间热量表信息导入模板.xlsx";

        File file=new File(path);
        //获取文件的长度
        long fileLength = file.length();

        //设置文件输出类型
        response.setContentType("application/octet-stream");
        response.setHeader("Content-disposition", "attachment; filename="
                + new String(file.getName().getBytes("utf-8"), "ISO8859-1"));
        //设置输出长度
        response.setHeader("Content-Length", String.valueOf(fileLength));
        //获取输入流
        bis = new BufferedInputStream(new FileInputStream(path));
        //输出流
        bos = new BufferedOutputStream(response.getOutputStream());
        byte[] buff = new byte[2048];
        int bytesRead;
        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
            bos.write(buff, 0, bytesRead);
        }
        //关闭流
        bis.close();
        bos.close();
    }
    @RequestMapping(value = "importRoomMeter")
    @RequiresPermissions("sysIndex")
//    @Transactional(rollbackFor = Exception.class)
    public @ResponseBody Map<String,Object> importRoomMeter(@RequestParam("file") MultipartFile multfile, Integer zone_id){
        Map<String,Object> result=new HashMap<>();
        List<Map<String, Object>> list=null;
        int updates=0;
        int inserts=0;
        try {
            list= ExcelUntil.changeToMap(multfile, ExtraBean.importRoomMeter.roomMeterType, ExtraBean.importRoomMeter.roomMeterName);
        }catch (Exception e) {
            result.put("message", "数据处理异常");
            return result;
        }
        try {
            //分解楼栋房间号
            for(int k=0;k<list.size();k++) {
                Map<String, Object> map = list.get(k);
                map = ExtraMethod.setNull(map);
                String room = String.valueOf(map.get("room_num"));
                String[] names = ExtraMethod.changeRoomNum(room);
                Integer build = Integer.parseInt(names[0]);
                Map<String, Object> condition1 = new HashMap<>();
                condition1.put("zone_id", zone_id);
                condition1.put("build_num", build);
                //根据小区id跟楼号id找出楼id
                Map<String, Object> builds = zoneBuildingService.checkBuilding(condition1);
                if (builds != null) {
                    Integer build_id = Integer.parseInt(String.valueOf(builds.get("id")));
                    Map<String, Object> condition2 = new HashMap<>();
                    Integer unit = Integer.parseInt(names[1]);
                    condition2.put("build_id", build_id);
                    condition2.put("unit_num", unit);
                    //根据楼号id跟单元号找出单元id
                    Map<String, Object> units = zoneRoomService.checkUnit(condition2);
                    if (units != null) {
                        Map<String, Object> condition3 = new HashMap<>();
                        condition3.put("unit_id", units.get("id"));
                        condition3.put("room_num", names[2]);
                        Map<String, Object> roomInfo = zoneRoomService.checkRoom(condition3);
                        if (roomInfo != null) {
                            map.put("room_id",roomInfo.get("id"));
                        }
                    }
                }
            }
        }catch (Exception e) {
            result.put("message","含有不规范数据");
            return result;
        }
        try{
            //批量导入
            for (int k=0;k<list.size();k++){
                Map<String,Object> r=list.get(k);
                //
                Integer room_id=Integer.parseInt(String.valueOf(r.get("room_id")));
                Map<String,Object> roomMeterAddr=zoneRoomMeterService.getRoomMeterAddr(room_id);
                if (roomMeterAddr != null) {
                    zoneRoomMeterService.updateRoomMeter(r);
                    updates++;
                }else{
                    zoneRoomMeterService.addRoomMeter(r);
                    inserts++;
                }
            }
            result.put("code",0);
            result.put("message","导入成功！");
            result.put("updates",updates);
            result.put("inserts",inserts);
            return result;
        }catch (Exception e) {
            result.put("code",0);
            result.put("message","导入时发生异常！");
            result.put("updates",updates);
            result.put("inserts",inserts);
            return result;
        }
    }

    @RequestMapping(value = "exportRoomMeter")
    @RequiresPermissions("sysIndex")
    public void exportRoomMeter(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception{
        map.put("page",null);
        map.put("limit",null);
        map=ExtraMethod.setNull(map);
        String zone_name="";
        if(map.get("zone_id")!=null&&map.containsKey("zone_id")){
            Integer zid=Integer.parseInt(String.valueOf(map.get("zone_id")));
            Zones zones=zonesMapper.selectZones(zid);
            zone_name=zones.getZ_name();
        }
        List<Map<String,Object>> list=zoneRoomMeterService.getRoomMeterList(map);
        for(int i=0;i<list.size();i++){
            Map<String,Object> roomMeter=list.get(i);
            String battery_status=String.valueOf(roomMeter.get("battery_status"));
            if(battery_status.equals("0")){
                roomMeter.put("battery_status","正常");
            }else if(battery_status.equals("1")){
                roomMeter.put("battery_status","欠压");
            }
            String b_num = String.valueOf(roomMeter.get("b_num"));
            String u_num = String.valueOf(roomMeter.get("u_num"));
            String r_num = String.valueOf(roomMeter.get("r_num"));
            String room_num = b_num + "-" + u_num + "-" + r_num;
            roomMeter.put("room_num", room_num);
        }
        HSSFWorkbook wb=ExcelUntil.getExcel("表具信息",ExtraBean.exportRoomMeter.roomMeterName,ExtraBean.exportRoomMeter.roomMeterType,list);
        String fileName = "Excel-" +zone_name+"热量表信息";
        String headStr ="attachment;filename=\""+ new String( fileName.getBytes( "gb2312" ), "ISO8859-1" )+ ".xls" + "\"";
        //    mResponse.setHeader( "Content-Disposition", "attachment;filename=\""+ new String( fileName.getBytes( "gb2312" ), "ISO8859-1" )+ ".xls" + "\"" );
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", headStr);
        response.setCharacterEncoding("utf-8");
        OutputStream out = response.getOutputStream();
        wb.write(out);
    }
    @RequestMapping(value = "allRoomMeter")
    @RequiresPermissions("sysIndex")
    public @ResponseBody List<Map<String,Object>> allRoomMeter(@RequestParam Map<String,Object> condition){
        try{
            List<Map<String,Object>> list=zoneRoomMeterService.getAllRoomMeter(condition);
            for(int i=0;i<list.size();i++){
                Map<String,Object> roomMeter=list.get(i);
                String battery_status=String.valueOf(roomMeter.get("battery_status"));
                if(battery_status.equals("0")){
                    roomMeter.put("battery_status","正常");
                }else if(battery_status.equals("1")){
                    roomMeter.put("battery_status","欠压");
                }
                String b_num = String.valueOf(roomMeter.get("b_num"));
                String u_num = String.valueOf(roomMeter.get("u_num"));
                String r_num = String.valueOf(roomMeter.get("r_num"));
                String room_num = b_num + "-" + u_num + "-" + r_num;
                roomMeter.put("r_num", room_num);
                //数据时间
                if(roomMeter.get("data_time")!=null&&!String.valueOf(roomMeter.get("data_time")).equals("-")){
                    String d=String.valueOf(roomMeter.get("data_time"));
                    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String date=simpleDateFormat.format(simpleDateFormat.parse(d));
                    roomMeter.put("data_time",date);
                }
            }
            return list;
        }catch (Exception e){
            return null;
        }
    }

    @RequestMapping(value = "getMeterCount")
    @RequiresPermissions("sysIndex")
    public @ResponseBody Map<String,Object> getMeterCount(@RequestParam Map<String,Object> m){
        try {
            Integer all=zoneRoomMeterService.getRoomMeterListCount(m);
            Integer online=zoneRoomMeterService.getOnlineMeterCount(m);
            Integer offline=zoneRoomMeterService.getOfflineMeterCount(m);
            Map<String,Object> map=new HashMap<>();
            map.put("all",all);
            map.put("online",online);
            map.put("offline",offline);
            return  map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping("roomMeterInfoPage")
    @RequiresPermissions("sysIndex")
    public String index(Integer id, ModelMap map){
        map.addAttribute("id",id);
        return "zoneMeter";
    }
}
