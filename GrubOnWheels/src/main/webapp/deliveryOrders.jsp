<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Grub On Wheels</title>
        
        <link rel="stylesheet" href="Resources/Admin/vendors/feather/feather.css">
        <link rel="stylesheet" href="Resources/Admin/vendors/ti-icons/css/themify-icons.css">
        <link rel="stylesheet" href="Resources/Admin/css/vertical-layout-light/style.css">
      
    </head>
    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row" >
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                    <a class="navbar-brand brand-logo mr-5" href="#"><img src="Resources/Admin/images/admin.svg" class="mr-2" alt="logo"/></a>
                    <a class="navbar-brand brand-logo-mini" href="#"><img src="Resources/Admin/images/admin.png" alt="logo"/></a>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                        <span class="icon-menu"></span>
                    </button>
                    <ul class="navbar-nav mr-lg-2">
                        <li class="nav-item nav-search d-none d-lg-block">
                            <div class="input-group">
                                <div class="input-group-prepend hover-cursor" id="navbar-search-icon">
                                </div>
                                <center> <h2 style="color: #FF7F50; margin-left: 200px">Grub On Wheels</h2></center>
                            </div>
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-nav-right">
                        <li class="nav-item nav-profile dropdown">
                            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                                <i class="icon-lock"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
                                <a class="dropdown-item" href="deliveryLogout.jsp">
                                    <i class="ti-power-off text-primary"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial -->
                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar" >
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link active" href="deliveryHome.jsp">
                                <i class="icon-grid menu-icon"></i>
                                <span class="menu-title">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="deliveryOrders.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Orders</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="deliveryHistory.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Delivery History</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="deliveryFeedback.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Feedbacks</span>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- partial -->
                <div class="main-panel" >
                    <div class="content-wrapper" style="background-color: #F89880">
                        <div class="row">
                            <div class="col-md-12 grid-margin">
                                <div class="row" >
                                    <div class="col-md-12 grid-margin stretch-card" >
                                        <div class="card" >
                                            <div class="card-body">
                                                <center><p class="card-title mb-0" style="font-size: 30px"><%=session.getAttribute("fname").toString()%> Orders</p></center>
                                                <br>
                                                <br>
                                                
                                                <div class="table-responsive" >
                                                    <table class="table table-striped table-borderless">
                                                        <thead>
                                                            <tr>
                                                                <th>Id</th>
                                                                <th>Order ID</th>
                                                                <th>Dish Name</th>
                                                                <th>Restaurant Name</th>
                                                                <th>Quantity</th>
                                                                <th>Order Status</th>
                                                                <th>Delivery Status</th>
                                                                <th>Order Time</th>
                                                                <th>Action</th>
                                                                <th>Restaurant Address</th>
                                                            </tr>  
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                String delcity = session.getAttribute("delcity").toString();
                                                                Connection con = DatabaseConnection.getconnection();
                                                                Statement st = con.createStatement();
                                                                Statement st1 = con.createStatement();
                                                                try {
                                                                    ResultSet rs = st.executeQuery("Select * from useroders where city='" + delcity + "' and orderstatus not in ('Cancelled','Rejected') and dastatus in ('Waiting','Accepted','Picked Up') order by id DESC");
                                                                    while (rs.next()) {
                                                                    	String id = rs.getString("id");
                                                                    	String oid = rs.getString("oid");
                                                                    	String delstatus = rs.getString("dastatus");
                                                                    	String resid = rs.getString("resid");
                                                                    	System.out.println(resid);
                                                                    	
                                                                    	ResultSet rs1 = st1.executeQuery("Select restname, address from restaurants where id = '"+resid+"'");
                                                                    	String restname = "";
                                                                    	String restaddress = "";
                                                                    	if(rs1.next()){
                                                                    		restname = rs1.getString("restname");
                                                                    		restaddress = rs1.getString("address");
                                                                    	}
                                                            %>
                                                           
                                                            <tr>
                                                            
                                                                <td ><%=rs.getString("id")%></td>
                                                                <td ><%=rs.getString("oid")%></td>
                                                                <td ><%=rs.getString("pname")%></td>
                                                                <td ><%=restname%></td>
                                                                <td ><%=rs.getString("quantity")%></td>
                                                                <td ><%=rs.getString("orderstatus")%></td>
                                                                <td ><%=rs.getString("dastatus")%></td>
                                                                <td ><%=rs.getString("time")%></td>
                                                                <td class="font-weight-bold">
                                                                <form action="DeliveryConfirmDeliver" method="post" id="deliveryForm">
                                                                <input type="hidden" name = "id" value="<%=id%>"/>
                                                            	<input type="hidden" name = "oid" value="<%=oid%>"/>
                                                            	<input type="hidden" name = "delid" value="<%=session.getAttribute("delid").toString()%>"/>
                                                                <%if(delstatus.equalsIgnoreCase("Waiting")){ %>
                                                                <input type="submit" name="delstatus" value="Confirm" id="confirmButton" class="btn btn-group-lg btn-success"/>
                                                                <%} else if(delstatus.equalsIgnoreCase("Accepted")){ %>
                                                                <input type="submit" name="delstatus" value="Picked Up?" id="pickUpButton" class="btn btn-group-lg btn-warning"/>
                                                                <%} else{%>
                                                                <input type="submit" name="delstatus" value="Delivered?" id="deliverButton" class="btn btn-group-lg btn-success"/>
                                                                <%       }   %> 
                                                                <input type="hidden" name = "latitude" id="latitude"/>
                                                            	<input type="hidden" name = "longitude" id="longitude"/>
                                                            	      </form> </td>    
                                                            	      <td ><%=restaddress%></td>
                                                            	      </tr>              <%     }
                                                                        rs.close();
                                                                        con.close();
                                                                    } catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                    }

                                                                %>
                                                            
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <footer class="footer">
                        <div class="d-sm-flex justify-content-center justify-content-sm-between">
                            <span class="text-primary text-center text-sm-left d-block d-sm-inline-block">Copyright © 2023 All rights reserved.</span>
                        </div>
                    </footer>
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        
        <%         
                    if (request.getParameter("Accepted") != null) {%>
        <script>alert('Delivery Accepted');</script>  
        <%}
        %>
        
        <%         
                    if (request.getParameter("PickedUp") != null) {%>
        <script>alert('Delivery Picked Up from restaurant');</script>  
        <%}
        %>
        
        <%
            if (request.getParameter("Delivered") != null) {%>
        <script>alert('Order Delivered');</script>  
        <%}
        %>
        
        <%
            if (request.getParameter("Failed") != null) {%>
        <script>alert('Failed! Try again!!');</script>  
        <%}
        %>
        

        
        <script src="Resources/Admin/vendors/js/vendor.bundle.base.js"></script>
        <script src="Resources/Admin/js/hoverable-collapse.js"></script>
        <script src="Resources/Admin/js/template.js"></script>
        <script src="Resources/Admin/js/deliveryLocation.js"></script>
        
    </body>
</html>