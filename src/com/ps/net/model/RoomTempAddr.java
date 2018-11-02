package com.ps.net.model;

import java.util.Date;

public class RoomTempAddr extends RoomTempAddrKey {
    private String temp_addr;

    private Integer stopped;

    private Date start_time;

    private Date stop_time;

    private String temp_model;

    public String getTemp_addr() {
        return temp_addr;
    }

    public void setTemp_addr(String temp_addr) {
        this.temp_addr = temp_addr == null ? null : temp_addr.trim();
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

    public String getTemp_model() {
        return temp_model;
    }

    public void setTemp_model(String temp_model) {
        this.temp_model = temp_model == null ? null : temp_model.trim();
    }
}