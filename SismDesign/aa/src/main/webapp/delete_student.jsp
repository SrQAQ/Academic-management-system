<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%  
    String studentId = request.getParameter("studentId");  
    if (studentId != null && !studentId.isEmpty()) {  
        // 连接数据库并执行删除操作  
        Connection con = null;  
        PreparedStatement pstmt = null;  
        try {  
            Class.forName("com.mysql.jdbc.Driver");  
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sims", "root", "123456");  
            String sql = "DELETE FROM students WHERE studentId = ?";  
            pstmt = con.prepareStatement(sql);  
            pstmt.setString(1, studentId);  
            int result = pstmt.executeUpdate();  
            if (result > 0) {  
                // 删除成功，设置消息并重定向到index.jsp  
                request.setAttribute("deleteSuccess", "学生信息删除成功！");  
            } else {  
                // 删除失败，设置消息并重定向到index.jsp  
                request.setAttribute("deleteError", "学生信息删除失败，请重试！");  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
            request.setAttribute("deleteError", "删除过程中发生错误，请稍后再试！");  
        } finally {  
            try {  
                if (pstmt != null) pstmt.close();  
                if (con != null) con.close();  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        // 重定向到index.jsp  
        response.sendRedirect("index.jsp");  
    } else {  
        // 如果没有提供studentId，则重定向到index.jsp并显示错误消息  
        request.setAttribute("error", "缺少必要的学生信息ID！");  
        response.sendRedirect("index.jsp");  
    }  
%>