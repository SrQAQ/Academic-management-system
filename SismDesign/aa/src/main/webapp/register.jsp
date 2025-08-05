<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生信息管理系统注册页面</title>
<link rel="stylesheet" type="text/css" href="css/register.css"> 
</head>
<body>
    <div class="container">
        <h1>学生信息管理系统注册</h1>
 
        <div class="error-message">
            <c:if test="${not empty errorMessage}">
                <p>${errorMessage}</p>
            </c:if>
        </div>
        
        <form id="registerForm" action="RegisterServlet" method="post">
            <label for="username">用户名：</label>
            <input type="text" id="username" name="username" required>
            <span id="usernameError" class="error"></span><br><br>

            <label for="password">密码：</label>
            <input type="password" id="password" name="password" required><br><br>

            <label for="confirm_password">确认密码：</label>
            <input type="password" id="confirm_password" name="confirm_password" required>
            <span id="passwordMismatchError" class="error"></span><br><br>

            <label for="email">邮箱：</label>
            <input type="email" id="email" name="email" required><br><br>

            <label for="captcha">验证码：</label>
            <input type="text" id="captcha" name="captcha" required>
            <span id="captchaError" class="error"></span>
            <img width='100' height='55' id="img_check" src="img/num.png">

            <button type="submit">注册</button>
            <div class="zuihou"><p>已有账号?<a href="login.jsp">立即登录</a></p></div>
        </form>
    </div>
</body>
</html>