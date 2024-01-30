<%@page import="java.util.ArrayList"%>
<%@page import="model.Dish"%>
<%@page import="controller.DBControl"%>
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
    <body>
    
    <%
            if (request.getParameter("orderPlaced") != null) {%>
        <script>alert('Thank you for using our service!');</script>  
        <%}
        %>
        
       <% 
        if (request.getParameter("Cancelled") != null) {%>
        <script>alert('Order Cancelled');</script>  
        <%}
        %>

		<% 
        if (request.getParameter("CancelFailed") != null) {%>
        <script>alert('Order Cancellation failed! Please try again');</script>  
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

        <div class="breadcrumb-section breadcrumb-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 text-center">
                        <div class="breadcrumb-text">
                            <p>Track Orders</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end header -->

        <!-- end search arewa -->

        <!-- end breadcrumb section -->

        <!-- products -->
        <div class="product-section mt-150 mb-150">
            <div class="container">
                <%
                    String uid = session.getAttribute("userid").toString();
                    Connection con = DatabaseConnection.getconnection();
                    Statement st = con.createStatement();
                    Statement st1 = con.createStatement();
                    Statement st4 = con.createStatement();
                    Statement stmt = con.createStatement();
                    try {
                        ResultSet rs = st.executeQuery("Select distinct * from useroders where uid='" + uid + "' group by oid order by id DESC");
                        while (rs.next()) {
                        	String oid = rs.getString("oid");
                        	String address = rs.getString("address");
                        	String orderstatus = rs.getString("orderstatus");
                        	
                %>
                <table width="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff" style="font-family: Arial, Helvetica, sans-serif; line-height: 1;">
                    <tr>
                        <td valign="top" align="center">
                            <table class="table600" width="600" cellspacing="0" cellpadding="0" border="0" align="center" style="border-collapse: collapse;">

                                <tr>
                                    <td valign="top" align="center">
                                        <table class="table600" width="600" cellspacing="0" cellpadding="0" border="0" align="center" style="border-collapse: collapse; text-align: left;">
                                            <tr>
                                                <td valign="top" style="font-size: 18px; line-height: 1;">
                                                    <div>Dear <%=rs.getString("uname")%>, <span style="white-space: nowrap;">Thank You For Your Order!</span></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" height="10" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td valign="top" style="font-size: 18px; line-height: 1;">
                                                    <span>
                                                        Your Order ID is <b style="color: #ff00cc"><%=rs.getString("oid")%></b><br><br> <%if(rs.getString("orderstatus").equalsIgnoreCase("Delivered")){ %>
                                                        <a href="userFeedback.jsp?oid=<%=rs.getString("oid")%>&resid=<%=rs.getString("resid")%>"><b>Click here For Feedback</b></a><%} %> &nbsp;&nbsp;&nbsp;&nbsp; Order Status: <b style="color:orange"><%=orderstatus%></b>
                                                        &nbsp;&nbsp;&nbsp;&nbsp; <%if(rs.getString("orderstatus").equalsIgnoreCase("Cancelled") || rs.getString("orderstatus").equalsIgnoreCase("Rejected")) {
                                                        System.out.println("Cancel");}
                                                        else{
                                                        if(rs.getString("orderstatus").equalsIgnoreCase("Delivery Picked Up")){%>
                                                        <a href="#" onclick="return cancelMessage()"><b style="color:red">Cancel Order</b></a> <%} else{ if(!rs.getString("orderstatus").equalsIgnoreCase("Delivered")){ %>
                                                        <a href="cancelOrder.jsp?oid=<%=rs.getString("oid")%>"><b style="color:red">Cancel Order</b></a><%} }}%>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" height="20" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td valign="top" height="20" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td valign="top" height="20" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td>
                                        <table class="table95" width="100%" cellspacing="0" cellpadding="0" border="0" align="center" style="border-collapse: collapse;">
                                            <tr>
                                                <td class="order-list" valign="top">
                                                    <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" style="border-collapse: collapse;">
                                                        <thead>
                                                            <tr>
                                                                <td class="pr-name" width="43%" style="border: solid #e0e0e0; border-width: 1px 0; padding: 10px 0; vertical-align: top; color:#999; font-size:12px;">Item Name</td>
                                                                <td class="pr-price" width="15%" style="border: solid #e0e0e0; border-width: 1px 0; padding: 10px 0; vertical-align: top; text-align: right; color:#999; font-size:12px;" align="right">Status</td>
                                                                

                                                                <td class="pr-price" width="15%" style="border: solid #e0e0e0; border-width: 1px 0; padding: 10px 0; vertical-align: top; text-align: right; color:#999; font-size:12px;" align="right">Price</td>
                                                               
                                                                <td class="pr-qty" width="10%" style="border: solid #e0e0e0; border-width: 1px 0; padding: 10px 0; vertical-align: top; text-align: right; color:#999; font-size:12px;" align="right">Quantity</td>
                                                                <td class="pr-amount" width="17%" style="border: solid #e0e0e0; border-width: 1px 0; padding: 10px 0; vertical-align: top; text-align: right; color:#999; font-size:12px;" align="right">Amount</td>
                                                            </tr>
                                                        </thead>
                                                        <%  
                                                        double sumTotal = 0.0;
                                                        double orderTotal = 0.0;
                                                        ResultSet rs2 = stmt.executeQuery("Select * from useroders where uid='" + uid + "' and oid = '"+oid+"' order by id DESC");
                                	while(rs2.next()){
                            			String pid=rs2.getString("pid"); 
                            			orderTotal = Double.parseDouble(rs2.getString("orderTotal"));%>
                                                        <tbody>
                                                        
                                                            <tr>
                                                                <td colspan="5" style="border-bottom: 1px solid #e0e0e0; padding: 5px 0 10px;" valign="top">
                                                                    <table class="order-list-item" width="100%" cellspacing="0" cellpadding="0" border="0" align="center" style="border-collapse: collapse; font-size:13px; color:#333;">
                                                                        <tr>
                                                                            <td class="pr-name" width="43%" style="padding-top:10px; vertical-align: top; text-align: left" align="left" valign="top">
                                                                                    <img src="menuImg.jsp?mid=<%=rs2.getString("pid")%>" alt="" width="50" height="50" style="border: solid 1px #e0e0e0;" />
                                                                                    <span style="padding-top:4px; font-size: 11px; color: black; text-decoration: bold; line-height: 50px; vertical-align: top;"><%=rs2.getString("pname")%></span>
                                                                            </td>
                                                                            
                                                                            <td width="15%" style="white-space:nowrap; text-align:right; padding-top:10px; vertical-align: top;" valign="top">
                                                                               <%=rs2.getString("orderstatus") %>
                                                                            </td>
                                                                            <% 
                                                                    ResultSet rs1 = st1.executeQuery("Select * from restaurant_menu where id='" + pid + "'");
                                                                            String price = "";
                                                                    while (rs1.next()) { %>
                                                                            <td width="15%" style="white-space:nowrap; text-align:right; padding-top:10px; vertical-align: top;" valign="top">
                                                                               <%price = rs1.getString("price"); %>
                                                                                <%=rs1.getString("price")%>
                                                                            </td>
                                                                             <%                                        }
                                                                    rs1.close();
                                                                %>
                                                                            <td width="10%" style="text-align:right; padding-top:10px; vertical-align: top;" valign="top">
                                                                               <% String quantity = rs2.getString("quantity");%>
                                                                                <%=rs2.getString("quantity")%>
                                                                            </td>
                                                                            <td width="17%" style="text-align:right; padding-top:10px; vertical-align: top;" valign="top">
                                                                                <%double total = Double.parseDouble(price) *  Integer.parseInt(quantity);%>
                                                                                <%=total%>
                                                                                <%sumTotal+=total; %>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                         <%  address = rs2.getString("address"); 
                                                         } rs2.close(); %>
                                                        <tfoot>
                                                            <tr>
                                                                <td colspan="5" style="padding: 10px 0 15px;" valign="top">
                                                                    <table class="order-list-subtotal" cellspacing="0" cellpadding="0" border="0" align="right" style="border-collapse: collapse; font-size:13px; color:#333; text-align:right;">
                                                                        <tr>
                                                                            <td style="padding-top:5px;" valign="top"><b>TOTAL: (Incl. Delivery Fee)</b></td>
                                                                            <td class="subtotal-val" style="padding:5px 0 0 30px;" valign="top"><b>£ <%=orderTotal%></b></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tfoot>
                                                     
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="1" bgcolor="#000" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td valign="top" height="25" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr>
                                    <td valign="top" align="center">
                                        <table class="table95" width="100%" cellspacing="0" cellpadding="0" border="0" align="center" style="border-collapse: collapse;">
                                            <tr>
                                                <td class="shipping-info" valign="top">
                                                    <table class="fullWidth" width="290" cellspacing="0" cellpadding="0" border="0" align="left" style="border-collapse: collapse; font-size:13px; line-height:1.5;color:#333;">
                                                        <tr>
                                                            <td valign="top"><b>Delivery address</b></td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" height="10" style="font-size: 0; line-height: 0;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=address%>
                                                            </td>
                                                        </tr>
                                                    </table>

                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table> <br><br>
                <%        
                }
                        rs.close();
                        con.close();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }

                %>
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
        <!-- end copyright -->

        
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

            function cancelMessage() {
					alert("Cannot cancel the order. The order has already been picked up!");
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


