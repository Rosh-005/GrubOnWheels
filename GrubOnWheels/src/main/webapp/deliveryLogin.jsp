
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Grub On Wheels</title>
  <style type="text/css">
body {
	background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/delivery.jpg);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
}
</style>
  <link rel="stylesheet" href="Resources/style.css">

</head>
<body>

<body class="align">
<a href="index.jsp" class="home-icon" style="position: absolute; top: 0px; left: 0px;">
            <img src="Resources/images/homeicon.png" alt="Home Icon" width="40" height="40">
        </a>
    <h1 style="font-size: 60px;margin-top: 60px; color: white">Grub On Wheels🚚</h1>
    <h3 style="font-size: 30px; color:white; margin-top: 60px">Delivery Agent Login</h3>
    <div class="grid" style="margin-bottom: 200px">
    <form action="DeliveryLogin" method="POST" class="form login">

      <div class="form__field">
        <label for="login__username"><svg class="icon">
            <use xlink:href="#icon-user"></use>
          </svg><span class="hidden">Phone Number</span></label>
        <input autocomplete="username" id="login__username" type="text" name="phone" class="form__input" placeholder="Phone Number" required>
      </div>

      <div class="form__field">
        <label for="login__password"><svg class="icon">
            <use xlink:href="#icon-lock"></use>
          </svg><span class="hidden">Password</span></label>
        <input id="login__password" type="password" name="password" class="form__input" placeholder="Password" required>
      </div>

      <div class="form__field">
        <input type="submit" value="Sign In">
      </div>

    </form>
		<p class="text--center"> <a style="color: red" href="forgotPassword.jsp?action=fdelivery">Forgot Password?</a></p>
        <p class="text--center">Not a member? <a style="color: red" href="deliveryRegister.jsp">Sign up now</a> <svg class="icon">
        <use xlink:href="#icon-arrow-right"></use>
      </svg></p>

  </div>

  <svg xmlns="http://www.w3.org/2000/svg" class="icons">
    <symbol id="icon-arrow-right" viewBox="0 0 1792 1792">
      <path d="M1600 960q0 54-37 91l-651 651q-39 37-91 37-51 0-90-37l-75-75q-38-38-38-91t38-91l293-293H245q-52 0-84.5-37.5T128 1024V896q0-53 32.5-90.5T245 768h704L656 474q-38-36-38-90t38-90l75-75q38-38 90-38 53 0 91 38l651 651q37 35 37 90z" />
    </symbol>
    <symbol id="icon-lock" viewBox="0 0 1792 1792">
      <path d="M640 768h512V576q0-106-75-181t-181-75-181 75-75 181v192zm832 96v576q0 40-28 68t-68 28H416q-40 0-68-28t-28-68V864q0-40 28-68t68-28h32V576q0-184 132-316t316-132 316 132 132 316v192h32q40 0 68 28t28 68z" />
    </symbol>
    <symbol id="icon-user" viewBox="0 0 1792 1792">
      <path d="M1600 1405q0 120-73 189.5t-194 69.5H459q-121 0-194-69.5T192 1405q0-53 3.5-103.5t14-109T236 1084t43-97.5 62-81 85.5-53.5T538 832q9 0 42 21.5t74.5 48 108 48T896 971t133.5-21.5 108-48 74.5-48 42-21.5q61 0 111.5 20t85.5 53.5 62 81 43 97.5 26.5 108.5 14 109 3.5 103.5zm-320-893q0 159-112.5 271.5T896 896 624.5 783.5 512 512t112.5-271.5T896 128t271.5 112.5T1280 512z" />
    </symbol>
  </svg>
  
   <%
            if (request.getParameter("success") != null) {%>
        <script>alert('Delivery Agent Registration Completed');</script>  
        <%}
        %>
        <%
            if (request.getParameter("no") != null) {%>
        <script>alert('Invalid Login Credentials');</script>  
        <%}
        %>
        <%
            if (request.getParameter("Inactive") != null) {%>
        <script>alert('Waiting for Activation! Please Contact Admin');</script>  
        <%}
        %>
        
        <% if(request.getParameter("passUpdate") != null){ %>
        	 <script>
             alert("Password Updated successfully!");
         </script>
         <% }
         %>

</body>
  
</body>
</html>
