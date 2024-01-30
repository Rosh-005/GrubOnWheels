<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Grub On Wheels</title>
<script src="https://api.mqcdn.com/sdk/place-search-js/v1.0.0/place-search.js"></script>
    <link type="text/css" rel="stylesheet" href="https://api.mqcdn.com/sdk/place-search-js/v1.0.0/place-search.css"/>
<style type="text/css">

body {
	background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/1.jpeg);
	background-repeat: no-repeat;
	background-size: contain;
	background-position: relative;
}
.mq-place-search{
	width: 360px !important;
}
.mq-place-search input[type="search"]{
	width: 360px !important;
}
.mq-place-search .mq-dropdown-menu {
    width: 360px !important;
}
</style>

<link rel="stylesheet" href="Resources/LandingPage/css/style.css">

<!-- <link rel="stylesheet" href="Resources/styles1.css"> -->
</head>
<body onload="document.signup.phone.focus()">
	<div id="overlay"></div>
	<div id="sidebar">
		<div id="sidebar-content">
			<a href="" class="margin-bottom" id="close-sidebar"><strong>X</strong></a>
			<div id="sidebar-login" class="display-flex-row">
				<div>
					<p>Login</p>
					<a href="">or create an account</a>
				</div>
				<img src="Resources/LandingPage/img/img-9.webp" alt="">
			</div>
			<form action="UserLogin" method="post" id="login-form">
				<input type="text" name="phone" id="phone-no"
					placeholder="Phone Number" required="required"> <input type="password"
					name="pass" id="phone-no" placeholder="Password" required="required"> <input
					type="submit" value="Login" id="login-submit">
			</form>
			<p class="text--center"> <a style="color: red" href="forgotPassword.jsp?action=fuser">Forgot Password?</a></p>
		</div>
	</div>
	<a href="index.jsp" id="home-icon" class="home-icon">
            <img src="Resources/images/homeicon.png" alt="Home Icon" width="40" height="40">
        </a>
	<header id="header1">
	
		<center>
			<h1 style="font-size: 40px; color: orange">Grub On Wheels🚚</h1>
		</center>
		<div class="display-flex-row" style="padding-left: 350px">
			<div id="header-content-1">
				<div class="display-flex-row margin-bottom ">

					<div id="log-sign" style="">
						<a href="#" id="login" style="color: white">Login</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<!--  <a href="userSignup.jsp" id="sign-up">Sign up</a> -->
					</div>
				</div>

				<% if (request.getParameter("phNoExist") != null) { %>
				<script>
            alert("Phone Number Already Exist!!! Please Log-in");
        </script>
				<% } else if(request.getAttribute("error1") != null) { %>
			<script>
            alert("<%= request.getAttribute("error1") %>");
        </script>
         <%  } %>
         
         <% if(request.getParameter("InvalidAddress") != null){ %>
        	 <script>
             alert("Invalid Address");
         </script>
         <% }
         %>
				
				<h1 style="color: white">
					<strong>User Registration</strong>
				</h1>
				<div id="location" style="width: 600px">
					<form action="UserRegister" method="post" id="userSignUp" name="signup">
						<input type="text" name="name" id="address"
							placeholder="First Name" required="required"><br>
						<br> <input type="text" name="lname" id="address"
							placeholder="Last Name" required="required"><br>
						<br> <input type="email" name="email" id="address"
							placeholder="Email" required="required"><br>
						<br> <input type="text" name="phone" id="address"
							placeholder="Phone Number" required="required"><br>
						<br><input type="search" name="address1" id="place-search-input" onkeydown="return validatePhoneNo(document.signup.phone,'user')"
							placeholder="Address" style="width: 400px required="required"><br>
						<br> <div class="password-container">
						<input type="password" name="password" id="password" onkeydown="return validateAddress()"
							placeholder="Password" required="required">
							<span class="toggle-icon" id="showPassword" onclick="return togglePassword()"><img alt="eyeicon" src="Resources/images/icons8-eye-64.png" width="30" height="30"></span>
							</div><br>
						<div class="password-container">
						<input type="password" name="cpassword" id="cpassword" onkeydown="return validatePassword(document.signup.password)"
							placeholder="Confirm Password" required="required">
							<span class="toggle-icon1" id="showCPassword" onclick="return toggleCPassword()"><img alt="eyeicon" src="Resources/images/icons8-eye-64.png" width="30" height="30"></span>
							</div>
						<br> <input type="submit" value="Register" id="find-food" onclick="return checkPassword()">
					</form>
				</div>
				<h3 style="color: white">Popular Cities in UK</h3>
				<div id="cities">
					<ul>
						<li><a href="" style="color: white">Leicester </a></li>
						<li><a href="" style="color: white">London</a></li>
						<li><a href="" style="color: white">Birmingham</a></li>
						<li><a href="" style="color: white">& many more</a></li>
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
					<img src="Resources/LandingPage/img/img-1.webp"
						class="margin-bottom" alt="No minimum order"
						style="height: 220px;">
					<h3>No Minimum order</h3>
					<p>Order in for yourself or for the group, with no restrictions
						on order value</p>
				</div>
				<div class="section-1-item">
					<img src="Resources/LandingPage/img/img-2.webp"
						class="margin-bottom" style="height: 220px;"
						alt="Live Order Tracking">
					<h3>Live Order Tracking</h3>
					<p>Know where your order is at all times, from the restaurant
						to your doorstep</p>
				</div>
				<div class="section-1-item">
					<img src="Resources/LandingPage/img/img-3.webp"
						class="margin-bottom" style="height: 220px;"
						alt="Lightning_fast Delivery">
					<h3>Lightning-Fast Delivery</h3>
					<p>Experience superfast delivery for food delivered
						fresh & on time</p>
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
							<li><a href="">About us</a></li>

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
	
	<script>

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
    </script>
</body>
</html>
