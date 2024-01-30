<%@page import="java.util.Date"%>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
      <div class="main-panel">
        <div class="content-wrapper" style="background-color: #F89880">
          <div class="row">
            <div class="col-md-12 grid-margin">
              <div class="row">
                <div class="col-12 col-xl-8 mb-4 mb-xl-0">
                  <h3 class="font-weight-bold">Welcome Delivery Partner</h3>
                  <h6 class="font-weight-normal mb-0">All systems are running smoothly!</h6>
                </div>
                <div class="col-12 col-xl-4">
                 <div class="justify-content-end d-flex">
                  <div class="dropdown flex-md-grow-1 flex-xl-grow-0">
                    <button class="btn btn-sm btn-light bg-white" type="button"   aria-haspopup="true" aria-expanded="true">
                     <i class="mdi mdi-calendar"></i> <%Date date = new Date();%>
                     <%  TimeZone londonTimeZone = TimeZone.getTimeZone("Europe/London");
        Calendar londonCalendar = Calendar.getInstance(londonTimeZone);
        londonCalendar.setTime(date);

        // Format and display the London time
        SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss 'GMT/UTC' yyyy");
        sdf.setTimeZone(londonTimeZone);
        String time = sdf.format(londonCalendar.getTime());%>
                     <%=time %>
                    </button>
                  </div>
                 </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6 grid-margin stretch-card">
              <div class="card tale-bg">
                <div class="card-people mt-auto">
                  <img src="Resources/Admin/images/dashboard/people.svg" alt="people">
                  <div class="weather-info">
                    <div class="d-flex">
                      <div>
                        <h2 class="mb-0 font-weight-normal"><i class="icon-sun mr-2"></i>17<sup>C</sup></h2>
                      </div> 
                      <div class="ml-2">
                        <h4 class="location font-weight-normal">Leicester</h4>
                        <h6 class="font-weight-normal">UK</h6>
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
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2023 All rights reserved.</span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  
  
       

  
  <script src="Resources/Admin/vendors/js/vendor.bundle.base.js"></script>
  <script src="Resources/Admin/js/hoverable-collapse.js"></script>
  <script src="Resources/Admin/js/template.js"></script>
  <script src="Resources/Admin/js/deliveryLocation.js"></script>
  
</body>
</html>