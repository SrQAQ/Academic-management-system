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
  
    Class.forName("com.mysql.jdbc.Driver");  
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sims", "root", "123456");  
    PreparedStatement pstmt = con.prepareStatement("UPDATE students SET name=?, gender=?, class1=?, major=?, job=?, phone=?, birthday=? WHERE studentId=?");  
    pstmt.setString(1, name);  
    pstmt.setString(2, gender);  
    pstmt.setString(3, class1);  
    pstmt.setString(4, major);  
    pstmt.setString(5, job);  
    pstmt.setString(6, phone);  
    pstmt.setString(7, birthday);  
    pstmt.setInt(8, Integer.parseInt(studentId));  
    pstmt.executeUpdate();  
    pstmt.close();  
    con.close();  
    response.sendRedirect("index.jsp");  
%>