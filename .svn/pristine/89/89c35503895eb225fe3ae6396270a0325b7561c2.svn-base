package com.ps.net.service.impl;

import com.ps.net.dao.BranchCompanyMapper;
import com.ps.net.dao.HeatAreaMapper;
import com.ps.net.dao.ZonesMapper;
import com.ps.net.model.BranchCompany;
import com.ps.net.model.HeatArea;
import com.ps.net.model.Zones;
import org.springframework.stereotype.Service;
import com.ps.net.service.AreaChooseService;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service
public class AreaChooseServiceImpl implements AreaChooseService {
    @Resource
    private BranchCompanyMapper branchCompanyMapper;
    @Resource
    private HeatAreaMapper heatAreaMapper;
    @Resource
    private ZonesMapper zonesMapper;
    @Override
    public List<BranchCompany> getBranchCompanyList(Integer user_id){
        return branchCompanyMapper.selectBranchCompanyList(user_id);
    }
    @Override
    public  List<HeatArea> getHeatAreaList(Map<String,Object> map){
        return  heatAreaMapper.selectHeatAreaList(map);
    }
    @Override
    public  List<Zones> getZonesList(Integer areaId){
        return  zonesMapper.selectZonesList(areaId);
    }
    @Override
    public  void addBranchCompany( BranchCompany branchCompany){

        branchCompanyMapper.insertBranchCompany(branchCompany);
    }
    @Override
    public void addHeatArea(HeatArea heatArea){
        heatAreaMapper.insertHeatArea(heatArea);
    }
    @Override
    public void addZones(Zones zones){
        zonesMapper.insertZones(zones);
    }
    @Override
    public BranchCompany getBranchCompany(Integer id){
        return branchCompanyMapper.selectBranchCompany(id);
    }
    @Override
    public void editBranchCompany(BranchCompany branchCompany){
        branchCompanyMapper.updateBranchCompany(branchCompany);
    }
    @Override
    public  void  editHeatArea(HeatArea heatArea){
        heatAreaMapper.updateHeatArea(heatArea);
    }
    @Override
    public HeatArea getHeatArea(Integer id){
        return heatAreaMapper.selectHeatArea(id);
    }
    @Override
    public  Zones getZones(Integer id){
        return zonesMapper.selectZones(id);
    }
    @Override
    public void editZones(Zones zones){
        zonesMapper.updateZones(zones);
    }

}
