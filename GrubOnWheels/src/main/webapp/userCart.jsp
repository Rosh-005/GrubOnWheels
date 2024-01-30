<%@page import="java.text.DecimalFormat"%>
<%@page import="actions.DistanceCalculator"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="model.User"%>
<%@page import="controller.DBControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.UserCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- title -->
        <title>User Cart</title>

        <!-- favicon -->
        <link rel="shortcut icon" type="image/png" href="Resources/assets/img/favicon.png">        
        <link rel="stylesheet" href="Resources/assets/css/all.min.css">       
        <link rel="stylesheet" href="Resources/assets/bootstrap/css/bootstrap.min.css">        
        <link rel="stylesheet" href="Resources/assets/css/main.css">

		<style>
        .address-class {
            display: none;
        }
    </style>
    
    </head>
    <body>
    
    <%
            if (request.getParameter("Success") != null) {%>
        <script>alert('Payment Success');</script>  
        <%}
        %>
        

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
                            <p>Fresh and Organic</p>
                            <h1>Cart</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end breadcrumb section -->

        <!-- cart -->
        <div class="cart-section mt-150 mb-150">
            <div class="container">
                <form action="paymentForm.jsp" id="" method="POST">
                    <div class="row">
                        <div class="col-md-12">
                              
                            
                                    
                                        <%

                                            DBControl control = new DBControl();
                                            ArrayList<User> arrCus = control.selectAllUsers();
                                            
                                        %>
                                        <%
                                            double orderSum = 0.0;
                                        	String resid = null;
                                        	String city = null;
                                            ArrayList<UserCart> userArray = new ArrayList<UserCart>();
                                            Connection conn = DatabaseConnection.getconnection(); 
                                            Statement stmt = conn.createStatement();
                                            String uid = session.getAttribute("userid").toString();
                                            ResultSet rs = stmt.executeQuery("Select * from usercart where userid = '"+uid+"'");
                                            if(rs.next() == false){
                                            	%>
                                            	<h1>Your Cart is Empty</h1>	
                                            	<% 
                                            }
                                            rs.beforeFirst();
                                            
                                            while(rs.next()){
                                            	String restid = rs.getString("restid");
                                            	String restname = rs.getString("restname");
                                            	String restaddress = rs.getString("restaddress");
                                            	String dishid = rs.getString("dishid"); 
                                            	String dishname = rs.getString("dishname"); 
                                            	String cartcity = rs.getString("city");
                                            	int dishquantity = rs.getInt("quantity"); 
                                            	double dishprice = Double.parseDouble(rs.getString("price")); 
                                            	
                                             	userArray.add(new UserCart(dishid,dishname,dishprice,dishquantity,restid,restname,cartcity));
                                            }
                                            
                                            if(!(userArray.isEmpty())){	
                                            	session.setAttribute("userCart", userArray);
                                            	if(session.getAttribute("resid") != null && session.getAttribute("city") != null){
                                            	resid = session.getAttribute("resid").toString();
                                            	city = session.getAttribute("city").toString();
                                            	}
                                            	if(resid != null && city != null){
                                                %>
                                                 <a href="restaurantMenu.jsp?id=<%=resid%>&city=<%=city%>" class="bordered-btn" style="color: black">Back to Menu</a>
                                                 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%} %><a href="clearCart.jsp?uid=<%=uid%>" class="bordered-btn" style="color: black">Clear Cart</a>
                                                <%                                                                                              
                                                 
                                               %> 
                                                <div class="cart-table-wrap">
                                <table class="cart-table">
                                    <thead class="cart-table-head">
                                        <tr class="table-head-row">
                                            <th class="product-remove"></th>
                                            <th class="product-image">Dish Image</th>
                                            <th class="product-name">Name</th>
                                            <th class="product-name">Restaurant</th>
                                            <th class="product-name">City</th>	
                                            <th class="product-quantity">Quantity</th>
                                            <th class="product-total">Price</th>
                                        </tr>
                                    </thead>
                                                
                                            <%    for (int i = 0; i < userArray.size(); i++) {
                                                    orderSum += (userArray.get(i).getQuantity() * userArray.get(i).getDishPrice());
                                        %> 
                                        
                                        
                                        
                                 <%-- <div class="restaurant-links">
    							<% for (int r = 0; r < restaurantIds.size(); r++) { %>
        						<a href="#" class="restaurant-link" data-resid="<%= restaurantIds.get(r) %>">
            					<%= restaurantNames.get(r) %>
        						</a>
    							<% } restaurantIds.clear();%>
								</div> --%>
                                     
                                <tbody id="cart-items-container">
                                        <tr class="table-body-row">
                                            <td class="product-remove"><a href="clearCart.jsp?uid=<%=uid%>&did=<%=userArray.get(i).getDishID()%>"><i class="far fa-window-close"></i></a></td>
                                            <td class="product-image"><img src="menuImg.jsp?mid=<%= userArray.get(i).getDishID()%>" alt=""></td>
                                            <td class="product-name"><%= userArray.get(i).getDishName()%></td>
                                            <td class="product-name"><%= userArray.get(i).getRestaurantName()%></td>
                                            <td class="product-name"><%= userArray.get(i).getCity()%></td>
                                            <td class="product-quantity"><%= userArray.get(i).getQuantity()%></td>
                                            <td class="product-total">£ <%= userArray.get(i).getDishPrice()%></td>
                                        </tr>
                                    
                                    <%     
                                    } }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                                    <br>
                                    <br>
                                    <br>
                                    
                                    
                                    
                                 <% Statement stmt1 = conn.createStatement();
                                 Statement stmt2 = null;
                                 Statement stmt3 = conn.createStatement();
                                 String userAddress = "";
                                 String restaurantAddress = "";
                                 double deliveryFee = 0.0;
                                 ResultSet rs1 = stmt1.executeQuery("Select * from users where id = '"+uid+"'");
                                 if(rs1.next()){
                                 	userAddress = rs1.getString("address");
                                 }
                                 session.setAttribute("userAddress", userAddress);
                                 List<String> distinctRestId = new ArrayList<String>();
                                 distinctRestId = userArray.stream().map(UserCart::getRestaurantID).distinct().collect(Collectors.toList());
                                 System.out.println(distinctRestId);
                                 int cityCount=0;
                                 List<String> restaurantAddresses = new ArrayList<String>();
                                 double distance = 0.0;
                                 DistanceCalculator dc = new DistanceCalculator();   
                                 if(orderSum > 0.0){ %>
                            <div class="total-section">
                            
                            
                                <table class="total-table">
                                    <thead class="total-table-head">
                                        <tr class="table-total-row">
                                            <th>Price</th>
                                            <th>Delivery Fee</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <% String alertMessage = null;
                                    if(distinctRestId != null && distinctRestId.size() == 2){
                                    	String inClause = String.join(",", distinctRestId.stream().map(Object::toString).toArray(String[]::new));
                                    	stmt2 = conn.createStatement();
                                    	ResultSet rs2 = stmt2.executeQuery("Select distinct city from restaurants where id in ("+inClause+")");
                                    	while(rs2.next()){
                                    		cityCount++;
                                    		String cityName = rs2.getString("city");
                                    	}
                                    	if(cityCount > 1){
                                    		alertMessage = "Cannot place order from more than 1 city";
                                    	} else{
                                    		ResultSet rs3 = stmt3.executeQuery("Select distinct restaddress from usercart where restid in ("+inClause+")");
                                    		while(rs3.next()){}
                                    		restaurantAddresses.add(userAddress.replace(" ", "+"));
                                    		distance = dc.calculateOptimizedRoute(restaurantAddresses);
                                    	}
                                    } else if(distinctRestId.size() == 1){
                                    	stmt2 = conn.createStatement();
                                    	ResultSet rs2 = stmt2.executeQuery("Select distinct restaddress from usercart where restid = '"+distinctRestId.get(0)+"'");
                                    	if(rs2.next()){
                                    		restaurantAddress = rs2.getString("restaddress").replace(" ", "+");
                                    	}
                                    	distance = dc.calculateDistance(userAddress, restaurantAddress);
                                    } else if(distinctRestId.size() > 2){ 
                                    	alertMessage = "Can order from max of 2 restaurants in the same city";
                                    }
                                    System.out.println(distance);
                                    if(distance > 0.0 && distance <= 3.0){
                                    	deliveryFee = 1.99;
                                    } else if(distance > 3.0 && distance <= 5.0){
                                    	deliveryFee = 2.99;
                                    } else if(distance > 5.0 && distance <= 10.0){
                                    	deliveryFee = 3.99;
                                    } else if(distance > 10.00){
                                    	alertMessage = "Cannot place order. The restaurant is too far from your location";
                                    }
                                    DecimalFormat df = new DecimalFormat("#.##");
                                    double orderTotal = orderSum + deliveryFee; 
                                    String roundValue1 = df.format(orderSum);
                                    String roundValue2 = df.format(orderTotal);
                                    Double roundSum = Double.parseDouble(roundValue1);
                                    Double roundTotal = Double.parseDouble(roundValue2);
                                    System.out.println(roundTotal);
                                    request.setAttribute("orderTotal", roundTotal);
                                    %>
                                    
                                    <tbody>
                                        <tr class="total-data">
                                            <td><strong>£ <%= roundSum%></strong></td>
                                            <td>£ <%=deliveryFee %></td>
                                            <td>Total: £ <%=roundTotal %></td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <div class="contact-from-section"  style="margin-left: 500px;margin-top: 50px">
                                    <div class="contact-form">
                                        <h3>Delivery Address</h3>
                                        
                                        <input type="text" name="existingAddress" id="existingAddress" value="<%=userAddress %>" readonly="readonly" style="width: 250px">
                                        <!-- <input type="submit" value="Change" onclick="return toggleAddressFields()"> -->
                                        
                                        <!-- <p class="address-class">
                                            <input type="text" placeholder="Address Line 1" name="address1" id="address1" required="" >oninput="return updateUserAddress()"><br><br>
                                            <input type="text" placeholder="Address Line 2" name="address2" id="address2" required="" >oninput="return updateUserAddress()"><br><br>
                                            <input type="text" placeholder="City" name="addressCity" id="addressCity" required="" >oninput="return updateUserAddress()"><br>
                                        </p> -->
                                        <input type="hidden" value="<%=roundTotal%>" name="orderTotal">
                                        <%session.setAttribute("orderTotal", roundTotal); %>
                                        <p><input type="submit" value="Submit" onclick="return displayAlert()">&nbsp;&nbsp;</p>

                                    </div>
                                </div>
                                    <script>
    function displayAlert() {
        var alertMessage = <%= (alertMessage != null) ? "'" + alertMessage + "'" : "null" %>;
        
        if (alertMessage !== null) {
            alert(alertMessage);
            return false;
        }
    }
</script>     
                            </div>
                            <%} %>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- end cart -->

        <!-- logo carousel -->
        
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
        <!-- end copyright -->
        
        <%
            if (request.getParameter("CartCleared") != null) {%>
        <script>alert('Cart Cleared!');</script>  
        <%}
        %>
        
        <%
            if (request.getParameter("DishRemoved") != null) {%>
        <script>alert('Dish removed from cart');</script>  
        <%}
        %>
        
        <%
            if (request.getParameter("Failed") != null) {%>
        <script>alert('Clear Cart failed!');</script>  
        <%}
        %>

        
        <script src="Resources/assets/js/jquery-1.11.3.min.js"></script>        
        <script src="Resources/assets/js/jquery.isotope-3.0.6.min.js"></script>        
        <script src="Resources/assets/js/owl.carousel.min.js"></script>        
        <script src="Resources/assets/js/jquery.magnific-popup.min.js"></script>        
        <script src="Resources/assets/js/sticker.js"></script>        
        <script src="Resources/assets/js/main.js"></script>          
        <script src="Resources/assets/js/mapQuest.js"></script>
        
        
    </body>
</html>
