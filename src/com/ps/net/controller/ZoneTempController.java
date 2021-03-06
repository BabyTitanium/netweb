package com.ps.net.controller;

import com.ps.net.changeObject.ExcelUntil;
import com.ps.net.changeObject.ExtraBean;
import com.ps.net.changeObject.ExtraMethod;
import com.ps.net.dao.ZonesMapper;
import com.ps.net.model.Zones;
import com.ps.net.service.ZoneBuildingService;
import com.ps.net.service.ZoneRoomService;
import com.ps.net.service.ZoneRoomTempService;
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
public class ZoneTempController {
    @Autowired
    private ZoneRoomService zoneRoomService;
    @Autowired
    private ZonesMapper zonesMapper;
    @Autowired
    private ZoneBuildingService zoneBuildingService;
    @Autowired
    private ZoneRoomTempService zoneRoomTempService;
    @RequestMapping(value = "roomTempList")
    @RequiresPermissions("sysIndex")
    public @ResponseBody
    Map<String,Object> roomTempList(@RequestParam Map map){
        try {
            List<Map<String,Object>> list=zoneRoomTempService.getRoomTempList(map);
            for(int i=0;i<list.size();i++){
                Map<String,Object> roomTemp=list.get(i);
                String fixture=String.valueOf(roomTemp.get("fixture"));
                if(fixture.equals("0")){
                    roomTemp.put("fixture","固定状态");
                }else if(fixture.equals("1")){
                    roomTemp.put("fixture","移动状态");
                }
                //房间号
                String b_num = String.valueOf(roomTemp.get("b_num"));
                String u_num = String.valueOf(roomTemp.get("u_num"));
                String r_num = String.valueOf(roomTemp.get("r_num"));
                String rnum = b_num + "-" + u_num + "-" + r_num;
                roomTemp.put("r_num", rnum);
            }
            Integer count=zoneRoomTempService.getRoomTempListCount(map);
            return ExtraMethod.returnList(list,count);
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "downloadRoomTempTemplate")
    @RequiresPermissions("sysIndex")
    public void downloadRoomTempTemplate(HttpServletResponse response, HttpServletRequest request) throws Exception{
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        String path = request.getServletContext().getRealPath("/WEB-INF/templates");
        path+="/测温节点信息导入模板.xlsx";

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
    @RequestMapping(value = "importRoomTemp")
    @RequiresPermissions("sysIndex")
    public @ResponseBody Map<String,Object> importRoomTemp(@RequestParam("file") MultipartFile multfile, Integer zone_id){
        Map<String,Object> result=new HashMap<>();
        List<Map<String, Object>> list=null;
        int updates=0;
        int inserts=0;
        try {
            list= ExcelUntil.changeToMap(multfile, ExtraBean.importRoomTemp.roomTempType, ExtraBean.importRoomTemp.roomTempName);
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
                Map<String,Object> roomTempAddr=zoneRoomTempService.getRoomTempAddr(room_id);
                if (roomTempAddr != null) {
                    zoneRoomTempService.updateRoomTemp(r);
                    updates++;
                }else{
                    zoneRoomTempService.addRoomTemp(r);
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

    @RequestMapping(value = "exportRoomTemp")
    @RequiresPermissions("sysIndex")
    public void exportRoomTemp(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception{
        map.put("page",null);
        map.put("limit",null);
        map=ExtraMethod.setNull(map);
        String zone_name="";
        if(map.get("zone_id")!=null&&map.containsKey("zone_id")){
            Integer zid=Integer.parseInt(String.valueOf(map.get("zone_id")));
            Zones zones=zonesMapper.selectZones(zid);
            zone_name=zones.getZ_name();
        }
        List<Map<String,Object>> list=zoneRoomTempService.getRoomTempList(map);
        for(int i=0;i<list.size();i++){
            Map<String,Object> roomTemp=list.get(i);
            String fixture=String.valueOf(roomTemp.get("fixture"));
            if(fixture.equals("0")){
                roomTemp.put("fixture","固定状态");
            }else if(fixture.equals("0")){
                roomTemp.put("fixture","移动状态");
            }
            //房间号
            String b_num = String.valueOf(roomTemp.get("b_num"));
            String u_num = String.valueOf(roomTemp.get("u_num"));
            String r_num = String.valueOf(roomTemp.get("r_num"));
            String rnum = b_num + "-" + u_num + "-" + r_num;
            roomTemp.put("room_num", rnum);
        }
        HSSFWorkbook wb=ExcelUntil.getExcel("测温节点信息",ExtraBean.exportRoomTemp.roomTempName,ExtraBean.exportRoomTemp.roomTempType,list);
        String fileName = "Excel-" +zone_name+"测温节点";
        String headStr ="attachment;filename=\""+ new String( fileName.getBytes( "gb2312" ), "ISO8859-1" )+ ".xls" + "\"";
        //    mResponse.setHeader( "Content-Disposition", "attachment;filename=\""+ new String( fileName.getBytes( "gb2312" ), "ISO8859-1" )+ ".xls" + "\"" );
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", headStr);
        response.setCharacterEncoding("utf-8");
        OutputStream out = response.getOutputStream();
        wb.write(out);
    }
    @RequestMapping(value = "allRoomTemp")
    @RequiresPermissions("sysIndex")
    public @ResponseBody List<Map<String,Object>> allRoomTemp(@RequestParam Map<String,Object> condition){
        try{
            List<Map<String,Object>> list=zoneRoomTempService.getAllRoomTemp(condition);
            for(int i=0;i<list.size();i++){
                Map<String,Object> roomTemp=list.get(i);
                String fixture=String.valueOf(roomTemp.get("fixture"));
                if(fixture.equals("0")){
                    roomTemp.put("fixture","固定状态");
                }else if(fixture.equals("1")){
                    roomTemp.put("fixture","移动状态");
                }
                //房间号
                String b_num = String.valueOf(roomTemp.get("b_num"));
                String u_num = String.valueOf(roomTemp.get("u_num"));
                String r_num = String.valueOf(roomTemp.get("r_num"));
                String rnum = b_num + "-" + u_num + "-" + r_num;
                roomTemp.put("r_num", rnum);

                //数据时间
                if(roomTemp.get("data_time")!=null&&!String.valueOf(roomTemp.get("data_time")).equals("-")){
                    String d=String.valueOf(roomTemp.get("data_time"));
                    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String date=simpleDateFormat.format(simpleDateFormat.parse(d));
                    roomTemp.put("data_time",date);
                }
            }
            return list;
        }catch (Exception e){
            return null;
        }
    }
    @RequestMapping(value = "getTempCount")
    @RequiresPermissions("sysIndex")
    public @ResponseBody Map<String,Object> getTempCount(@RequestParam Map<String,Object> m){
        try {
            Integer all=zoneRoomTempService.getRoomTempListCount(m);
            Integer online=zoneRoomTempService.getOnlineTempCount(m);
            Integer offline=zoneRoomTempService.getOfflineTempCount(m);
            Map<String,Object> map=new HashMap<>();
            map.put("all",all);
            map.put("online",online);
            map.put("offline",offline);
            return  map;
        }catch (Exception e){
            return  null;
        }
    }
    @RequestMapping("roomTempInfoPage")
    @RequiresPermissions("sysIndex")
    public String index(Integer id, ModelMap map){
        map.addAttribute("id",id);
        return "zoneTemp";
    }
}

