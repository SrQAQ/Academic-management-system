<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="javax.sql.*" %> 
<% 
    String studentId = request.getParameter("studentId");  
    Class.forName("com.mysql.jdbc.Driver");  
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sims", "root", "123456");  
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery("SELECT * FROM students WHERE studentId=" + studentId);  
    if (rs.next()) {  
%>
<html>
<head>
<meta charset="UTF-8">
<title>修改学生信息</title>
</head>
<body>
   <form action="update_student.jsp" method="post">  
        <p>学号:<input type="hidden" name="studentId" value="<%= rs.getInt("studentId") %>">  
        <p>姓名: <input type="text" name="name" value="<%= rs.getString("name") %>"></p>  
        <p>性别: <input type="text" name="gender" value="<%= rs.getString("gender") %>"></p>  
        <p>班级: <input type="text" name="class1" value="<%= rs.getString("class1") %>"></p>  
        <p>专业: <input type="text" name="major" value="<%= rs.getString("major") %>"></p>  
        <p>职务: <input type="text" name="job" value="<%= rs.getString("job") %>"></p>  
        <p>手机号: <input type="text" name="phone" value="<%= rs.getString("phone") %>"></p>  
        <p>	出生日期: <input type="date" name="birthday" value="<%= rs.getString("birthday") %>"></p>  
        <input type="submit" value="确认">  
        <input type="button" value="取消" onclick="window.location='index.jsp';">  
    </form>  
</body>
</html>
<%  
    }  
    rs.close();  
    stmt.close();  
    con.close();  
%>