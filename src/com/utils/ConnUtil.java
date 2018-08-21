package com.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnUtil {
	final private static String driverClass="org.postgresql.Driver";// 驱动类
    final private static String url="jdbc:postgresql://localhost:5432/postgis_24_sample";// 数据库地址
    final private static String username="postgres";// 用户名
    final private static String password="970804";// 密码
    public String getDriverClass() {
        return driverClass;
    }
    public String getUrl() {
        return url;
    }
    public String getUsername() {
        return username;
    }
    public String getPassword() {
        return password;
    }
    public static Connection getConn() {
         Connection conn = null ;
         try {
            Class.forName(driverClass);
            try {
                conn = DriverManager.getConnection(url, username, password);
            } catch (SQLException e) {
                e.printStackTrace();
            } 
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } 
        return conn;
    }
    public static void main(String[] args) {    	
        Connection conn = ConnUtil.getConn();
        if(conn!=null){
            System.out.println("数据库连接成功！");
        }
    }
}
