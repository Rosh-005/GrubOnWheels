<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grub On Wheels</title>

    <!-- Leaflet CSS -->
     <link rel="shortcut icon" type="image/png" href="Resources/assets/img/favicon.png">        
        <link rel="stylesheet" href="Resources/assets/css/all.min.css">        
        <link rel="stylesheet" href="Resources/assets/bootstrap/css/bootstrap.min.css">        
        <link rel="stylesheet" href="Resources/assets/css/main.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <script src="Resources/assets/js/jquery-1.11.3.min.js"></script> 
    

    <!-- MapQuest JavaScript API -->
    <script src="https://api.mqcdn.com/sdk/mapquest-js/v1.3.2/mapquest.js"></script>
    <link rel="stylesheet" type="text/css" href="https://api.mqcdn.com/sdk/mapquest-js/v1.3.2/mapquest.css">
    
    
    
    <style>
        body {
            margin: 0;
            padding: 0;
        }
        #outerdiv {
            width: 90%;
            height: 90%;
            position: relative;
            text-align: center;
        }
        #map {
            width: 70%;
            height: 70%;
            margin: 0px auto;
            display: inline-block;
            margin-top: 50px;
        }
    </style>
</head>

<body>
<div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
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
        
        <div class="breadcrumb-section breadcrumb-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 text-center">
                        <div class="breadcrumb-text">
                            <p>Order Tracking</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% String userid = session.getAttribute("userid").toString();
        String useraddress = session.getAttribute("useraddress").toString();
        Connection conn = DatabaseConnection.getconnection();
        Statement stmt = conn.createStatement();
        String orderID = "";
        try{
        	ResultSet rs = stmt.executeQuery("Select distinct oid from useroders where uid = '"+userid+"' and dastatus = 'Picked Up' order by id desc");
        	if(rs.next()){
        		orderID = rs.getString("oid");
        		%>
        		<form action="">
        		<input type="hidden" name="ordId" id="ordId" value="<%=orderID%>">
        		<input type="hidden" name="useraddress" id="useraddress" value="<%=useraddress%>">
        		</form>
        		<h2 style="text-align:center;margin-top:20px;">Hoorayyy!!!</h2>
        		<h2 style="text-align:center;margin-top:20px;">Your Order <%=orderID %> is being delivered</h2>
        		<div id="outerdiv">
                <div id="map"></div>
            </div>
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
        	} else{
        		%>
            	<h1 style="text-align:center">No Orders to track</h1>	
            	<% 
        	}
        } catch(Exception e){
        	e.printStackTrace();
        }
        %>
    
    

	<script src="Resources/assets/js/jquery-1.11.3.min.js"></script>       
        <script src="Resources/assets/js/jquery.isotope-3.0.6.min.js"></script>       
        <script src="Resources/assets/js/owl.carousel.min.js"></script>        
        <script src="Resources/assets/js/jquery.magnific-popup.min.js"></script>       
        <script src="Resources/assets/js/sticker.js"></script>        
        <script src="Resources/assets/js/main.js"></script>
         
    <script>
    
    
        // MapQuest API key
        L.mapquest.key = 'ya6sZIGXQmptSdkturD1l3391gYfRG6K';
        var orderID = document.getElementById("ordId").value;

        // Map initialization
          
        var map = L.mapquest.map('map', {
            center: [14.0860746, 100.608406],
            layers: L.mapquest.tileLayer('map'),
            zoom: 17
        });

        var userMarker;
        var agentPath;
        var userAddress = document.getElementById("useraddress").value;

        function fetchUserCoordinates(userAddress) {
            $.ajax({
                type: "GET",
                url: "GeocodeServlet", 
                data: { userAddress: userAddress },
                dataType: "json",
                success: function (response) {
                    if (response.status === 'OK') {
                        var userLat = response.latitude;
                        var userLng = response.longitude;

                        if (userMarker) {
                            userMarker.setLatLng([userLat, userLng]);
                        } else {
                            userMarker = L.marker([userLat, userLng]).addTo(map);
                        }

                        console.log("User's coordinate: Lat: " + userLat + " Long: " + userLng + " User Address: " + userAddress);

                        if (agentPath && agentPath.getLatLngs().length > 0) {
                            calculateAndDisplayRoute();
                        }
                    } else {
                        console.error("Geocoding did not return valid results.");
                    }
                },
                error: function (error) {
                    console.error("Error fetching user coordinates:", error);
                }
            });
        }

        fetchUserCoordinates(userAddress);
       
            
         
        function updateAgentLocation(agentLat, agentLng) {

        	if (!agentPath) {
                agentPath = L.polyline([], { color: 'blue' }).addTo(map);
            }
            // Add the updated agent position to the agent's path
            agentPath.addLatLng([agentLat, agentLng]);
            
            console.log("Agent's coordinate updated: Lat: " + agentLat + " Long: " + agentLng);
        }

        function fetchAgentLocation(orderid) {
            $.ajax({
                type: "GET",
                url: "GetDeliveryLocation",
                dataType: "json",
                data: {
                    orderID: orderid
                },
                success: function(response) {
                    var agentLat = parseFloat(response.latitude);
                    var agentLng = parseFloat(response.longitude);

                    updateAgentLocation(agentLat, agentLng);

                    if (userMarker && agentPath.getLatLngs().length > 0) {
                        calculateAndDisplayRoute();
                    }
                },
                error: function(error) {
                    console.error("Error fetching agent location:", error);
                }
            });
        }

        

        function calculateAndDisplayRoute() {
        	if (userMarker && agentPath) {
            var userLatLng = userMarker.getLatLng();
            var agentLatLngs = agentPath.getLatLngs();

            if (userLatLng && agentLatLngs.length > 0) {
                L.mapquest.directions().route({
                    start: [agentLatLngs[0].lat, agentLatLngs[0].lng],
                    end: [userLatLng.lat, userLatLng.lng]
                });
            }
        }
        }
        
        
        setInterval(function () {
            fetchAgentLocation(orderID);
        }, 5000);
    </script>
</body>

</html>
