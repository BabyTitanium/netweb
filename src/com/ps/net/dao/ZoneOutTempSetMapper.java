package com.ps.net.dao;

import com.ps.net.model.ZoneOutTempSet;
import com.ps.net.model.ZoneRoomTempSet;

import java.util.List;

public interface ZoneOutTempSetMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ZoneOutTempSet record);

    int insertSelective(ZoneOutTempSet record);

    ZoneOutTempSet selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ZoneOutTempSet record);

    int updateByPrimaryKey(ZoneOutTempSet record);

    List<ZoneOutTempSet> getOutTempInfo(Integer zone_id);
}