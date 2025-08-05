<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%  
    String oldPassword = request.getParameter("oldPassword");  
    String newPassword = request.getParameter("newPassword");  
    String confirmPassword = request.getParameter("confirmPassword");  
    String username = (String)session.getAttribute("username");  
  
    if (oldPassword != null && newPassword != null && confirmPassword != null) {  
        if (newPassword.equals(confirmPassword)) {  
            Connection con = null;  
            Statement stmt = null;  
            try {  
                Class.forName("com.mysql.jdbc.Driver");  
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sims", "root", "123456");  
                stmt = con.createStatement();  
                ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='" + username + "' AND password='" + oldPassword + "'");  
                if (rs.next()) {  
                    stmt.executeUpdate("UPDATE users SET password='" + newPassword + "' WHERE username='" + username + "'");  
                    out.println("<script>alert('修改密码成功！'); window.location='login.jsp';</script>");  
                } else {  
                    out.println("<script>alert('原密码错误！');</script>");  
                }  
            } catch (Exception e) {  
                e.printStackTrace();  
            } finally {  
                try {  
                    if (stmt != null) stmt.close();  
                    if (con != null) con.close();  
                } catch (Exception e) {  
                    e.printStackTrace();  
                }  
            }  
        } else {  
            out.println("<script>alert('新密码和确认密码不一致！');</script>");  
        }  
    }  
%>  
<!DOCTYPE html>  
<html>  
<head>  
    <title>修改密码</title>  
</head>  
<body>  
    <h1>修改密码</h1>  
    <form action="modify_pwd.jsp" method="post">  
        <p>原密码: <input type="password" name="oldPassword"></p>  
        <p>新密码: <input type="password" name="newPassword"></p>  
        <p>确认密码: <input type="password" name="confirmPassword"></p>  
        <input type="submit" value="确定">  
        <button type="button" onclick="window.location='index.jsp';">返回</button>  
    </form>  
</body>  
</html>