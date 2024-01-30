
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
                                <a class="dropdown-item" href="restaurantLogout.jsp">
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
                            <a class="nav-link active" href="restaurantHome.jsp">
                                <i class="icon-grid menu-icon"></i>
                                <span class="menu-title">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="addMenu.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Add Menu</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="updateMenu.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Menu Update</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="restaurantOrders.jsp">
                                <i class="ti-user menu-icon"></i>
                                <span class="menu-title">Orders</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="restaurantTransactions.jsp">
                                <i class="ti-money menu-icon"></i>
                                <span class="menu-title">Transactions</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="restaurantComplaints.jsp">
                                <i class="icon-mail menu-icon"></i>
                                <span class="menu-title">Reviews</span>
                            </a>
                        </li>
                    </ul>
                </nav>
               <%--  <%
                    String rid = session.getAttribute("rid").toString();
                %> --%>
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper" style="background-color:gold">
                        <div class="row">
                            <div class="col-md-12 grid-margin">
                                <div class="row">
                                    <div class="col-12 col-xl-8 mb-4 mb-xl-0">
                                        <h3 class="font-weight-bold">Add Menu</h3>
                                        <h6 class="font-weight-normal mb-0"></h6>
                                    </div>
                                    <div class="col-12 col-xl-4">
                                        <div class="justify-content-end d-flex">
                                            <div class="dropdown flex-md-grow-1 flex-xl-grow-0">
                                                <button class="btn btn-sm btn-light bg-white" type="button"   aria-haspopup="true" aria-expanded="true">
                                                    <i class="mdi mdi-calendar"></i> <%Date date = new Date();%> <%=date.toString()%>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 stretch-card" style="padding-right: 150px">
                                <div class="card" style="background-color:beige">
                                    <form action="AddMenu" method="post" enctype="multipart/form-data">
                                        <h4 class="card-title">Menu Details</h4>
                                        <form class="form-sample">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">&nbspDish Name</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control"  required="" name="dishname"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Dish Type</label>
                                                        <div class="col-sm-3">
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input type="radio" class="form-check-input" name="dishtype" id="membershipRadios1" value="Veg" checked>
                                                                    Veg
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input type="radio" class="form-check-input" name="dishtype" id="membershipRadios2" value="Non-Veg">
                                                                    Non Veg
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">&nbspCategory</label>
                                                        <div class="col-sm-9">
                                                            <select class="form-control" required="" name="Category">
                                                                <option value="Soups">Soups</option>
                                                                <option value="Starter">Starter</option>
                                                                <option value="Main Course">Main Course</option>
                                                                <option value="Gravy">Curry</option>
                                                                <option value="Desert">Desserts</option>
                                                                <option value="Beverages">Beverages</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Region</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control" required="" name="region">
                                                                <option value="South Indian">South Indian</option>
                                                                <option value="North Indian">North Indian</option>
                                                                <option value="Chinese">Chinese</option>
                                                                <option value="Italian">Italian</option>
                                                                <option value="Mexican">Mexican</option>
                                                                <option value="Continental">Continental</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">&nbspPrice</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control"  required="" name="price"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 col-form-label">Dish Photo</label>
                                                        <div class="col-sm-8">
                                                            <input type="file" class="form-control"  required="" name="dishphoto"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" style="padding-left: 370px">
                                                <div class="input-group">
                                                    <center><button type="submit" class="btn btn-primary mb-2">Submit</button></center>
                                                </div>
                                            </div>
                                        </form>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    
                    <footer class="footer">
                        <div class="d-sm-flex justify-content-center justify-content-sm-between">
                            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2023 All rights reserved.</span>
                        </div>
                    </footer>
                    
                </div>
                
            </div>
            
        </div>
        
        <%
            if (request.getParameter("success") != null) {%>
        <script>alert('Menu Successfully Added!');</script>  
        <%}
        %>
        <%
            if (request.getParameter("failed") != null) {%>
        <script>alert('Add Menu Failed! Try Again');</script>  
        <%}
        %>
        

        <!-- plugins:js -->
        <script src="Resources/Admin/vendors/js/vendor.bundle.base.js"></script>        
        <script src="Resources/Admin/js/hoverable-collapse.js"></script>
        <script src="Resources/Admin/js/template.js"></script>

        
    </body>
</html>
