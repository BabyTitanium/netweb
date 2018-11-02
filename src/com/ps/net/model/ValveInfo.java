package com.ps.net.model;

import java.util.Date;

public class ValveInfo {
    private String valve_addr;

    private Integer net_num;

    private Integer coll_num;

    private String valve_model;

    private Date update_time;

    public String getValve_addr() {
        return valve_addr;
    }

    public void setValve_addr(String valve_addr) {
        this.valve_addr = valve_addr == null ? null : valve_addr.trim();
    }

    public Integer getNet_num() {
        return net_num;
    }

    public void setNet_num(Integer net_num) {
        this.net_num = net_num;
    }

    public Integer getColl_num() {
        return coll_num;
    }

    public void setColl_num(Integer coll_num) {
        this.coll_num = coll_num;
    }

    public String getValve_model() {
        return valve_model;
    }

    public void setValve_model(String valve_model) {
        this.valve_model = valve_model == null ? null : valve_model.trim();
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }
}