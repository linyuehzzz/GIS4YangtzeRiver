package com.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.Date;

import com.utils.Station;
import com.utils.ConnUtil;

public class StationDao {
	public static Connection conn = null;
	public static String sql = null;
	public static PreparedStatement ptmt = null;
	public static ResultSet rs = null;
	
	/** 获取所有站点geometry **/
	public static String getStationGeom(){
    	try {
        //获取连接
        conn = ConnUtil.getConn();
        //sql, 每行加空格
        sql = "SELECT ST_AsGeoJSON(geom) from stations";
        //预编译SQL，减少sql执行
        ptmt = conn.prepareStatement(sql);
        //执行
        rs = ptmt.executeQuery();
        //解析位置
        String json="{\"type\":\"FeatureCollection\",\"crs\":{\"type\":\"name\",\"properties\":{\"name\":\"EPSG:4326\"}},\"features\":[";
        while(rs.next()){
        	String line = "{\"type\":\"Feature\","+"\"geometry\":"+rs.getString(1)
        			+"},";
        	json=json + line;
        }
        json=json.substring(0, json.length()-1);
        json=json+"]}";
        rs.close();
        conn.close();
        return json;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
            }
    }
	
	/** 获取热力图 **/
	public static String getHeatmap1(){
    	try {
        //获取连接
        conn = ConnUtil.getConn();
        //sql, 每行加空格
        sql = "SELECT ST_AsGeoJSON(geom) from stations where 本周水质=?";
        //预编译SQL，减少sql执行
        ptmt = conn.prepareStatement(sql);
        //执行
        ptmt.setString(1, "一类水质");
        rs = ptmt.executeQuery();
        //解析位置
        String json="{\"type\":\"FeatureCollection\",\"crs\":{\"type\":\"name\",\"properties\":{\"name\":\"EPSG:4326\"}},\"features\":[";
        while(rs.next()){
        	String line = "{\"type\":\"Feature\","+"\"geometry\":"+rs.getString(1)
        			+"},";
        	json=json + line;
        }
        json=json.substring(0, json.length()-1);
        json=json+"]}";
        rs.close();
        conn.close();
        return json;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
            }
    }
	public static String getHeatmap2(){
    	try {
        //获取连接
        conn = ConnUtil.getConn();
        //sql, 每行加空格
        sql = "SELECT ST_AsGeoJSON(geom) from stations where 本周水质=?";
        //预编译SQL，减少sql执行
        ptmt = conn.prepareStatement(sql);
        //执行
        ptmt.setString(1, "二类水质");
        rs = ptmt.executeQuery();
        //解析位置
        String json="{\"type\":\"FeatureCollection\",\"crs\":{\"type\":\"name\",\"properties\":{\"name\":\"EPSG:4326\"}},\"features\":[";
        while(rs.next()){
        	String line = "{\"type\":\"Feature\","+"\"geometry\":"+rs.getString(1)
        			+"},";
        	json=json + line;
        }
        json=json.substring(0, json.length()-1);
        json=json+"]}";
        rs.close();
        conn.close();
        return json;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
            }
    }
	public static String getHeatmap3(){
    	try {
        //获取连接
        conn = ConnUtil.getConn();
        //sql, 每行加空格
        sql = "SELECT ST_AsGeoJSON(geom) from stations where 本周水质=?";
        //预编译SQL，减少sql执行
        ptmt = conn.prepareStatement(sql);
        //执行
        ptmt.setString(1, "三类水质");
        rs = ptmt.executeQuery();
        //解析位置
        String json="{\"type\":\"FeatureCollection\",\"crs\":{\"type\":\"name\",\"properties\":{\"name\":\"EPSG:4326\"}},\"features\":[";
        while(rs.next()){
        	String line = "{\"type\":\"Feature\","+"\"geometry\":"+rs.getString(1)
        			+"},";
        	json=json + line;
        }
        json=json.substring(0, json.length()-1);
        json=json+"]}";
        rs.close();
        conn.close();
        return json;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
            }
    }
	
	/** 查询（根据点位名称） **/
	public static Station getQueryResult(String value){
    	try {
	        //获取连接
	        conn = ConnUtil.getConn();
	        //sql, 每行加空格
	        sql = "select * from stations where 点位名称=?";
	        //预编译SQL，减少sql执行
	        ptmt = conn.prepareStatement(sql);
	        //执行
	        ptmt.setString(1, value);
	        rs = ptmt.executeQuery();
	        //解析属性
	        Station s = new Station();
	        while(rs.next()){
	            s.setId(rs.getInt("gid"));
	            s.setStationName(rs.getString("点位名称"));
	            s.setRiverName(rs.getString("河流名称"));
	            s.setSection(rs.getString("断面情况"));
	            s.setPH(rs.getBigDecimal("ph"));
	            s.setDO(rs.getBigDecimal("do_mg_l_"));
	            s.setCODMn(rs.getBigDecimal("codmn_mg_l"));
	            s.setNH3_N(rs.getBigDecimal("nh3_n_mg_l"));
	            s.setQualityThisWeek(rs.getString("本周水质"));
	            s.setQualityLastWeek(rs.getString("上周水质"));
	            s.setMainPollutant(rs.getString("主要污染指标"));
	        }
	        rs.close();
	        conn.close();
	        return s;
        } catch (SQLException e) {
        	e.printStackTrace();
        	return null;
        	}
    }
	
