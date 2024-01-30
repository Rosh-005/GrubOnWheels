<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registration Form</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body{
                background-color: black;
                 /* overflow: scroll; */
                 background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/delivery.jpg);
				 background-repeat: repeat;
	             background-size: cover;
	             background-position: center;
            }
            .head{
                position:absolute;
                top:0px;
                left: 0px;
                margin: 0px;
                text-align: center;
                background-color: none;
                width: 100%;
                color:white;
            }
            .content{
                position: relative;
                padding:18px;
                margin: 4px;
                top:30px;
                left: 350px;
                width: 500px;
                height: auto;
                border:2px solid deeppink;
                border-radius: 25px;
                box-shadow: 3px 5px pink;
                background-color: black;
            }
            font{
                font-size: 24px;
                color: pink;
                
            }
            form{
                font-size: 18px;
            }
            .content input[type="text"]{
                height: 30px;
                width: 450px;
                box-sizing: border-box;
                border:1px solid #ff6600;
                border-radius: 25px;
                text-align: center;
                font-size: 16px;
            }
            .content input[type="date"]{
                height: 30px;
                width: 450px;
                box-sizing: border-box;
                border:1px solid #ff6600;
                border-radius: 25px;
                text-align: center;
                font-size: 16px;
            }
            .content input[type="email"]{
                height: 30px;
                width: 450px;
                box-sizing: border-box;
                border:1px solid #ff6600;
                border-radius: 25px;
                text-align: center;
                font-size: 16px;
            }
            .content input[type="password"]{
                height: 30px;
                width: 450px;
                box-sizing: border-box;
                border:1px solid #ff6600;
                border-radius: 25px;
                text-align: center;
                font-size: 16px;
            }
            .content input[type="file"]{
                height: 30px;
                width: 450px;
                box-sizing: border-box;
                border:1px solid #ff6600;
                border-radius: 25px;
                text-align: center;
                font-size: 16px;
            }
            .content input::placeholder{
                color:#CCC;
                font-size: 18px;
            }
            textarea{
                font-size: 16px;
                width: 440px;
            }
            .content select{
                height: 30px;
                width: 450px;
                box-sizing: border-box;
                border:1px solid #ff6600;
                border-radius: 25px;
                text-align: center;
                font-size: 16px;
            }
            .content input[type="submit"]{
                font-size: 20px;
                text-align:center;
                float: center;
                padding: 8px;
                width: 120px;
                border:1px solid pink;
                border-radius: 20px;
                background-color:white;
                color: deeppink;
                cursor: pointer;
            }
            .content input[type="reset"]{
                font-size: 20px;
                text-align:center;
                float: center;
                padding: 8px;
                border: 8px;
                width: 120px;
                border:1px solid pink ;
                border-radius: 20px;
                background-color: white;
                color: deeppink;
                cursor: pointer;
            }
            .content input[type="submit"]:hover{
                color:white;
                background-color: deeppink;
            }
            .content input[type="reset"]:hover{
                color:white;
                background-color: deeppink;
            }
            .password-container .toggle-icon {
	            position: absolute;
	            top: 76%;
	            right: 50px;
	            transform: translateY(-50%);
	            cursor: pointer;
        }
        
			.password-container .toggle-icon1 {
	            position: absolute;
	            top: 84.4%;
	            right: 50px;
	            transform: translateY(-50%);
	            cursor: pointer;
        }
        </style>
        <!-- <link rel="stylesheet" href="Resources/styles1.css"> -->
    </head>
    <body>
    <a href="index.jsp" class="home-icon" style="position: absolute; top: 0px; left: 0px;">
            <img src="Resources/images/homeicon.png" alt="Home Icon" width="40" height="40" style="float:left">
        </a>
        
        <div class="content">
            <font><b>Registration form</b></font><br><br>
            <center><form action="DeliveryRegister" method="post" name="delreg" enctype="multipart/form-data">
                <b style="color:white">Agent First Name</b><br> <input type="text" name="name"  placeholder="Agent First name"  required="required"><br><br>
                <b style="color:white">Agent Last Name</b><br> <input type="text" name="lname"  placeholder="Agent Last name"  required="required"><br><br>
                <b style="color:white">Agent Photo</b><br> <input type="file" style="color:white" name="pic"  placeholder="Agent Pic" required="required"><br><br>
                <b style="color:white">Date of Birth</b><br> <input type="date" name="dob"  placeholder="DOB" required><br><br>

                <b style="color:white">Gender :</b> <input type="radio" name="gender" value="Male" ><b style="color:white">Male</b><input type="radio" name="gender" value="Female"><b style="color:white">Female</b><br>
                <br>
                <b style="color:white">Email</b><br> <input type="email" name="mail"  placeholder="Email" required="required"><br><br>
                
                <b style="color:white">City</b> <br> 
                <select name="city">
                    <optgroup label="Choose the city">
                        <%
                            Connection con = DatabaseConnection.getconnection();
                            Statement st = con.createStatement();
                            try {
                                ResultSet rs = st.executeQuery("Select * from restaurants GROUP BY city");
                                while (rs.next()) {

                        %>
                        <option value="<%=rs.getString("city")%>"><%=rs.getString("city")%></option>
                        <%                                        }
                                rs.close();
                                con.close();
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }

                        %>
                    </optgroup>
                </select><br><br>
                
                <b style="color:white">Phone</b><br> <input type="text" name="phone" id="phone" placeholder="Phone Number" required="required"><br><br>
                <div class="password-container">
                <b style="color:white">Password</b><br> <input type="password" id="password" name="pass"  placeholder="Password" required="required" onkeydown="return validatePhoneNo(document.delreg.phone, 'delivery')"><br><br>
                <span class="toggle-icon" id="showPassword" onclick="return togglePassword()"><img alt="eyeicon" src="Resources/images/icons8-eye-64.png" width="30" height="30"></span>
                </div>
                <div class="password-container">
                <b style="color:white">Confirm Password</b><br> <input type="password" id="cpassword" name="cpass"  placeholder="Confirm Password" required="required" onkeydown="return validatePassword(document.delreg.password)"><br><br>
                <span class="toggle-icon1" id="showCPassword" onclick="return toggleCPassword()"><img alt="eyeicon" src="Resources/images/icons8-eye-64.png" width="30" height="30"></span>
                </div>
                <input type="submit" name="submit" value="Register" onclick="return checkPassword()">
                <input type="reset" name="reset" value="Cancel" onclick="myFunction()">
                <br>
                <br>
                <b style="color:white">Already Registered??</b><a href="deliveryLogin.jsp" style="color:white"> Login</a>
                </form></center>
        </div>
        <script type="text/javascript">
            function myFunction() {
                alert("Registration Cancelled!");
            }
        </script>
        <%
            if (request.getParameter("phone") != null) {%>
        <script>alert('Phone Number or Email Already Exist');</script>  
        <%}
        %>
        <%
        if (request.getParameter("no") != null) {%>
    <script>alert('Delivery Agent Registration Failed');</script>  
    <%}
        %>
<script src="Resources/LandingPage/js/app.js"></script>
    </body>
</html>