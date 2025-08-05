<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="javax.sql.*" %>  
<%@ page import="java.util.*" %>  
<%  
  
    // 数据库连接和查询  
    Connection con = null;  
    Statement stmt = null;  
    ResultSet rs = null;  
    try {  
        Class.forName("com.mysql.jdbc.Driver");  
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sims", "root", "123456"); 
        stmt = con.createStatement();  
        rs = stmt.executeQuery("SELECT * FROM students");  
    } catch (Exception e) {  
        e.printStackTrace();  
    }  
%>  
<!DOCTYPE html>  
<html>  
<head>  
    <title>学生信息管理</title>
<link rel="stylesheet" type="text/css" href="css/style.css"/>  
    <script>
    function confirmDelete(studentId) {  
        if (confirm("是否确定删除该学生信息？")) {  
            window.location = "delete.jsp?studentId=" + studentId;  
        }  
    }  
        function confirmExit() {  
            if (confirm("是否确定退出？")) {  
                window.location = "logout.jsp";  
            }
    }
    </script>  
</head>  
<body>  
    <h1>学生信息管理</h1>
    <button onclick="window.location='increase_Info.jsp';">添加学生信息</button>
    <button onclick="window.location='modify_pwd.jsp';">修改密码</button>  
    <button onclick="confirmExit();">退出</button>  
    <table border="1">  
        <tr>  
            <th>学号</th>  
            <th>姓名</th>  
            <th>性别</th>  
            <th>班级</th>  
            <th>专业</th>  
            <th>职务</th>  
            <th>手机号</th>  
            <th>出生日期</th>  
            <th>操作</th>  
        </tr>  
        <% while (rs != null && rs.next()) { %>  
        <tr>  
            <td><%= rs.getInt("studentId") %></td>  
            <td><%= rs.getString("name") %></td>  
            <td><%= rs.getString("gender") %></td>  
            <td><%= rs.getString("class1") %></td>  
            <td><%= rs.getString("major") %></td>  
            <td><%= rs.getString("job") %></td>  
            <td><%= rs.getString("phone") %></td>  
            <td><%= rs.getString("birthday") %></td>  
            <td>  
                <button onclick="window.location='edit_Info.jsp?studentId=<%= rs.getInt("studentId") %>';">修改</button>  
                <button onclick="if (confirm('是否确定删除？')) window.location='delete_student.jsp?studentId=<%= rs.getInt("studentId") %>';">删除</button>  
            </td>  
        </tr>
        <% if (request.getAttribute("deleteSuccess") != null) { %>  
    <p><%= request.getAttribute("deleteSuccess") %></p>  
<% } else if (request.getAttribute("deleteError") != null) { %>  
    <p><%= request.getAttribute("deleteError") %></p>  
<% } %>  
        <% } %>  
    </table>  
</body>  
</html>