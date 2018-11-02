package com.ps.net.model;

public class AlarmsType {
    private Integer id;

    private String alarm_code;

    private String alarm_name;

    private String alarm_note;

    private Integer alarm_duration;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAlarm_code() {
        return alarm_code;
    }

    public void setAlarm_code(String alarm_code) {
        this.alarm_code = alarm_code == null ? null : alarm_code.trim();
    }

    public String getAlarm_name() {
        return alarm_name;
    }

    public void setAlarm_name(String alarm_name) {
        this.alarm_name = alarm_name == null ? null : alarm_name.trim();
    }

    public String getAlarm_note() {
        return alarm_note;
    }

    public void setAlarm_note(String alarm_note) {
        this.alarm_note = alarm_note == null ? null : alarm_note.trim();
    }

    public Integer getAlarm_duration() {
        return alarm_duration;
    }

    public void setAlarm_duration(Integer alarm_duration) {
        this.alarm_duration = alarm_duration;
    }
}