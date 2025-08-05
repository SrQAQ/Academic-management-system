<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>  
<%  
    String studentId = request.getParameter("studentId");  
    String name = request.getParameter("name");  
    String gender = request.getParameter("gender");  
    String class1 = request.getParameter("class1");  
    String major = request.getParameter("major");  
    String job = request.getParameter("job");  
    String phone = request.getParameter("phone");  
    String birthday = request.getParameter("birthday");  
  
    if (studentId != null && name != null && gender != null && class1 != null && major != null && job != null && phone != null && birthday != null) {  
        Connection con = null;  
        PreparedStatement pstmt = null;  
        try {  
            Class.forName("com.mysql.jdbc.Driver");  
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sims", "root", "123456");  
            // 检查学号是否已存在  
            pstmt = con.prepareStatement("SELECT * FROM students WHERE studentId=?");  
            pstmt.setString(1, studentId);  
            ResultSet rs = pstmt.executeQuery();  
            if (rs.next()) {  
                out.println("<script>alert('学号已存在，请重新输入！');</script>");  
            } else {  
                // 插入新学生信息  
                pstmt = con.prepareStatement("INSERT INTO students (studentId, name, gender, class1, major, job, phone, birthday) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");  
                pstmt.setString(1, studentId);  
                pstmt.setString(2, name);  
                pstmt.setString(3, gender);  
                pstmt.setString(4, class1);  
                pstmt.setString(5, major);  
                pstmt.setString(6, job);  
                pstmt.setString(7, phone);  
                pstmt.setString(8, birthday);  
                pstmt.executeUpdate();  
                out.println("<script>alert('学生信息添加成功！'); window.location='index.jsp';</script>");  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            try {  
                if (pstmt != null) pstmt.close();  
                if (con != null) con.close();  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
    }  
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增学生信息</title>
</head>
<body>
<h1>新增学生信息</h1>  
    <form action="increase_Info.jsp" method="post">  
        <p>学号: <input type="text" name="studentId" required></p>  
        <p>姓名: <input type="text" name="name" required></p>  
        <p>性别: <input type="radio" name="gender" value="男" required> 男 <input type="radio" name="gender" value="女"> 女</p>  
        <p>班级: <input type="text" name="class1" required></p>  
        <p>专业: <input type="text" name="major" required></p>  
        <p>职务: <input type="text" name="job"></p>  
        <p>手机号: <input type="text" name="phone" required></p>  
        <p>出生日期: <input type="date" name="birthday" required></p>  
        <input type="submit" value="添加">  
        <button type="button" onclick="window.location='index.jsp';">取消</button>  
    </form>  
</body>
</html>