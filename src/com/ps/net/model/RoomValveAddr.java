package com.ps.net.model;

import java.util.Date;

public class RoomValveAddr {
    private Integer room_id;

    private String valve_addr;

    private Integer stopped;

    private Date start_time;

    private Date stop_time;

    public Integer getRoom_id() {
        return room_id;
    }

    public void setRoom_id(Integer room_id) {
        this.room_id = room_id;
    }

    public String getValve_addr() {
        return valve_addr;
    }

    public void setValve_addr(String valve_addr) {
        this.valve_addr = valve_addr == null ? null : valve_addr.trim();
    }

    public Integer getStopped() {
        return stopped;
    }

    public void setStopped(Integer stopped) {
        this.stopped = stopped;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getStop_time() {
        return stop_time;
    }

    public void setStop_time(Date stop_time) {
        this.stop_time = stop_time;
    }
}