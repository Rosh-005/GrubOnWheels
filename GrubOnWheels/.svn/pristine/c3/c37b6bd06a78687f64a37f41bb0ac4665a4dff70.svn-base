<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
            background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/reset_password.jpg);
			background-repeat: no-repeat;
			background-size: cover;
			background-position: relative;
        }
        .container {
            width: 30%;
            margin: 100px auto;
            background-color: silver;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
        }
        label, input {
            display: block;
            margin: 10px 0;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
 <% if(request.getParameter("Failed") != null){ %>
        	 <script>
             alert("Failed to Reset Password! Please try again");
         </script>
         <% }
         %>
<%String action = request.getParameter("action");
System.out.println(action);%>
    <div class="container">
        <h1>Forgot Password</h1>
        
        <form action="ResetPassword" method="post" name="forgotPass">
        <label for="phoneNumber">Phone Number:</label>
            <input type="text" id="phone" name="phone" required>
            <input type="hidden" name="action" value="<%=action%>">
        
            <label for="newPassword">New Password:</label>
            <input type="password" id="password" name="password" onkeydown="return validateForgotPhoneNo(document.forgotPass.phone,'<%=action%>')" required>
            
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="cpassword" name="cpassword" onkeydown="return validatePassword(document.forgotPass.password)" required>
            
            <input type="submit" value="Reset Password" onclick="return checkPassword()">
        </form>
    </div>
    <script src="Resources/LandingPage/js/app.js"></script>
</body>
</html>
