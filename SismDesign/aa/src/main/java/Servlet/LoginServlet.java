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
  
@WebServlet("/LoginServlet")  
public class LoginServlet extends HttpServlet {  
    private static final long serialVersionUID = 1L;  
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sims";  
    private static final String DB_USER = "root";  
    private static final String DB_PASSWORD = "123456";  
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        String username = request.getParameter("u");   
        String password = request.getParameter("p"); 
        try {  
            Class.forName("com.mysql.cj.jdbc.Driver");  
        } catch (ClassNotFoundException e) {  
            throw new ServletException("MySQL JDBC Driver not found.", e);  
        }
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {  
            PreparedStatement stmt = conn.prepareStatement("SELECT password FROM users WHERE username = ?");  
            stmt.setString(1, username);  
            ResultSet rs = stmt.executeQuery();  
  
            if (rs.next()) {    
                String hashedPasswordFromDB = rs.getString("password");    
                if (hashedPasswordFromDB.equals(password)) {  
                    request.getSession().setAttribute("username", username);  
                    response.sendRedirect("index.jsp");   
                } else {   
                    request.setAttribute("errorMessage", "用户名或密码错误！");  
                    request.getRequestDispatcher("login.jsp").forward(request, response);  
                }  
            } else { 
                request.setAttribute("errorMessage", "用户名不存在！");  
                request.getRequestDispatcher("login.jsp").forward(request, response);  
            }  
        } catch (SQLException e) {    
            request.setAttribute("errorMessage", "数据库错误：" + e.getMessage());  
            request.getRequestDispatcher("login.jsp").forward(request, response);  
        }  
    }  
}