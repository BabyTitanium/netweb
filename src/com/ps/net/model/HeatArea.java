package com.ps.net.model;

public class HeatArea {
    Integer id;
    String name;
    String code;
    Integer branch_company_id;
    String initial_heat;
    String end_heat;
    Integer available;
    String address;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getBranch_company_id() {
        return branch_company_id;
    }

    public void setBranch_company_id(Integer branch_company_id) {
        this.branch_company_id = branch_company_id;
    }

    public String getInitial_heat() {
        return initial_heat;
    }

    public void setInitial_heat(String initial_heat) {
        this.initial_heat = initial_heat;
    }

    public String getEnd_heat() {
        return end_heat;
    }

    public void setEnd_heat(String end_heat) {
        this.end_heat = end_heat;
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
