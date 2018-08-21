package com.utils;

import java.sql.Date;
import java.math.BigDecimal;

public class Station {
    private Integer id;
    private String station_name = null;
    private String river_name = null;
    private String section = null;
    private String quality_this_week = null;
    private String quality_last_week = null;
    private String main_pollutant = null;
    private BigDecimal PH = new BigDecimal(0);
    private BigDecimal DO = new BigDecimal(0);
    private BigDecimal CODMn = new BigDecimal(0);
    private BigDecimal NH3_N = new BigDecimal(0);
    private String create_user = null;
    private String update_user = null;
    private Date create_date;
    private Date update_date;
    private String coordinate = "0,0";
    
    //点位基本信息
    /** 点位序号 **/
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    /** 点位名称 **/
    public String getStationName() {
        return station_name;
    }
    public void setStationName(String station_name) {
        this.station_name = station_name;
    }
    /** 河流名称 **/
    public String getRiverName() {
        return river_name;
    }
    public void setRiverName(String river_name) {
        this.river_name = river_name;
    }
    /** 断面情况 **/
    public String getSection() {
        return section;
    }
    public void setSection(String section) {
        this.section = section;
    }
    
    //水质信息
    /** PH **/
    public BigDecimal getPH() {
        return PH;
    }
    public void setPH(BigDecimal PH) {
        this.PH = PH;
    }
    /** DO **/
    public BigDecimal getDO() {
        return DO;
    }
    public void setDO(BigDecimal DO) {
        this.DO = DO;
    }
    /** CODMn **/
    public BigDecimal getCODMn() {
        return CODMn;
    }
    public void setCODMn(BigDecimal CODMn) {
        this.CODMn = CODMn;
    }
    /** NH3_N **/
    public BigDecimal getNH3_N() {
        return NH3_N;
    }
    public void setNH3_N(BigDecimal NH3_N) {
        this.NH3_N = NH3_N;
    }
    /** 本周水质 **/
    public String getQualityThisWeek() {
        return quality_this_week;
    }
    public void setQualityThisWeek(String quality_this_week) {
        this.quality_this_week = quality_this_week;
    }
    /** 上周水质 **/
    public String getQualityLastWeek() {
        return quality_last_week;
    }
    public void setQualityLastWeek(String quality_last_week) {
        this.quality_last_week = quality_last_week;
    }
    /** 主要污染物 **/
    public String getMainPollutant() {
        return main_pollutant;
    }
    public void setMainPollutant(String main_pollutant) {
        this.main_pollutant = main_pollutant;
    }
    
    //更新信息
    /** 创建表人员 **/
    public String getCreateUser() {
        return create_user;
    }
    public void setCreateUser(String create_user) {
        this.create_user = create_user;
    }
    /** 更新表人员 **/
    public String getUpdateUser() {
        return update_user;
    }
    public void setUpdateUser(String update_user) {
        this.update_user = update_user;
    }
    /** 创建表日期 **/
    public Date getCreateDate() {
        return create_date;
    }
    public void setCreateDate(Date create_date) {
        this.create_date = create_date;
    }
    /** 更新表日期 **/
    public Date getUpdateDate() {
        return update_date;
    }
    public void setUpdateDate(Date update_date) {
        this.update_date = update_date;
    }
    /** 坐标  **/
    public String getCoordinate() {
        return coordinate;
    }
    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate;
    }
        
    //将结果转成json样式的字符串
    public static String Object2Json(Station s){
    	String json="{\"station\":[" +
	                "{\"id\":\""+s.getId()+"\","+
    			    "\"StationName\":\""+s.getStationName()+"\","+
	                "\"RiverName\":\""+s.getRiverName()+"\","+
	                "\"Section\":\""+s.getSection()+"\","+
	                "\"PH\":\""+s.getPH()+"\","+
	                "\"DO\":\""+s.getDO()+"\","+
	                "\"CODMn\":\""+s.getCODMn()+"\","+
	                "\"NH3_N\":\""+s.getNH3_N()+"\","+
	                "\"QualityThisWeek\":\""+s.getQualityThisWeek()+"\","+
	                "\"QualityLastWeek\":\""+s.getQualityLastWeek()+"\","+
	                "\"MainPollutant\":\""+s.getMainPollutant()+"\"}]}";
    	return json;
    	}
}
