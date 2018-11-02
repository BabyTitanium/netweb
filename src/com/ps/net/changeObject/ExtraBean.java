package com.ps.net.changeObject;

import org.openxmlformats.schemas.drawingml.x2006.main.STAdjCoordinate;

public class ExtraBean {
    public static class exportRoomExcel{
        public static String[] rowsType={"r_num","user_code","host_name","locationName","floor","custom_typeName","heat_typeName","room_area","heat_area","is_supply","charge_mode","contact_info","special_mark","update_time"};
        public static String[] rowsName={"房间号","收费编码","户主","房间位置","楼层","住户类型","采暖方式","房屋面积","供暖面积","供暖状态","计量方式","联系电话","特殊标识","更新时间"};

    }
    public static  class importRoomExcel{
        public  static String[]  importRoomName={"房间号","收费编码","户主","房间位置","住户类型","采暖方式","房屋面积","供暖面积","供暖状态","计量方式","联系电话","特殊标识"};
        public static  String[] importRoomType={"room_num","user_code","host_name","location","user_type","heat_type","room_area","heat_area","is_supply","charge_mode","contact_info","special_mark"};
    }
    public static  class importIsSupply{
        public static String[] isSupplyName={"房间号","供暖状态"};
        public  static String[] isSupplyType={"room_num","is_supply"};
    }
    public static class importRoomMeter{
        public static String[] roomMeterName={"房间号","表具型号","表具地址"};
        public static  String[] roomMeterType={"room_num","meter_model","meter_addr"};
    }
    public static class exportRoomMeter{
        public static String[] roomMeterName={"房间号","表具型号","表具地址","数据时间","累计热量","累计冷量","热功率","累计流量","瞬时流速","进水温度","回水温度","温差","电池状态","工作时间","错误列表"};
        public static  String[] roomMeterType={"room_num","meter_model","meter_addr","data_time","cu_heat","cu_cool","heat_power","cu_flow","flow_rate","in_temp","out_temp","diff_temp","battery_status","hours","err_list"};
    }

        public static class importRoomValve{
        public static String[] roomValveName={"房间号","阀门地址","阀门型号","网络号","集抄器号"};
        public static  String[] roomValveType={"room_num","valve_addr","valve_model","net_num","coll_num"};
    }
    public static class exportRoomValve{
        public static String[] roomValveName={"房间号","阀门地址","阀门型号","数据时间","设置温度","室内温度","阀门状态","开阀时间","进水温度","回水温度","给定回水温度","电源状态","故障信息"};
        public static  String[] roomValveType={"room_num","valve_addr","valve_model","data_time","set_temp","room_temp","valve_state","open_hours","in_temp","out_temp","given_out_temp","power_status","err_list"};
    }
    public static  class importRoomTemp{
        public static String[] roomTempName={"房间号","测温节点型号","测温节点序号","测温节点地址"};
        public static  String[] roomTempType={"room_num","temp_model","index","temp_addr"};
    }
    public static class exportRoomTemp{
        public static String[] roomTempName={"房间号","测温节点型号","测温节点序号","测温节点地址","数据时间","温度值","电池电压","固定标识","移动序列号","错误列表"};
        public static  String[] roomTempType={"room_num","temp_model","index","temp_addr","data_time","temp","battery","fixture","fixture_num","err_list"};
    }
    public static  class importRoomThermostat{
        public static String[] roomThermostatName={"房间号","面板型号","面板地址"};
        public static  String[] roomThermostatType={"room_num","thermostat_model","node_addr"};
    }
    public static class exportRoomThermostat{
        public static String[] roomThermostatName={"房间号","面板型号","面板地址","数据时间","室内温度","设定温度","电池电压","固定标识","移动序列号","错误列表"};
        public static  String[] roomThermostatType={"room_num","thermostat_model","node_addr","data_time","room_temp","set_temp","battery","fixture","fixture_num","err_list"};
    }
}
