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
                if (request.getParameter("Failed") != null) {%>
            <script>alert('Feedback update failed! Please try again');</script>  
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
                                            <a class="shopping-cart" href="usercart.jsp"><i class="fas fa-shopping-cart"></i></a>
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
                            <p>Order Feedback</p>
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
            <style>

                .container1 {
                    background: #f8faff;
                    color: #4b537c;
                    width: 100%;
                    max-width: 450px;
                    padding: 40px;
                    border-radius: 15px;
                    margin: 0 auto;
                    margin-top: 50px;
                    box-shadow: #dee8fe 0 10px 20px 5px;
                    display: flex;
                    flex-direction: column;
                    gap: 15px;
                }

                .heading1 {
                    font-size: 18px;
                }

                .para {
                    font-weight: 600;
                }

                .feedback-msg textarea {
                    margin-top: 5px;
                    border: solid 2px #f2cd95;
                    padding: 13px;
                    border-radius: 7px;
                    outline: none;
                    font-size: 14px;
                    color: black;
                    font-weight: 500;
                    letter-spacing: 1px;
                    width: 100%;
                    height: 80px;
                    resize: none;
                }

                .agreement .checkbox {
                    display: flex;
                    gap: 5px;
                    align-items: center;
                    margin-bottom: 5px;
                }
                .agreement input {
                    accent-color: #ff71a4;
                }
                .agreement a {
                    color: #ff71a4;
                    font-size: 12px;
                    font-weight: 600;
                }
                .agreement label {
                    font-size: 12px;
                    font-weight: 600;
                }

                .buttons {
                    display: flex;
                    gap: 10px;
                    justify-content: end;
                }
                .buttons input {
                    background: white;
                    color: #4b537c;
                    width: 80px;
                    padding: 10px;
                    text-align: center;
                    border-radius: 4px;
                }
                .buttons input:hover {
                    opacity: 0.9;
                }
                .buttons input:nth-child(1) {
                    background: #fe71a4;
                    color: #f8faff;
                }


                .notation-text {
                    color: #000000;
                    font-size: 18px;
                    text-align: center;
                    margin: 18px;
                }

                .notation-block-star {
                    display: table;
                    margin: 0 auto;
                    width: inherit;
                }


                .notation-star {
                    background-image: url("https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/2000px-Empty_Star.svg.png");
                    background-repeat: no-repeat;
                    cursor: pointer;
                    display: table-cell;
                    float: right;
                    height: 20px;
                    width: 20px;
                    padding: 10 5px;
                    background-size: cover;
                }


                .notation-star:hover,
                .notation-star:hover ~ .notation-star {
                    background-image: url("http://findicons.com/files/icons/1035/human_o2/128/bookmark_new.png");
                }

                .notation-star-selected {
                    background-image: url("http://findicons.com/files/icons/1035/human_o2/128/bookmark_new.png");
                    background-repeat: no-repeat;
                    cursor: pointer;
                    display: table-cell;
                    float: right;
                    height: 20px;
                    width: 20px;
                    padding: 10 5px;
                    background-size: cover;
                }

                .notation-star-selected  ~ .notation-star {
                    background-image: url("http://findicons.com/files/icons/1035/human_o2/128/bookmark_new.png");
                }
            </style>
 <%
    String uid = session.getAttribute("userid").toString();
    String oid = request.getParameter("oid");
    String resid = request.getParameter("resid");
                %>
            <div class="container1">
                <h1 class="heading1">Kindly Give feedback</h1>
                <p class="para">Order ID: <%=oid %></p>
                <p class="para">What do you think of the food delivery?</p>

                <div class="notation-text">Service Rating</div>
               

                <form method="post" action="Feedback">
                    <div id="star5" class="notation-star" onClick="notation(this.id);"></div>
                    <div id="star4" class="notation-star" onClick="notation(this.id);"></div>
                    <div id="star3" class="notation-star" onClick="notation(this.id);"></div>
                    <div id="star2" class="notation-star" onClick="notation(this.id);"></div>
                    <div id="star1" class="notation-star" onClick="notation(this.id);"></div>
                    <input type="hidden" id="notationNote" name="notation_note" value="0">

                    <div class="feedback-msg">
                        <p class="para">
                            What are the main reasons for your rating?
                        </p>
                        <textarea name="feedback" id="" required=""></textarea>
                    </div>
                    <br>
                    <div class="agreement">
                        <div class="checkbox">
                            <input type="checkbox" name="contact" id="" required="">
                            <input type="hidden" name="oid" value="<%=oid%>" id="" required="">
                            <input type="hidden" name="resid" value="<%=resid%>" id="" required="">
                            <label for="">I may be contacted about this feedback <a href="#">Privacy Policy</a>.</label>
                        </div>
                    </div>

                    <div class="buttons">
                        <input type="submit" value="Submit">
                    </div>
                </form>
            </div>
            <br>
            <script type="text/javascript">
                function notation(starId) {

                    var elements = document.getElementsByClassName("notation-star-selected");

                    for (i = 0; i < elements.length; i++) {
                        elements[i].className = "notation-star";
                    }


                    document.getElementById(starId).className = "notation-star-selected";


                    document.getElementById("notationNote").value = starId.substr(4,
                            4);

                    var note = document.getElementById("notationNote").value =
                            starId.substr(4, 4);

                    document.getElementById("vote").innerHTML = note.valueOf();



                }
            </script>
            
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
        <!-- bootstrap -->
        <script src="Resources/assets/bootstrap/js/bootstrap.min.js"></script>
        <!-- count down -->
        <script src="Resources/assets/js/jquery.countdown.js"></script>
        <!-- isotope -->
        <script src="Resources/assets/js/jquery.isotope-3.0.6.min.js"></script>
        <!-- waypoints -->
        <script src="Resources/assets/js/waypoints.js"></script>
        <!-- owl carousel -->
        <script src="Resources/assets/js/owl.carousel.min.js"></script>
        <!-- magnific popup -->
        <script src="Resources/assets/js/jquery.magnific-popup.min.js"></script>
        <!-- mean menu -->
        <script src="Resources/assets/js/jquery.meanmenu.min.js"></script>
        <!-- sticker js -->
        <script src="Resources/assets/js/sticker.js"></script>
        <!-- main js -->
        <script src="Resources/assets/js/main.js"></script>
        <script>
                /* When the user clicks on the button,
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

    </body>
</html>


