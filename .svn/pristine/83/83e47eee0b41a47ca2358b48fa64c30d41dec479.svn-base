package com.ps.net.changeObject;

import java.util.Map;

public class Page {
    public static Map getData(Map<String,Object> map){
        Integer page = Integer.parseInt(String.valueOf(map.get("page")));
        Integer limit = Integer.parseInt(String.valueOf(map.get("limit")));
        Integer first;
        first = (page - 1) * limit;
        map.put("first", first);
        map.put("last", limit);
        return map;
    }
}
