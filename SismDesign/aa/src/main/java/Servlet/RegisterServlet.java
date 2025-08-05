package Servlet;  
  
import jakarta.servlet.ServletException;  
import jakarta.servlet.annotation.WebServlet;  
import jakarta.servlet.http.HttpServlet;  
import jakarta.servlet.http.HttpServletRequest;  
import jakarta.servlet.http.HttpServletResponse;  
import java.io.IOException;  
import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  
  
@WebServlet("/RegisterServlet")  
public class RegisterServlet extends HttpServlet {  
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sims";  
    private static final String DB_USER = "root";  
    private static final String DB_PASSWORD = "123456";  
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        String username = request.getParameter("username");  
        String password = request.getParameter("password");  
        String confirmPassword = request.getParameter("confirm_password");  
        String email = request.getParameter("email");  
        String captcha = request.getParameter("captcha");   
  
 
       if (!captcha.equals("7364")) {  
 
           request.setAttribute("errorMessage", "验证码错误！");  
            return;  
        }  
  

        if (!password.equals(confirmPassword)) {  
            request.setAttribute("errorMessage", "两次输入的密码不一致！");  
            request.getRequestDispatcher("register.jsp").forward(request, response);  
            return;  
        }  
        
        try {  
            Class.forName("com.mysql.cj.jdbc.Driver");  
        } catch (ClassNotFoundException e) {  
            throw new ServletException("MySQL JDBC Driver not found.", e);  
        }
  
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {   
 
            PreparedStatement stmtCheckUser = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username = ?");  
            stmtCheckUser.setString(1, username);  
            ResultSet rs = stmtCheckUser.executeQuery();  
            if (rs.next() && rs.getInt(1) > 0) {  
                request.setAttribute("errorMessage", "用户名已存在！");  
                request.getRequestDispatcher("register.jsp").forward(request, response);  
                return;  
            }  
  
 
            PreparedStatement stmtInsert = conn.prepareStatement(  
                    "INSERT INTO users (username, password, email) VALUES (?, ?, ?)");  

            stmtInsert.setString(1, username);  
            stmtInsert.setString(2, password); 
            stmtInsert.setString(3, email);  
            int rowsInserted = stmtInsert.executeUpdate();  
  
            if (rowsInserted > 0) {  
 
                System.out.println("Registration successful, redirecting to login.jsp");  
                response.sendRedirect("login.jsp");  
            } else {  
 
                request.setAttribute("errorMessage", "注册失败，请重试！");  
                request.getRequestDispatcher("register.jsp").forward(request, response);  
            }  
        } catch (SQLException e) {  
 
            request.setAttribute("errorMessage", "数据库错误：" + e.getMessage());  
            request.getRequestDispatcher("register.jsp").forward(request, response);  
        }  
    }  
}