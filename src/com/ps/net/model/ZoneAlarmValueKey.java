package com.ps.net.model;

public class ZoneAlarmValueKey {
    private Integer zone_id;

    private String alarm_code;

    public Integer getZone_id() {
        return zone_id;
    }

    public void setZone_id(Integer zone_id) {
        this.zone_id = zone_id;
    }

    public String getAlarm_code() {
        return alarm_code;
    }

    public void setAlarm_code(String alarm_code) {
        this.alarm_code = alarm_code == null ? null : alarm_code.trim();
    }
}