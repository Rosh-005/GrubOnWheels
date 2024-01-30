<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta charset="UTF-8">
        <title>Grub On Wheels</title>
        <script src="https://api.mqcdn.com/sdk/place-search-js/v1.0.0/place-search.js"></script>
    <link type="text/css" rel="stylesheet" href="https://api.mqcdn.com/sdk/place-search-js/v1.0.0/place-search.css"/>
        <style>
body {
	background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/1.jpeg);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
}

.alin {
	display: inline-block;
	width: 150px;
}
</style>
        <link rel="stylesheet" href="Resources/style.css">

    </head>
    <body>
    <body class="align">
    <a href="index.jsp" id="home-icon" class="home-icon" style="position: absolute; top: 0px; left: 0px;">
            <img src="Resources/images/homeicon.png" alt="Home Icon" width="40" height="40">
        </a>
        <h1 style="font-size: 60px;margin-top: 60px; color:white">Grub On Wheels🚚</h1>
        <div class="grid" style="margin-bottom: 200px ;width: 900px">
            <form action="RestaurantRegister" method="POST" class="form login" name="register" enctype='multipart/form-data'>

                <div class="form__field">
                    <input autocomplete="" id="login__username" type="text" name="restname" class="form__input" placeholder="Restaurant Name" required>
                </div>
               
                <div class="form__field">
                     <p style="color: white"><strong>Restaurant Photo</strong></p>
                    <input autocomplete="" id="login__username" type="file" name="restaurantphoto" class="form__input" placeholder="Restaurant Name" required>
                </div>
                <div class="form__field">
                    <input autocomplete="username" id="login__username" type="email" name="email" class="form__input" placeholder="Mail Id" required>
                </div>
                <div class="form__field">

                    <input autocomplete="username" id="phone" type="text" name="phone" class="form__input" placeholder="Phone Number" required>
                </div>
                
                <div class="form__field">
    				<input autocomplete="username" name="address" type="search" id="place-search-input" class="form__input" style="background-color: #3b4148" placeholder="Start Searching..." required="required" onkeydown="return validatePhoneNo(document.register.phone, 'restaurant')">
                </div>
                
				<!-- <div class="form__field">
                    <input autocomplete="username" id="login__username" type="text" name="address1" class="form__input" placeholder="Address Line 1" required="required" onkeydown="return validatePhoneNo(document.register.phone)">
                </div>
                <div class="form__field">

                    <input autocomplete="username" id="login__username" type="text" name="address2" class="form__input" placeholder="Address Line 2">
                </div> -->
                
                <div class="form__field">

                    <input autocomplete="username" id="login__username" type="text" name="city" class="form__input" placeholder="City" onkeydown="return validateAddress()" required>
                </div>
                <!-- <div class="form__field">

                    <input autocomplete="username" id="login__username" type="text" name="postcode" class="form__input" placeholder="Post Code" required>
                </div> -->

                <div class="form__field">

                    <input autocomplete="Admin Name" id="login__username" type="text" name="username" class="form__input" placeholder="User Name" required>
                </div>
                <div class="form__field">
                <div class="password-container">

                <input id="password" type="password" name="pass" class="form__input" placeholder="Password" required>
                <span class="toggle-icon" id="showPassword" onclick="return togglePassword()"><img alt="eyeicon" src="Resources/images/icons8-eye-64.png" width="30" height="30"></span>
                </div></div>
                
				
				<div class="form__field">
				<div class="password-container">

                    <input id="cpassword" type="password" name="cpass" class="form__input" placeholder="Confirm Password" required onkeydown="return validatePassword(document.register.password)">
               <span class="toggle-icon1" id="showCPassword" onclick="return toggleCPassword()"><img alt="eyeicon" src="Resources/images/icons8-eye-64.png" width="30" height="30"></span>
                </div>
                </div>

                <div class="form__field">
                    <input type="submit" value="Register" onclick="return checkPassword()">
                </div>

            </form>

            <p class="text--center">Already a member? <a style="color: red" href="restaurantLogin.jsp">Login</a> 

        </div>
        
        <%
            if (request.getParameter("username") != null) {%>
        <script>alert('User Name Already Exist');</script>  
        <%}
        %>
         <%
        if (request.getParameter("failure") != null) {%>
    <script>alert('Restaurant Registration Failed');</script>  
    <%}
        %>
        <% if(request.getParameter("InvalidAddress") != null){ %>
        	 <script>
             alert("Invalid Address");
         </script>
         <% }
         %>

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

<script src="Resources/LandingPage/js/app.js"></script>
<script>
        document.addEventListener('DOMContentLoaded', function() {
            const placeSearchInput = document.querySelector('#place-search-input');
            
            placeSearch({
                key: 'ya6sZIGXQmptSdkturD1l3391gYfRG6K',
                container: placeSearchInput,
                options: {
                    size: 'sm',
                    focusOnClose: true
                },
                responseCallback: function(data) {
                    if (data.result) {
                        const location = data.result;
                        const formattedAddress = location.displayString;
                        placeSearchInput.value = formattedAddress;
                    } else {
                        alert('No results found.');
                    }
                }
            });
        });

        function validateAddress() {
    		var address1 = document.getElementById("place-search-input").value;
            console.log("Address: ",address1);
            
            var xhr = new XMLHttpRequest();
            var apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K"; 
            var url = "http://www.mapquestapi.com/geocoding/v1/address?key=" +
                      apiKey + "&location=" + encodeURIComponent(address1.replace(/ /g, '+'));

            xhr.open("GET", url, true); 
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        var locations = response.results[0].locations;
                        if (locations.length > 0) {
                            var geoCodeQuality = locations[0].geocodeQualityCode;
                            if (geoCodeQuality.startsWith("P") || geoCodeQuality.startsWith("L")) {
                                handleValidationResult("Valid");
                            } else {
                                handleValidationResult("Invalid");
                            }
                        } else {
                            handleValidationResult("Unable to validate");
                        }
                    } else {
                        handleValidationResult("Error");
                    }
                }
            };
            xhr.send();
        }

        function handleValidationResult(result) {
        	
            if (result === "Valid") {
            	
                document.querySelector("input[type='submit']").disabled = false;
            } else {
                document.querySelector("input[type='submit']").disabled = true;
                alert('Enter a valid address');
            }
        }
    	
    </script>

</body>
</body>
</html>

