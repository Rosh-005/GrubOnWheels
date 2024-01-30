<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- title -->
        <title>Grub On Wheels</title>

        
        <link rel="shortcut icon" type="image/png" href="Resources/assets/img/favicon.png">        
        <link rel="stylesheet" href="Resources/assets/css/all.min.css">        
        <link rel="stylesheet" href="Resources/assets/bootstrap/css/bootstrap.min.css">                
        <link rel="stylesheet" href="Resources/assets/css/main.css">
        <script src="https://api.mqcdn.com/sdk/place-search-js/v1.0.0/place-search.js"></script>
    	<link type="text/css" rel="stylesheet" href="https://api.mqcdn.com/sdk/place-search-js/v1.0.0/place-search.css"/>
     
        <style>
            .form {
                background: rgba(19, 35, 47, 0.9);
                padding: 40px;
                max-width: 600px;
                margin: 40px auto;
                border-radius: 4px;
                box-shadow: 0 4px 10px 4px rgba(19, 35, 47, 0.3);
            }

            .tab-group {
                list-style: none;
                padding: 0;
                margin: 0 0 40px 0;
            }
            .tab-group:after {
                content: "";
                display: table;
                clear: both;
            }
            .tab-group li a {
                display: block;
                text-decoration: none;
                padding: 15px;
                background: rgba(160, 179, 176, 0.25);
                color: #a0b3b0;
                font-size: 20px;
                float: left;
                width: 50%;
                text-align: center;
                cursor: pointer;
                transition: .5s ease;
            }
            .tab-group li a:hover {
                background: #f89827;
                color: #ffffff;
            }
            .tab-group .active a {
                background: #ff6600;
                color: #ffffff;
            }

            .tab-content > div:last-child {
                display: none;
            }

            h1 {
                text-align: center;
                color: #ffffff;
                font-weight: 300;
                margin: 0 0 40px;
            }

            label {
                position: absolute;
                transform: translateY(6px);
                left: 13px;
                color: rgba(255, 255, 255, 0.5);
                transition: all 0.25s ease;
                -webkit-backface-visibility: hidden;
                pointer-events: none;
                font-size: 22px;
            }
            label .req {
                margin: 2px;
                color: #ff6600;
            }

            label.active {
                transform: translateY(50px);
                left: 2px;
                font-size: 14px;
            }
            label.active .req {
                opacity: 0;
            }

            label.highlight {
                color: #ffffff;
            }

            input, textarea {
                font-size: 22px;
                display: block;
                width: 100%;
                height: 100%;
                padding: 5px 10px;
                background: none;
                background-image: none;
                border: 1px solid #a0b3b0;
                color: #ffffff;
                border-radius: 0;
                transition: border-color .25s ease, box-shadow .25s ease;
            }
            input[type="search"] {
                font-size: 22px;
                display: block;
                width: 103%;
                height: 100%;
                padding: 5px 10px;
                background: none;
                background-image: none;
                border: 1px solid #a0b3b0;
                color: #ffffff;
                border-radius: 0;
                transition: border-color .25s ease, box-shadow .25s ease;
            }
            input:focus, textarea:focus {
                outline: 0;
                border-color: #ff6600;
            }

            textarea {
                border: 2px solid #a0b3b0;
                resize: vertical;
            }

            .field-wrap {
                position: relative;
                margin-bottom: 40px;
            }

            .top-row:after {
                content: "";
                display: table;
                clear: both;
            }
            .top-row > div {
                float: left;
                width: 48%;
                margin-right: 4%;
            }
            .top-row > div:last-child {
                margin: 0;
            }

            .button {
                border: 0;
                outline: none;
                border-radius: 0;
                padding: 15px 0;
                font-size: 2rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: .1em;
                background: #ff6600;
                color: #ffffff;
                transition: all 0.5s ease;
                -webkit-appearance: none;
            }
            .button:hover, .button:focus {
                background: #f89827;
            }

            .button-block {
                display: block;
                width: 100%;
            }

            .forgot {
                margin-top: -20px;
                text-align: right;
            }
        </style>
        
        <script>
    // Function to validate the form
    function validateForm() {
        var phoneInput = document.getElementById("phone");
        var addressInput = document.getElementById("place-search-input");
        var emailInput = document.getElementsByName("emailid")[0];

        // Validation patterns
        var phonePattern = /^\d{10}$/;
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

        // Flags to track validation results
        var isPhoneValid = true;
        var isAddressValid = true;
        var isEmailValid = true;

        // Phone number validation
        if (!phonePattern.test(phoneInput.value)) {
            alert("Invalid phone number. Please enter a valid phone number.");
            isPhoneValid = false;
        } else {
            // Phone number is in the correct format, check if it exists in the database
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "PhoneNumberServlet?phone=" + phoneInput.value + "&action=userprofile", false); // Synchronous request
            xhr.send();
            if (xhr.status === 200) {
                console.log(xhr.responseText);
                if (xhr.responseText === "true") {
                    alert("Phone number already exists in the database.");
                    isPhoneValid = false;
                } else if (xhr.responseText.startsWith("invalid")) {
                    alert("Phone Number is invalid");
                    isPhoneValid = false;
                }
            }
        }

        // Address validation
        var address1 = addressInput.value;
        var apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K";
        var url = "http://www.mapquestapi.com/geocoding/v1/address?key=" + apiKey + "&location=" + encodeURIComponent(address1.replace(/ /g, '+'));

        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, false); // Synchronous request
        xhr.send();
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var locations = response.results[0].locations;
            if (locations.length > 0) {
                var geoCodeQuality = locations[0].geocodeQualityCode;
                if (!geoCodeQuality.startsWith("P") && !geoCodeQuality.startsWith("L")) {
                    alert('Enter a valid address');
                    isAddressValid = false;
                }
            } else {
                alert("Unable to validate address");
                isAddressValid = false;
            }
        } else {
            alert("Error validating address");
            isAddressValid = false;
        }

        // Email validation
        if (!emailPattern.test(emailInput.value)) {
            alert("Invalid email address. Please enter a valid email address.");
            isEmailValid = false;
        }

        console.log(isPhoneValid);
        console.log(isAddressValid);
        console.log(isEmailValid);

        // Enable or disable the submit button based on all validations
        if (isPhoneValid && isAddressValid && isEmailValid) {
            console.log("Hi");
            document.getElementById("submitButton").disabled = false;
        } else {
            console.log("hello");
            document.getElementById("submitButton").disabled = true;
        }
    }
