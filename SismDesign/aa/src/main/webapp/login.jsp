<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生信息管理系统登录页面</title>
<link rel="stylesheet" type="text/css" href="css/login.css"> 
</head>
<body>
<div id="login">  
        <h1>学生信息管理系统</h1>  
        <div class="error-message">
            <c:if test="${not empty errorMessage}">
                <p>${errorMessage}</p>
            </c:if>
        </div>
        <form method="post" action="LoginServlet">  
            <input type="text" required="required" placeholder="用户名" name="u"></input>  
            <input type="password" required="required" placeholder="密码" name="p"></input>  
            <button class="but" type="submit">安全登录</button>
            <label class="control-label" for="password">没有账号请<a href="register.jsp" style="color:blue;">注册</a></label>
        </form>  
    </div>  
</body>
</html>