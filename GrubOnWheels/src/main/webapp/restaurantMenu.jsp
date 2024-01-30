<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Dish"%>
<%@page import="controller.DBControl"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.ChatMessage"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.Map" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">

        <!-- title -->
        <title>Shop</title>

        
        <link rel="shortcut icon" type="image/png" href="Resources/assets/img/favicon.png">
        
        <link rel="stylesheet" href="Resources/assets/css/all.min.css">
        
        <link rel="stylesheet" href="Resources/assets/bootstrap/css/bootstrap.min.css">
        
        <link rel="stylesheet" href="Resources/assets/css/main.css">
        <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.29.6.min.js"></script>
        
       <!--  <link rel="stylesheet" href="Resources/assets/css/responsive.css"> -->
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
            
.chat-tab {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: #3498db;
    color: #fff;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

.chat-box {
    display: none;
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 300px;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.chat-header {
    background-color: #3498db;
    color: #fff;
    padding: 10px;
    border-top-left-radius: 5px;
    border-top-right-radius: 5px;
}

.chat-messages {
    list-style: none;
    padding: 0;
    margin: 0;
    max-height: 200px;
    overflow-y: auto;
}

.chat-form {
    padding: 10px;
    border-top: 1px solid #ccc;
}
        </style>
    </head>
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
                                    <li><a href="trackorder.jsp">Order Tracking</a></li>
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
                            <p>Restaurant Menu</p> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%            String id = request.getParameter("id");
        String restaurantName = request.getParameter("name");
                   String city = request.getParameter("city");
                   System.out.println(city);
                   session.setAttribute("cityOfRest", city);
                   session.setAttribute("idOfRest", id);

            DBControl dbcontrol = new DBControl();
            ArrayList<Dish> dishList = new ArrayList<Dish>();
            dishList = dbcontrol.addAllDishes(id);

        %>

        <!-- end breadcrumb section -->

        <!-- products -->
        <div class="product-section mt-150 mb-150">
            <div class="container">
                <div class="container hotel-list">
                    <h4>Menu Details</h4></br>
                    <div class="row">
                        <%  if (dishList != null) {
                                for (int i = 0; i < dishList.size(); i++) {
                        %>
                        <div class="col-md-4">
                            <div class="thumbnail">
                                <a href="#">
                                    <img class="hotel-img"src="menuImg.jsp?mid=<%= dishList.get(i).getDishId()%>" alt="<%= dishList.get(i).getDishName()%>" style="width:250px;height: 200px">
                                </a>
                                <div class="caption">
                                    <h3><%= dishList.get(i).getDishName()%></h3>
                                    <p class="product-price"><span>1 Quantity</span> £ <%= dishList.get(i).getDishPrice()%> </p>
                                    <form action="AddCart" method="post"><label>Quantity</label>
                                        <input type="number" name="quantity" min="1" max="10" required="">
                                        <input type="hidden" name="id" value="<%=dishList.get(i).getDishId()%>" >
                                        <input type="hidden" name="restid" value="<%=id%>" >
                                        <input type="hidden" name="city" value="<%=city%>" >
                                        <input type="hidden" name="price" value="<%= dishList.get(i).getDishPrice()%>" >
                                        <button type="submit" class="cart-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                                    </form>
                                </div> 
                            </div>
                        </div>
                        <% }
                                     }%>

                    </div>
                </div>
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
        
      
<%Map<String, List<ChatMessage>> restaurantChatHistories = new HashMap<String, List<ChatMessage>>();
restaurantChatHistories = (Map<String, List<ChatMessage>>) session.getAttribute("restaurantChatHistories");
List<ChatMessage> restaurantChat = new ArrayList<ChatMessage>();
String userid = session.getAttribute("userid").toString();
String userName = session.getAttribute("username").toString();
String userRestaurantID = userid + "_" + id;
if(restaurantChatHistories != null){
restaurantChat = restaurantChatHistories.get(userRestaurantID);
}
%>
<div id="chatTab" class="chat-tab">Chat</div>  
<div id="chatBox" class="chat-box">
    <div class="chat-header">Chat History</div>
    <ul id="chatMessages" class="chat-messages"></ul>
    <form id="chatForm" class="chat-form">
        <input type="hidden" id="sender" value="<%=userName%>">
        <input type="hidden" id="receiver" value="<%=restaurantName%>">
        <input type="hidden" id="userID" value="<%=userid%>">
        <input type="hidden" id="resID" value="<%=id%>">
        <input type="text" id="messageInput" placeholder="Enter your message">
        <input type="submit" id="sendButton" value="Send"/>
    </form>
</div>

<script>
const chatTab = document.getElementById("chatTab");
const chatBox = document.getElementById("chatBox");
const chatForm = document.getElementById("chatForm");
const messageInput = document.getElementById("messageInput");
const chatMessages = document.getElementById("chatMessages");
const sender = document.getElementById("sender").value;
const receiver = document.getElementById("receiver").value;
const senderID = document.getElementById("userID").value;
const receiverID = document.getElementById("resID").value;

chatTab.addEventListener("click", () => {
console.log("Clicked");
chatBox.style.display = chatBox.style.display === "block" ? "none" : "block";

if (chatBox.style.display === "block") {
	fetchChatHistory();	
}
});

function sendMessage(senderID, message, receiverID) {
var xhr = new XMLHttpRequest();
var senderName = document.getElementById("sender").value;
xhr.open("POST", "ChatServlet", true);
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xhr.send("user=" + senderID + "&message=" + encodeURIComponent(message) + "&restaurant=" + receiverID + "&senderName=" + senderName + "&action=send&sendaction=user");
}

function displayMessage(user, message) {
console.log("Displaying...");
var li = document.createElement("li");
li.innerHTML = user + ": " + message;
chatMessages.appendChild(li);
}


function fetchChatHistory() {
	console.log("Fetching Chat History...")
var xhr = new XMLHttpRequest();
xhr.open("POST", "ChatServlet", true);
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xhr.onreadystatechange = function() {
if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
    var chatHistory = JSON.parse(xhr.responseText);
    chatMessages.innerHTML = "";
    chatHistory.forEach(function(item) {
        var author = item.sender === senderID ? sender : receiver;
        console.log(author);
        displayMessage(author, item.message);
    });
}
};
xhr.send("user=" + senderID + "&restaurant=" + receiverID + "&action=receive");
}

chatForm.addEventListener("submit", function(e) {
e.preventDefault();

var message = messageInput.value;
if (message.trim() !== "") {
sendMessage(senderID, message, receiverID);
messageInput.value = "";

// Display the sent message immediately
displayMessage(sender, message);
}
});

setInterval(function() {
	fetchChatHistory();
}, 5000);


</script>
        

        
        <script src="Resources/assets/js/jquery-1.11.3.min.js"></script>        
        <script src="Resources/assets/js/jquery.isotope-3.0.6.min.js"></script>        
        <script src="Resources/assets/js/owl.carousel.min.js"></script>        
        <script src="Resources/assets/js/jquery.magnific-popup.min.js"></script>       
        <script src="Resources/assets/js/sticker.js"></script>        
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
