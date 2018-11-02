package com.ps.net.model;

import java.util.Date;

public class Rooms {
    private Integer id;

    private Integer unit_id;

    private Integer floor;

    private Integer room_num;

    private String room_name;

    private Integer location;

    private String user_code;

    private String host_name;

    private String contact_info;

    private Double room_area;

    private Double heat_area;

    private Integer user_type;

    private Integer heat_type;

    private Byte is_supply;

    private String contract_num;

    private String notes;

    private Date update_time;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(Integer unit_id) {
        this.unit_id = unit_id;
    }

    public Integer getFloor() {
        return floor;
    }

    public void setFloor(Integer floor) {
        this.floor = floor;
    }

    public Integer getRoom_num() {
        return room_num;
    }

    public void setRoom_num(Integer room_num) {
        this.room_num = room_num;
    }

    public String getRoom_name() {
        return room_name;
    }

    public void setRoom_name(String room_name) {
        this.room_name = room_name == null ? null : room_name.trim();
    }

    public Integer getLocation() {
        return location;
    }

    public void setLocation(Integer location) {
        this.location = location;
    }

    public String getUser_code() {
        return user_code;
    }

    public void setUser_code(String user_code) {
        this.user_code = user_code == null ? null : user_code.trim();
    }

    public String getHost_name() {
        return host_name;
    }

    public void setHost_name(String host_name) {
        this.host_name = host_name == null ? null : host_name.trim();
    }

    public String getContact_info() {
        return contact_info;
    }

    public void setContact_info(String contact_info) {
        this.contact_info = contact_info == null ? null : contact_info.trim();
    }

    public Double getRoom_area() {
        return room_area;
    }

    public void setRoom_area(Double room_area) {
        this.room_area = room_area;
    }

    public Double getHeat_area() {
        return heat_area;
    }

    public void setHeat_area(Double heat_area) {
        this.heat_area = heat_area;
    }

    public Integer getUser_type() {
        return user_type;
    }

    public void setUser_type(Integer user_type) {
        this.user_type = user_type;
    }

    public Integer getHeat_type() {
        return heat_type;
    }

    public void setHeat_type(Integer heat_type) {
        this.heat_type = heat_type;
    }

    public Byte getIs_supply() {
        return is_supply;
    }

    public void setIs_supply(Byte is_supply) {
        this.is_supply = is_supply;
    }

    public String getContract_num() {
        return contract_num;
    }

    public void setContract_num(String contract_num) {
        this.contract_num = contract_num == null ? null : contract_num.trim();
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes == null ? null : notes.trim();
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }
}