package com.ps.net.model;

/**
 * 分公司实体
 */
public class BranchCompany {
    Integer id;
    String name;
    String code;
    Integer heat_company_id;
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

    public Integer getHeat_company_id() {
        return heat_company_id;
    }

    public void setHeat_company_id(Integer heat_company_id) {
        this.heat_company_id = heat_company_id;
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