</script>
        
    </head>
    <body>

        <!--PreLoader-->
        <div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
        <!--PreLoader Ends-->

        <!-- header -->
        <div class="top-header-area" id="sticker">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-sm-12 text-center">
                        <div class="main-menu-wrap">

                            <!-- menu start -->
                            <nav class="main-menu">
                                <ul>
                                    <li><a href="userHome.jsp">Hungry</a></li>
                                    <li><a href="userProfile.jsp">My Account</a></li>
                                    <li><a href="trackOrder.jsp">Order Tracking</a></li>
                                    <li><a href="orderHistory.jsp">Order History</a></li>
                                    <li><a href="userLogout.jsp">Logout</a></li>
                                    <li>
                                        <div class="header-icons">
                                            <a class="shopping-cart" href="userCart.jsp"><i class="fas fa-shopping-cart"></i></a>
                                        </div>
                                    </li>
                                </ul>
                            </nav>

                            <div class="mobile-menu"></div>
                            <!-- menu end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end header -->

        <!-- end search arewa -->

        <!-- breadcrumb-section -->
        <div class="breadcrumb-section breadcrumb-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 text-center">
                        <div class="breadcrumb-text">
                            <p>User Profile</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end breadcrumb section -->
        <%
            String userid = session.getAttribute("userid").toString();
            Connection con = DatabaseConnection.getconnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("Select * from users where id='" + userid + "'");
            rs.next();
            
        %>
        <!-- products -->
        <div class="product-section mt-150 mb-150">
            <div class="container">
                <div class="form">

                    <ul class="tab-group">
                        <h3 class="tab active" style="color: white">Profile Update</h3>
                        <li class="tab"></li>
                    </ul>

                    <div class="tab-content">
                        <div id="signup">   
                            <form action="UserProfileUpdate" method="post" id="profile" onsubmit="return validateForm()">
                                <div class="field-wrap">
                                    <label>
                                        Name<span class="req">*</span>
                                    </label><br><br>
                                    <input type="text"  value="<%=rs.getString("name")%> <%= rs.getString("lname")%>" required="" readonly="" autocomplete="off"/>
                                </div>
                                
                                <%String phone = rs.getString("phone");
                                String phoneNo = phone.substring(3);%>
                                
                                

                                <div class="field-wrap">
                                    <label>
                                        Phone<span class="req">*</span>
                                    </label><br><br>
                                    <input type="text" id="phone" name="phone" value="<%=phoneNo%>" onblur="validateForm()" required autocomplete="off"/>
                                </div>
                                
                                <div class="field-wrap">
                                    <label>
                                        Address<span class="req">*</span>
                                    </label><br><br>
                                    <input type="search" id="place-search-input" name="address" value="<%=rs.getString("address")%>" onblur="validateForm()" required autocomplete="off"/>
                                </div>
                                
                                <div class="field-wrap">
                                    <label>
                                        Email Address<span class="req">*</span>
                                    </label><br><br>
                                    <input type="text" name="emailid" value="<%=rs.getString("mailid")%>" onblur="validateForm()" required autocomplete="off"/>
                                </div>
                                
                                
                                <input type="hidden" name="pass" value="<%=rs.getString("pass")%>">

                                <!-- <div class="field-wrap">
                                    <label>
                                        Update Password<span class="req">*</span>
                                    </label> -->
                                    <button type="button" id="changePass">Change Password</button>
                                    <br><br>
                                    <div id="passwordFields" style="display:none">
                                    <input type="password" name="currentPass" placeholder="Current Password" id="currentPassInput" autocomplete="off"/> <br>
                                    <input type="password" name="newPass" placeholder="New Password" id="newPassInput" autocomplete="off"/> <br>
                                    <a id="showPassword" style="color: white">Show Password</a>
                                    </div>

                                </div>
                                <button type="submit" id="submitButton" class="button button-block" onclick="validateForm()">Update</button>
                            </form>
                            

                        </div>

                        <div id="login">   

                        </div>

                    </div><!-- tab-content -->

                </div> <!-- /form -->
            </div>
        </div>
        <!-- end footer -->

        <!-- copyright -->
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <p>Copyrights &copy; 2023,  All Rights Reserved.</p>
                    </div>
                    <div class="col-lg-6 text-right col-md-12">
                        <div class="social-icons">
                            <ul>
                                <li><a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-twitter"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-instagram"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-dribbble"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

 <%
            if (request.getParameter("ProfileUpdated") != null) {%>
        <script>alert('Profile Successfully Updated!');</script>  
        <%}
        %>
        <%
            if (request.getParameter("CurrentPass") != null) {%>
        <script>alert('Invalid Current Password');</script>  
        <%}
        %>
        <%
            if (request.getParameter("Failed") != null) {%>
        <script>alert('Profile Update Failed! Try Again');</script>  
        <%}
        %>

        <script src="Resources/assets/js/jquery-1.11.3.min.js"></script>       
        <script src="Resources/assets/js/jquery.isotope-3.0.6.min.js"></script>       
        <script src="Resources/assets/js/owl.carousel.min.js"></script>        
        <script src="Resources/assets/js/jquery.magnific-popup.min.js"></script>       
        <script src="Resources/assets/js/sticker.js"></script>        
        <script src="Resources/assets/js/main.js"></script>
        
        <script>
        var passwordFields = document.getElementById("passwordFields");
        var currentPassInput = document.getElementById("currentPassInput");
        var newPassInput = document.getElementById("newPassInput");

        document.getElementById("changePass").addEventListener("click", function() {
            if (passwordFields.style.display === "none") {
                passwordFields.style.display = "block";
                currentPassInput.required = true; // Set required
                newPassInput.required = true;
            } else {
                passwordFields.style.display = "none";
                currentPassInput.required = false; // Remove required
                newPassInput.required = false;
            }
        });                           /* When the user clicks on the button,
                                         toggle between hiding and showing the dropdown content */
                                        function myFunction() {
                                            document.getElementById("myDropdown").classList.toggle("show");
                                        }

                                        function filterFunction() {
                                            var input, filter, ul, li, a, i;
                                            input = document.getElementById("myInput");
                                            filter = input.value.toUpperCase();
                                            div = document.getElementById("myDropdown");
                                            a = div.getElementsByTagName("a");
                                            for (i = 0; i < a.length; i++) {
                                                txtValue = a[i].textContent || a[i].innerText;
                                                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                                    a[i].style.display = "";
                                                } else {
                                                    a[i].style.display = "none";
                                                }
                                            }
                                        }
        </script>
        <script>
        document.getElementById("showPassword").addEventListener("click", function() {
            var currentPassInput = document.getElementById("currentPassInput");
            var newPassInput = document.getElementById("newPassInput");
            
            if (currentPassInput.type === "password") {
                currentPassInput.type = "text";
                newPassInput.type = "text";
            } else {
                currentPassInput.type = "password";
                newPassInput.type = "password";
            }
        });

        document.getElementById("profile").addEventListener("submit", function(event) {
            var newPasswordInput = document.getElementById("newPassInput");
            var newPasswordPattern = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,20}$/;

            if (newPasswordInput.style.display !== "none" && newPasswordInput.value.trim() !== "" && !newPasswordPattern.test(newPasswordInput.value)) {
                alert("Password must be of 8 to 20 characters and contain atleast 1 digit, lowercase, uppercase and special character");
                event.preventDefault(); // Prevent form submission
            }
        });

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
