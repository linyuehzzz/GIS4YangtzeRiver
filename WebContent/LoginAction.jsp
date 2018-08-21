<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.utils.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
	Connection conn = null;
	String sql = null;
    PreparedStatement ptmt = null;
    ResultSet rs = null;
    
    //取出Login.jsp的值     
    request.setCharacterEncoding("UTF-8");
    String role = (String)request.getParameter("role");
    String username = (String)request.getParameter("username");
    String password = (String)request.getParameter("password");
    String isRmbPwd = (String)request.getParameter("isRmbPwd"); 
    //获取连接
    conn = ConnUtil.getConn();
    if(role.equals("user")){
        //sql
        sql = "select * from o_user where username=?";//定义一个查询语句
        //预编译SQL，减少sql执行
        ptmt = conn.prepareStatement(sql);
        //执行
        ptmt.setString(1,username);
        rs = ptmt.executeQuery();
        if(rs.next())
        {
            if(password.equals(rs.getObject("password"))){
             	if(isRmbPwd == null){
              	   //添加Cookie
                    Cookie nameCookie = new Cookie("username",username);
                    Cookie pswCookie=new Cookie("password",password);   
       	            nameCookie.setMaxAge(60);  
       	            pswCookie.setMaxAge(60);  
                    response.addCookie(nameCookie);//将Cookie对象保存在客户端
                    response.addCookie(pswCookie);
             	}
                //添加Session
             	request.getSession().setAttribute("username",username);     //用Session保存用户名
            	request.getSession().setAttribute("password",password);        //保存密码 
            	response.sendRedirect("User.jsp");               
            }
            else{
                out.print("<script language='javaScript'> alert('密码错误');</script>");
                response.setHeader("refresh", "0;url=Login.jsp");
            }
        }
        else 
        {
            out.print("<script language='javaScript'> alert('账号错误——else');</script>");
            response.setHeader("refresh", "0;url=Login.jsp");
        }
   }else if(role.equals("manager")){
       //sql
       sql = "select * from manager where username=?";//定义一个查询语句
       //预编译SQL，减少sql执行
       ptmt = conn.prepareStatement(sql);
       //执行
       ptmt.setString(1,username);
       rs = ptmt.executeQuery();
       if(rs.next())
       {
           if(password.equals(rs.getObject("password"))){
            	if(isRmbPwd == null){
               	   //添加Cookie
                     Cookie nameCookie = new Cookie("username",username);
                     Cookie pswCookie=new Cookie("password",password);   
        	         nameCookie.setMaxAge(60);  
        	         pswCookie.setMaxAge(60);  
                     response.addCookie(nameCookie);//将Cookie对象保存在客户端
                     response.addCookie(pswCookie);
              	}
               //添加Session
        	   request.getSession().setAttribute("username",username);     //用Session保存用户名
        	   request.getSession().setAttribute("password",password);        //保存密码
               response.sendRedirect("Manager.jsp");
           }
           else{
               out.print("<script language='javaScript'> alert('密码错误');</script>");
               response.setHeader("refresh", "0;url=Login.jsp");
           }
       }
       else 
       {
           out.print("<script language='javaScript'> alert('账号错误——else');</script>");
           response.setHeader("refresh", "0;url=Login.jsp");
       }
  }    
%>
</body>
</html>