<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Grub On Wheels</title>
        <style type="text/css">
body {
	background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/userLogin.jpg);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
}
</style>
        <link rel="stylesheet" href="Resources/LandingPage/css/style.css">
        <link rel="stylesheet" href="Resources/styles1.css">
    </head>
    <body>
        <div id="overlay"></div>
        <div id="sidebar">
            <div id="sidebar-content">
                 <a href="" class="margin-bottom" id="close-sidebar"><strong>X</strong></a>
                <div id="sidebar-login" class="display-flex-row">
                    <div>
                        <p>Login</p>
                        <a href="userSignup.jsp">or create an account</a>
                    </div>  
                    <img src="Resources/LandingPage/img/img-9.webp" alt="">
                </div>
                <form action="UserLogin" method="post" id="login-form">
                    <input type="text" name="phone" id="phone-no" placeholder="Phone Number" required="required">
                    <input type="password" name="pass" id="phone-no" placeholder="Password" required="required">
                    <input type="submit" value="Login" id="login-submit">
                </form>
                <p class="text--center"> <a style="color: red" href="forgotPassword.jsp?action=fuser">Forgot Password?</a></p>
            </div>
        </div>
        <%
            if (request.getParameter("success") != null) {%>
        <script>alert('User Registration Completed');</script>  
        <%}
        %>
        <%
            if (request.getParameter("phone") != null) {%>
        <script>alert('Phone Number Already Exist');</script>  
        <%}
        %>
        <%
            if (request.getParameter("no") != null) {%>
        <script>alert('Invalid User Credentials');</script>  
        <%}
        %>
        
        <% if(request.getParameter("passUpdate") != null){ %>
        	 <script>
             alert("Password Updated successfully!");
         </script>
         <% }
         %>
        <a href="index.jsp" id="home-icon" class="home-icon">
            <img src="Resources/images/homeicon.png" alt="Home Icon" width="40" height="40">
        </a>
    <center><h1 style="font-size: 40px; color: orange">Grub On Wheels🚚</h1></center>
            <div class="display-flex-row" style="padding-left:  350px">
                <div id="header-content-1" >
                    <div  class="display-flex-row margin-bottom ">
                       
                        <div id="log-sign" style="">
                            <a href="#" id="login" style="color:white">Login</a>&nbsp;&nbsp;&nbsp;&nbsp;
                           <a href="userSignup.jsp" id="sign-up">Sign up</a>
                        </div>
                    </div>    
                    <h1 id="topic" style="color:white">Hey There !!!</h1> 
                    <h2 style="color:white">Order food from favourite restaurants near you</h2> 
                    <div id="location" style="width: 400px">
                        <input type="submit" value="Find Foods" id="find-food">
                    </div>
                    <h2 style="color:white">Popular Cities in UK</h2>
                    <div id="cities">
                        <ul>
                            <li><a href=""><h4 style="color:white">Leicester</h4> </a></li>	
                            <li><a href=""><h4 style="color:white">London</h4></a></li>
                            <li><a href=""><h4 style="color:white">Birmingham</h4></a></li>
                            <li><a href=""><h4 style="color:white">& many more</h4></a></li>
                        </ul>
                    </div>
                </div>  
                <div id="header-content-2"></div>
            </div>
        </header>
        <section id="section-1">
            <div class="container">
                <div id="section-1-content" class="display-flex-row">
                    <div class="section-1-item">
                        <img src="Resources/LandingPage/img/img-1.webp" class="margin-bottom"  alt="No minimum order" style="height:220px;">
                        <h3>No Minimum order</h3>
                        <p>Order in for yourself or for the group, with no restrictions on order value</p>
                    </div>
                    <div class="section-1-item">
                        <img src="Resources/LandingPage/img/img-2.webp" class="margin-bottom" style="height:220px;" alt="Live Order Tracking">
                        <h3>Live Order Tracking</h3>
                        <p>Know where your order is at all times, from the restaurant to your doorstep</p>
                    </div>
                    <div class="section-1-item">
                        <img src="Resources/LandingPage/img/img-3.webp" class="margin-bottom" style="height:220px;" alt="Lightning_fast Delivery">
                        <h3>Lightning-Fast Delivery</h3>
                        <p>Experience superfast delivery for food delivered fresh & on time</p>
                    </div>
                </div>  
            </div>  
        </section>
        <section id="section-3" class="bg-1">
            <div class="container">
                <div id="section-3-content">
                    <div id="section-3-item-1" class="display-flex-row">
                        <div id="item-1" class="item">
                            <h3 class="margin-bottom">Company</h3>
                            <ul>
                                <li><a href="index.jsp">About us</a></li>

                            </ul>
                        </div>
                        <div id="item-2" class="item">
                            <h3 class="margin-bottom">Contact</h3>
                            <ul>
                                <li><a href="">Help & Support</a></li>

                            </ul>
                        </div>
                        <div id="item-3" class="item">
                            <h3 class="margin-bottom">Legal</h3>
                            <ul>
                                <li><a href="">Terms & Conditions</a></li>

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="Resources/LandingPage/js/app.js"></script>
    </body>
</html>
