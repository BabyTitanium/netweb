package com.ps.net.changeObject;

import org.w3c.dom.stylesheets.LinkStyle;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExtraMethod {
    //将Map中的空值设置为null
    public static Map<String,Object> setNull(Map<String,Object> map){
        for(String s:map.keySet()){
            String str=String.valueOf(map.get(s));
            if(str.length()<=0) {
                map.put(s,null);
            }
        }
            return map;
    }
    //将String转换为数组
    public static  Integer[] changeToArray(String s){
        String a[]=s.split("[\\[,\\]]");    //以,隔开获得数组a[]={"3","1","2","4"}
        Integer b[]=new Integer[a.length];
        for(int i=0;i<a.length;i++){    //将String数组，转换为int数组
            if(a[i].length()!=0)
               b[i]=Integer.parseInt(a[i]);
        }
        return b;
    }

    public static  Map<String,Object> returnList(List list,Integer count){
        Map<String,Object> data=new HashMap<>();
        data.put("code", 0);
        data.put("msg", "");
        data.put("data", list);
        data.put("count",count);
        return data;
    }
    //将房间号分解为楼号，单元号，房间号，楼层
    public  static  String[] changeRoomNum(String name){
        String [] names=new String[4];
        String [] m=name.split("-");
        Integer f=Integer.parseInt(m[2]);
        Integer floor=f/100;
        names[3]=String.valueOf(floor);
        for(int i=0;i<m.length;i++){
            names[i]=m[i];
        }
//        for(int i=0;i<names.length;i++){
//            System.out.println(names[i]);
//        }
        return names;
    }
}
