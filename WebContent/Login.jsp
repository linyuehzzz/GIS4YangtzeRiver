<%@ page import="java.sql.*" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
 <link href="css/login.css" rel="stylesheet" type="text/css">
 
<%
    String username = "";
    String password = "";
    //获取当前站点的所有Cookie
    Cookie[] cookies = request.getCookies();
    if(cookies!=null){
        for (int i = 0; i < cookies.length; i++) {//对cookies中的数据进行遍历，找到用户名、密码的数据
            if ("username".equals(cookies[i].getName())) {
                username = cookies[i].getValue();
            };
            if ("password".equals(cookies[i].getName())) {
                password = cookies[i].getValue();
            }
        }
    }
%>
</head>
<body>
    <center>
        <h1 >长江流域重点断面水质监测系统</h1>
            <form id="indexform" name="indexForm" action="LoginAction.jsp" method="post">
                <table border="0">
                    <tr>
                        <td>登录角色：</td>
                        <td><select name="role">
                        	<option value="manager" >管理员</option>
                        	<option value="user" >普通用户</option>
                        	</select></td>
                    </tr>
                    <tr>
                        <td>账号：</td>
                        <td><input type="text" name="username" value="<%=username%>"></td>
                    </tr>
                    <tr>
                        <td>密码：</td>
                        <td><input type="password" name="password" value="<%=password%>"></td>
                    </tr>
                </table>
                <br>               
                <input type="checkbox" id="isRmbPwd" name="isRmbPwd"><lable>记住密码</lable><br><br>
                <input type="submit" class="button" value="登录">         
            </form>
    </center> 
</body>
</html>