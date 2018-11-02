package com.ps.net.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;

public class HeatSeason {
    private Integer season_id;

    private String season_name;

   // @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date start_date;
   // @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_date;

    public Integer getSeason_id() {
        return season_id;
    }

    public void setSeason_id(Integer season_id) {
        this.season_id = season_id;
    }

    public String getSeason_name() {
        return season_name;
    }

    public void setSeason_name(String season_name) {
        this.season_name = season_name == null ? null : season_name.trim();
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }
}