	/** 点击查询 **/
	public static Station getClickResult(String coordinate){
    	try {
	        //获取连接
	        conn = ConnUtil.getConn();
	        //sql, 每行加空格	        
	        sql = "select * from stations where ST_Contains(ST_Buffer(geom,0.05),ST_PointFromText(?))";
	        //预编译SQL，减少sql执行
	        ptmt = conn.prepareStatement(sql);
	        //执行
	        String point = "POINT(";
	        int split = coordinate.indexOf(",");
	        point = point + coordinate.subSequence(0, split-1) + " " + 
	        		coordinate.substring(split+1) + ")";	        
	        ptmt.setString(1,point);
	        rs = ptmt.executeQuery();
	        //解析属性
	        Station s = new Station();
	        while(rs.next()){
	            s.setId(rs.getInt("gid"));
	            s.setStationName(rs.getString("点位名称"));
	            s.setRiverName(rs.getString("河流名称"));
	            s.setSection(rs.getString("断面情况"));
	            s.setPH(rs.getBigDecimal("ph"));
	            s.setDO(rs.getBigDecimal("do_mg_l_"));
	            s.setCODMn(rs.getBigDecimal("codmn_mg_l"));
	            s.setNH3_N(rs.getBigDecimal("nh3_n_mg_l"));
	            s.setQualityThisWeek(rs.getString("本周水质"));
	            s.setQualityLastWeek(rs.getString("上周水质"));
	            s.setMainPollutant(rs.getString("主要污染指标"));
	        }
	        rs.close();
	        conn.close();
	        return s;
        } catch (SQLException e) {
        	e.printStackTrace();
        	return null;
        	}
    }
	  
	/** 增加记录 **/
    public static int addStation(Station s){
    	try {
    		//获取连接
            conn = ConnUtil.getConn();
            //sql
        	sql = "INSERT INTO stations (gid,点位名称,河流名称,断面情况,ph,do_mg_l_,codmn_mg_l,nh3_n_mg_l,本周水质,上周水质,主要污染指标,geom,更新表人员,创建表人员,创建表时间,更新表时间)"
                    + "VALUES(?,?,?,?,?,?,?,?,?,?,?,"
	        		+ "ST_PointFromText(?),?,?,?,?)";
	        //预编译
	        ptmt = conn.prepareStatement(sql); //预编译SQL，减少sql执行
	        //处理id
	        int id = 50;
	        Statement st = conn.createStatement();
	        ResultSet res = st.executeQuery("select count(*) from stations");
	        if (res.next())
	              id = res.getInt(1) + 1;
	        res.close();
	        //处理空间信息输入参数
	        String point = "POINT(";
	        if(s.getCoordinate()!=null) {
		        int split = s.getCoordinate().indexOf(",");
		        point = point + s.getCoordinate().subSequence(0, split-1) + " " + 
		        		s.getCoordinate().substring(split+1) + ")";
	        }
	        //获取当前时间
	        Date date = null;
	        res = st.executeQuery("select current_date");
	        if (res.next())
	        	date = res.getDate(1);
	        res.close();	        
	        //传参
	        ptmt.setInt(1, id);
	        ptmt.setString(2, s.getStationName());
	        ptmt.setString(3, s.getRiverName());
	        ptmt.setString(4, s.getSection());
	        ptmt.setBigDecimal(5, s.getPH());
	        ptmt.setBigDecimal(6, s.getDO());
	        ptmt.setBigDecimal(7, s.getCODMn());
	        ptmt.setBigDecimal(8, s.getNH3_N());
	        ptmt.setString(9, s.getQualityThisWeek());
	        ptmt.setString(10, s.getQualityLastWeek());
	        ptmt.setString(11, s.getMainPollutant());
	        ptmt.setString(12, point);
	        ptmt.setString(13, s.getUpdateUser());
	        ptmt.setString(14, s.getCreateUser()); 
	        ptmt.setDate(15, date);
	        ptmt.setDate(16, date);	 
	        //执行
			ptmt.execute();
	        conn.close();
	        return 1;
	        } catch (SQLException e) {
	        	e.printStackTrace();
	        	return 0;
	        	}
    	}
    
    /** 修改字段值 **/
    public static int updateStationSN(String StationName, String FieldValue, String UpdateUser) {
    	try {
    		//获取连接
    		conn = ConnUtil.getConn();
    		//sql, 每行加空格
    		sql = "UPDATE stations set 点位名称=?, 更新表人员=?, 更新表时间=? where 点位名称=?";
    		//预编译
    		ptmt = conn.prepareStatement(sql); //预编译SQL，减少sql执行
	        //获取当前时间
    		Date date = null;
    		Statement st = conn.createStatement();	        
	        ResultSet res = st.executeQuery("select current_date");
	        if (res.next())
	        	date = res.getDate(1);
	        res.close();
    		//传参
	        ptmt.setString(1, FieldValue);
	        ptmt.setString(2, UpdateUser);
	        ptmt.setDate(3, date);
	        ptmt.setString(4, StationName);
            //执行
            ptmt.execute();
            conn.close();
            return 1;
            } catch (SQLException e) {
            	e.printStackTrace();
            	return 0;
            	}
    	}
    
    /** 删除记录 **/
    public static int delStation(String StationName) {
    	try {
    		//获取连接
    	    conn = ConnUtil.getConn();
            //sql, 每行加空格
            sql = "delete from stations where 点位名称=?";
            //预编译SQL，减少sql执行
            ptmt = conn.prepareStatement(sql);
            //传参
            ptmt.setString(1, StationName);
            //执行
            ptmt.execute();
            conn.close();
            return 1;
            } catch (SQLException e) {
            	e.printStackTrace();
            	return 0;
            	}
    	}
   
    public static void main(String[] args) { 
/*    	Station s = StationDao.getClickResult("102.013533,26.887");
    	s.setCoordinate("102.013533,26.887");
    	s.setPHFigPath("src/com/utils/img/15-扬州三江营-PH.png");*/
    	//int a = updateStationS("想","点位名称","s","d");
    	//int a = addStation(s);
    	//System.out.println(a);
    }
}
