
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
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
                                <center> <h2 style="color: #FF7F50; margin-left: 200px">Grub On Wheels🚚</h2></center>
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
                                                <center><p class="card-title mb-0" style="font-size: 30px"><%=session.getAttribute("fname").toString()%> Delivery </p></center>
                                                <br>
                                                <br>
                                                <div class="table-responsive" >
                                                    <table class="table table-striped table-borderless">
                                                        <thead>
                                                            <tr>
                                                                <th>Order ID</th>
                                                                <th>Dish Name</th>
                                                                <th>Quantity</th>
                                                                <th>Delivered To</th>
                                                                <th>Address</th>
                                                                <th>Order Status</th>
                                                                <th>Delivery Status</th>
                                                                <th>Order Time</th>
                                                            </tr>  
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                String did = session.getAttribute("delid").toString();
                                                                Connection con = DatabaseConnection.getconnection();
                                                                Statement st = con.createStatement();
                                                                try {
                                                                    ResultSet rs1 = st.executeQuery("Select * from useroders where daid='" + did + "' order by id DESC");
                                                                    while (rs1.next()) {
                                                            %>
                                                            <tr>
                                                                <td ><%=rs1.getString("oid")%></td>
                                                                <td ><%=rs1.getString("pname")%></td>
                                                                <td ><%=rs1.getString("quantity")%></td>
                                                                <td ><%=rs1.getString("uname")%></td>
                                                                <td ><%=rs1.getString("address")%></td>
                                                                <td ><%=rs1.getString("orderstatus")%></td>
                                                                <td ><%=rs1.getString("dastatus")%></td>
                                                                <td ><%=rs1.getString("time")%></td>
                                                                <%                                        }
                                                                        rs1.close();
                                                                        con.close();
                                                                    } catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                    }

                                                                %>
                                                            </tr>
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
        

        
        <script src="Resources/Admin/vendors/js/vendor.bundle.base.js"></script>
        <script src="Resources/Admin/js/hoverable-collapse.js"></script>
        <script src="Resources/Admin/js/template.js"></script>
        <script src="Resources/Admin/js/deliveryLocation.js"></script>
        
    </body>
</html>
