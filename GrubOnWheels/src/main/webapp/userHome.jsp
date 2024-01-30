
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Blob"%>
<%@page import="javax.xml.*"%>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">

       
        <title>Grub On Wheels</title>

       
        <link rel="shortcut icon" type="image/png" href="Resources/assets/img/favicon.png">       
        <link rel="stylesheet" href="Resources/assets/css/all.min.css">       
        <link rel="stylesheet" href="Resources/assets/bootstrap/css/bootstrap.min.css">                        
        <link rel="stylesheet" href="Resources/assets/css/main.css">        

        <style>
            .dropbtn {
                background-color: #FF7F50;
                color: white;
                padding: 16px;
                font-size: 16px;
                border: none;
                cursor: pointer;
            }

            .dropbtn:hover, .dropbtn:focus {
                background-color: #FF7F50;
            }

            #myInput {
                box-sizing: border-box;
                background-image: url('searchicon.png');
                background-position: 14px 12px;
                background-repeat: no-repeat;
                font-size: 16px;
                padding: 14px 20px 12px 45px;
                border: none;
                border-bottom: 1px solid #ddd;
            }

            #myInput:focus {outline: 3px solid #ddd;}

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f6f6f6;
                min-width: 230px;
                overflow: auto;
                border: 1px solid #ddd;
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown a:hover {background-color: #FF7F50;}

            .show {display: block;}
        </style>
    </head>
    
    <%
                if (request.getParameter("FeedAdded") != null) {%>
            <script>alert('Thanks for the feedback');</script>  
            <%}
            %>
            
            <%
                if (request.getParameter("CartEmpty") != null) {%>
            <script>alert('Cart is empty! Please add something to checkout');</script>  
            <%}
            %>
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
        

        
        <div class="breadcrumb-section breadcrumb-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 text-center">
                        <div class="breadcrumb-text">
                            <div class="dropdown">
                                <button onclick="myFunction()" class="dropbtn">Search City</button>
                                <div id="myDropdown" class="dropdown-content">
                                    <input type="text" placeholder="Search.." id="myInput" onkeyup="filterFunction()">
                                    <%
                                        Connection con = DatabaseConnection.getconnection();
                                        Statement st = con.createStatement();
                                        
                                        try {
                                            ResultSet rs = st.executeQuery("Select * from restaurants where statuss = 'Active' GROUP BY city");
                                            while (rs.next()) {                                           	

                                    %>
                                    <a href="searchRestaurants.jsp?cityName=<%=rs.getString("city")%>"><%=rs.getString("city")%></a>
                                    <%                                        }
                                            rs.close();
                                            con.close();
                                        } catch (Exception ex) {
                                            ex.printStackTrace();
                                        }

                                    %>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
       

      
        <div class="product-section mt-150 mb-150">
            <div class="container">
                <div class="content">
      <div class="food-list">
    <h4>Top Picks</h4></br>
      </div> <div class="checkout">
      </div>
    
      
      <%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
       
        conn = DatabaseConnection.getconnection();

        // Executing SQL query
        String query = "SELECT rm.dishname, rm.category, rm.price, rm.dishphoto, rm.restid, r.city, r.restname FROM gow.restaurant_menu rm "
        + " join gow.restaurants r on rm.restid = r.id join ( SELECT pid, SUM(quantity) AS total_quantity FROM gow.useroders GROUP BY pid "
        + " ORDER BY total_quantity DESC LIMIT 6) top_selling ON rm.id = top_selling.pid ORDER BY top_selling.total_quantity DESC ";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        
        Map<String, ArrayList<String>> menuColumns = new LinkedHashMap<String, ArrayList<String>>();
        String dishNameKey = "";
        while (rs.next()) {
        	
        	dishNameKey = rs.getString("dishname");
        	menuColumns.put(dishNameKey, new ArrayList<String>());
        	byte[] imageBytes = rs.getBytes("dishphoto");
            String dphoto = Base64.encodeBase64String(imageBytes);
            String dcategory = rs.getString("category");
            String dprice = rs.getString("price");
            String rID = rs.getString("restid");
            String rCity = rs.getString("city");
            String rname = rs.getString("restname");
            menuColumns.get(dishNameKey).add(0, dphoto);
            menuColumns.get(dishNameKey).add(1, dcategory);
            menuColumns.get(dishNameKey).add(2, dprice);
            menuColumns.get(dishNameKey).add(3, rID);
            menuColumns.get(dishNameKey).add(4, rCity);
            menuColumns.get(dishNameKey).add(5, rname);
    
        }
        int i =0;
        for(Map.Entry<String, ArrayList<String>> mapValues : menuColumns.entrySet()){
        	
%>

       <%if(i==0){ %>
       <div class="row">
    <div class="col-md-4">
    <div class="thumbnail ">
      <a href="restaurantMenu.jsp?id=<%=mapValues.getValue().get(3)%>&city=<%=mapValues.getValue().get(4)%>"> 
        <img class="food-img" src="data:image/jpeg;base64, <%= mapValues.getValue().get(0) %>" alt="img1" style="width:300px;height:300px">
        </a>
        <div class="caption">
            <p class="food-name"><%=mapValues.getValue().get(5) %>, <%=mapValues.getValue().get(4)%> - <%=mapValues.getKey() %><br><%=mapValues.getValue().get(1) %><br>£<%= mapValues.getValue().get(2) %></p><br>
           
       
        </div> 
    </div>
  </div>
  <% i++; continue;}  %>
  
  <%if(i==1){%>
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="restaurantMenu.jsp?id=<%=mapValues.getValue().get(3)%>&city=<%=mapValues.getValue().get(4)%>">
        <img src="data:image/jpeg;base64, <%= mapValues.getValue().get(0) %>" alt="img2" style="width:300px;height:300px">
         </a>
        <div class="caption">
          <p class="food-name"><%=mapValues.getValue().get(5) %>, <%=mapValues.getValue().get(4)%> - <%=mapValues.getKey() %><br><%=mapValues.getValue().get(1) %><br>£<%=mapValues.getValue().get(2) %></p><br>
        </div>
    </div>
  </div>
  <% i++;
  continue;  }  %>
   
   <%if(i==2){%>      
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="restaurantMenu.jsp?id=<%=mapValues.getValue().get(3)%>&city=<%=mapValues.getValue().get(4)%>">
        <img src="data:image/jpeg;base64, <%= mapValues.getValue().get(0) %>" alt="img3" style="width:300px;height:300px">
        </a>
        <div class="caption">
          <p class="food-name"><%=mapValues.getValue().get(5) %>, <%=mapValues.getValue().get(4)%> - <%=mapValues.getKey() %><br><%=mapValues.getValue().get(1) %><br>£<%=mapValues.getValue().get(2) %></p><br>
        </div>
    </div>
  </div>
 <% i++;
 continue;} %> 
 
 <%if(i==3){%> 
      <div class="col-md-4">
    <div class="thumbnail">
      <a href="restaurantMenu.jsp?id=<%=mapValues.getValue().get(3)%>&city=<%=mapValues.getValue().get(4)%>">
        <img src="data:image/jpeg;base64, <%= mapValues.getValue().get(0) %>" alt="img4" style="width:300px;height:300px">
         </a>
        <div class="caption">
          <p class="food-name"><%=mapValues.getValue().get(5) %>, <%=mapValues.getValue().get(4)%> - <%=mapValues.getKey() %><br><%=mapValues.getValue().get(1) %><br>£<%=mapValues.getValue().get(2) %></p><br>
        </div>
    </div>
  </div>
  <% i++;
  continue;    }  %>
  
 <%if(i==4){%>  
      <div class="col-md-4">
    <div class="thumbnail">
      <a href="restaurantMenu.jsp?id=<%=mapValues.getValue().get(3)%>&city=<%=mapValues.getValue().get(4)%>">
        <img src="data:image/jpeg;base64, <%= mapValues.getValue().get(0) %>" alt="img5" style="width:300px;height:300px">
        </a>
        <div class="caption">
          <p class="food-name"><%=mapValues.getValue().get(5) %>, <%=mapValues.getValue().get(4)%> - <%=mapValues.getKey() %><br><%=mapValues.getValue().get(1) %><br>£<%=mapValues.getValue().get(2) %></p><br>
        </div>
    </div>
  </div>
  <% i++;
  continue;    }  %>
         
<%if(i==5){%>       
      <div class="col-md-4">
    <div class="thumbnail">
      <a href="restaurantMenu.jsp?id=<%=mapValues.getValue().get(3)%>&city=<%=mapValues.getValue().get(4)%>">
        <img src="data:image/jpeg;base64, <%= mapValues.getValue().get(0) %>" alt="img6" style="width:300px;height:300px">
        </a>
        <div class="caption">
          <p class="food-name"><%=mapValues.getValue().get(5) %>, <%=mapValues.getValue().get(4)%> - <%=mapValues.getKey() %><br><%=mapValues.getValue().get(1) %><br>£<%=mapValues.getValue().get(2) %></p><br>
        </div>
    </div>
  </div>
  </div>

  
    </div>
        </div>
        </div>
    <% i++;
  continue;   }  
  } menuColumns.clear();
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Closing resources
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
      
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <p>Copyrights &copy; 2023,  All Rights Reserved.</p>
                    </div>
                    <div class="col-lg-6 text-right col-md-12">
                        <div class="social-icons">
                            <ul>
                                <li><a href="www.facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
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
       

        
        <script src="Resources/assets/js/jquery-1.11.3.min.js"></script>     
        <script src="Resources/assets/js/jquery.isotope-3.0.6.min.js"></script>       
        <script src="Resources/assets/js/owl.carousel.min.js"></script>        
        <script src="Resources/assets/js/jquery.magnific-popup.min.js"></script>        
        <script src="Resources/assets/js/sticker.js"></script>
        <script src="Resources/assets/js/main.js"></script>        
        <script>
        
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

    </body>
</html>
