<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
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
    <body >
        <div class="container-scroller" >
            <!-- partial:partials/_navbar.html -->
            <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
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
                                <a class="dropdown-item" href="adminLogout.jsp">
                                    <i class="ti-power-off text-primary"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <%
                if (request.getParameter("Granted") != null) {%>
            <script>alert('Restaurant Account Activated');</script>  
            <%}
            %>
            
             <%
                if (request.getParameter("Failed") != null) {%>
            <script>alert('Restaurant Account Activation/Rejection Failed! Please try again');</script>  
            <%}
            %>
            
            <%
                if (request.getParameter("Rejected") != null) {%>
            <script>alert('Restaurant Account Rejected');</script>  
            <%}
            %>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial -->
                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar" >
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link active" href="adminHome.jsp">
                                <i class="icon-grid menu-icon"></i>
                                <span class="menu-title">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="userList.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Users</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="restaurantList.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Restaurants</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="delAgentList.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Delivery Agents</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="deliveryAgentActivation.jsp">
                                <i class="ti-money menu-icon"></i>
                                <span class="menu-title">Delivery Agents Activation</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="restaurantsActivation.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Restaurant Activation</span>
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
                                                <center><p class="card-title mb-0" style="font-size: 30px">Restaurant Activations</p></center>
                                                <br>
                                                <br>
                                                <div class="table-responsive" >
                                                    <table class="table table-striped table-borderless">
                                                        <thead>
                                                            <tr>
                                                                <th>Id</th>
                                                                <th>Name</th>
                                                                <th>Mail id</th>
                                                                <th>Phone</th>
                                                                <th>Address</th>
                                                                <th>Status</th>
                                                                <th>Action</th>
                                                            </tr>  
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                Connection con = DatabaseConnection.getconnection();
                                                                Statement st = con.createStatement();
                                                                try {
                                                                    ResultSet rs = st.executeQuery("Select * from restaurants where statuss='InActive'");
                                                                    while (rs.next()) {

                                                            %>
                                                            <tr>
                                                                <td ><%=rs.getString("id")%></td>
                                                                <td ><%=rs.getString("restname")%></td>
                                                                <td ><%=rs.getString("email")%></td>
                                                                <td ><%=rs.getString("phone")%></td>
                                                                <td ><%=rs.getString("address")%></td>
                                                                <td class="font-weight-bold"><%=rs.getString("statuss")%></td>
                                                                <td>
                                                                <form action="RestaurantActivateReject" method="post">
                                                                <input type="hidden" name="id" value="<%=rs.getString("id")%>"/>
                                                                <input type="submit" name="restAction" value="Activate" class="btn btn-group-lg btn-success" onclick="RestaurantActivateReject"/>
                                                                <input type="submit" name="restAction" value="Reject" class="btn btn-group-lg btn-danger" onclick="RestaurantActivateReject"/>
                                                                </form></td>
                                                                <%                                        }
                                                                        rs.close();
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
            
        </div>
        

        
        <script src="Resources/Admin/vendors/js/vendor.bundle.base.js"></script>
        <script src="Resources/Admin/js/hoverable-collapse.js"></script>
        <script src="Resources/Admin/js/template.js"></script>
        
    </body>
</html>
