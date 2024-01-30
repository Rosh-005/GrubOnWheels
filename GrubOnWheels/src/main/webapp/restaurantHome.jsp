<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="gow_login.RestaurantLogin"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.ChatMessage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
 
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Grub On Wheels</title>
 
  <link rel="stylesheet" href="Resources/Admin/vendors/feather/feather.css"> 
  <link rel="stylesheet" href="Resources/style.css">
  
  <link rel="stylesheet" href="Resources/Admin/vendors/ti-icons/css/themify-icons.css">
  
  <link rel="stylesheet" href="Resources/Admin/css/vertical-layout-light/style.css">
  <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.29.6.min.js"></script>
  
  <style>
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

  <div class="container-scroller">
    
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
    
    <div class="container-fluid page-body-wrapper">
      
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
      
      <div class="main-panel">
        <div class="content-wrapper" style="background-color: gold">
          <div class="row">
            <div class="col-md-12 grid-margin">
              <div class="row">
                <div class="col-12 col-xl-8 mb-4 mb-xl-0">
                
                  <h3 class="font-weight-bold">Heyyy! Up with any delicious stuff?</h3>
                  
                  <h6 class="font-weight-normal mb-0">Customers are waiting for you!</h6>
                  
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
          <br><br>
         
          <%String restid = (String)session.getAttribute("restid"); 
          String restname = session.getAttribute("restname").toString();
            /* int totalOrders = orderBean.getTotalOrders(session);
            int totalRevenue = orderBean.getTotalRevenue(session); */
          Connection conn = DatabaseConnection.getconnection();
          Statement stmt = conn.createStatement();
          Statement stmt1 = conn.createStatement();
          Statement stmt2= conn.createStatement();
          int totalMenu=0;;
          int totalOrders=0;
          double totalRevenue=0.0;
          try{
          ResultSet rs = stmt.executeQuery("Select count(dishname) as totmenu from restaurant_menu where restid='"+restid+"'");
          ResultSet rs1 = stmt1.executeQuery("Select count(oid) as totOrder from gow.useroders uo where DATE(STR_TO_DATE(uo.`time`,'%d/%m/%Y %H:%i:%s'))=CURDATE() and resid = '"+restid+"'");
          ResultSet rs2 = stmt2.executeQuery("Select sum(price) as totPrice from gow.useroders uo where DATE(STR_TO_DATE(uo.`time`,'%d/%m/%Y %H:%i:%s'))=CURDATE() and orderstatus not in ('waiting','Cancelled','Rejected') and resid = '"+restid+"'");
         if(rs.next() && rs1.next() && rs2.next()){
          totalMenu = rs.getInt("totmenu");
          totalOrders = rs1.getInt("totOrder");
          totalRevenue = rs2.getDouble("totPrice");
          System.out.println(totalRevenue);
         }
          %>
          <div>
           <!-- ...... -->
           <div class="resthomebox">
  <p style="color:white; text-align:center;font-size: larger;"><strong>Total Menus</strong></p>
  <p class="flipX" style="color:white; text-align:center;font-size: large;"><strong><%=totalMenu %></strong></p>
  
  </div>
  <div class="resthomebox" style="margin-left:30px">
  <p style="color:white; text-align:center;font-size: larger;"><strong>Total Orders</strong></p>
  <p class="flipX" style="color:white; text-align:center;font-size: large;"><strong><%=totalOrders %></strong></p>
 
</div>
 <div class="resthomebox" style="margin-left:30px">
  <p style="color:white; text-align:center;font-size: larger;"><strong>Total Revenue</strong></p>
  <p class="flipX" style="color:white; text-align:center;font-size: large;"><strong>£<%=totalRevenue %></strong></p>
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
          }
          catch(Exception e){
        		e.printStackTrace();	
        	} finally{
        		stmt.close();
        		stmt1.close();
        		stmt2.close();
        		conn.close();
        	} %>

   
<% List<ChatMessage> chatHistory = new ArrayList<ChatMessage>();
Map<String, List<ChatMessage>> userChatHistories = new HashMap<String, List<ChatMessage>>();
userChatHistories = (Map<String, List<ChatMessage>>) session.getAttribute("userChatHistories");
chatHistory = (ArrayList<ChatMessage>) session.getAttribute("interactedUser");%>
<div id="chatTab" class="chat-tab">
    Chat
</div>
<div id="chatBox" class="chat-box">
    <div class="chat-header" id="chatHeader" style="display: none">Chat History</div>
    <ul class="chat-messages" id="chatMessages" style="display: none"></ul>
    <form class="chat-form" id="chatForm" style="display: none">
        <input type="hidden" name="senderName" id="sender" value="<%=restname%>">
        <input type="hidden" id="receiver">
        <input type="text" id="messageInput" placeholder="Enter your message">
        <input type="hidden" id="userId">
        <input type="hidden" id="resId" value="<%=restid%>">
        <input type="submit" value="Send">
    </form>
    
    <div class="interacted-users" id="interactedUsers">
        <h3>Interacted Users</h3>
        <ul>
        </ul>
    </div>
</div>

<script>
const chatTab = document.getElementById("chatTab");
const chatBox = document.getElementById("chatBox");
const chatForm = document.getElementById("chatForm");
const chatHeader = document.getElementById("chatHeader");
const messageInput = document.getElementById("messageInput");
const chatMessages = document.getElementById("chatMessages");
const sender = document.getElementById("sender").value;
const senderID = document.getElementById("resId").value;

chatTab.addEventListener("click", () => {
console.log("Clicked");
chatBox.style.display = chatBox.style.display === "block" ? "none" : "block";

if (chatBox.style.display === "block") {
usersFetch();
}
});

const pubnub = new PubNub({
publishKey: 'pub-c-b5d94408-2f66-4494-8b38-8ca042919d8f',
subscribeKey: 'sub-c-ee94eeb3-6df1-42f5-8406-f2dbf56ca2d6'
});



function sendMessage(senderID, message, receiverID) {
var xhr = new XMLHttpRequest();
var restaurantName = document.getElementById("sender").value;
xhr.open("POST", "ChatServlet", true);
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xhr.send("user=" + receiverID + "&message=" + encodeURIComponent(message) + "&restaurant=" + senderID + "&action=send&restaurantName=" + restaurantName +"&sendaction=restaurant");
}


function displayMessage(user, message) {
console.log("Displaying...");
var li = document.createElement("li");
li.innerHTML = user + ": " + message;
chatMessages.appendChild(li);
}


function fetchChatHistory() {
	console.log("Fetching Chat History...")
	var receiverID = document.getElementById("userId").value;
	var receiver = document.getElementById("receiver").value
var xhr = new XMLHttpRequest();
xhr.open("POST", "ChatServlet", true);
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xhr.onreadystatechange = function() {
if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
    var chatHistory = JSON.parse(xhr.responseText);
    chatMessages.innerHTML = "";
    chatHistory.forEach(function(item) {
    	console.log("Hi");
        var author = item.sender === receiverID ? receiver : sender;
        console.log(author);
        displayMessage(author, item.message);
    });
}
};
xhr.send("user=" + receiverID + "&restaurant=" + senderID + "&action=receive");
}

function usersFetch(){
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "ChatServlet", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
	if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
		var userNamesMap = JSON.parse(xhr.responseText);
		var ulElement = document.getElementById("interactedUsers").getElementsByTagName("ul")[0];
        
        ulElement.innerHTML = "";

        for(var senderID in userNamesMap) {
            console.log("Hello");
            var liElement = document.createElement("li");
            var linkElement = document.createElement("a");
            linkElement.textContent = userNamesMap[senderID];
            linkElement.href = "#"; 
            linkElement.setAttribute("data-sender-id", senderID);
            linkElement.setAttribute("data-sender-name", userNamesMap[senderID]);

            linkElement.addEventListener("click", function(event) {
                event.preventDefault();

                selectedSenderID = this.getAttribute("data-sender-id");
                selectedSenderName = this.getAttribute("data-sender-name");

                document.getElementById("receiver").value = selectedSenderName;
                document.getElementById("userId").value = selectedSenderID;

                chatBox.style.display = "block";
                fetchChatHistory();
                chatMessages.style.display = "block";
                chatForm.style.display = "block";
                chatHeader.style.display = "block";
                
            });
            liElement.appendChild(linkElement);
            ulElement.appendChild(liElement);
        };
		}
	};
	xhr.send("restaurant=" + senderID + "&action=restaurantFetch");
}

chatForm.addEventListener("submit", function(e) {
e.preventDefault();

var message = messageInput.value;
var receiverID = document.getElementById("userId").value;
if (message.trim() !== "") {
sendMessage(senderID, message, receiverID);
messageInput.value = "";

// Display the sent message immediately
displayMessage(sender, message);
}
});

setInterval(function() {
	usersFetch();
}, 5000);

setInterval(function() {
	fetchChatHistory();
}, 5000);


</script>

  
  <script src="Resources/Admin/vendors/js/vendor.bundle.base.js"></script>
  <script src="Resources/Admin/js/hoverable-collapse.js"></script>
  <script src="Resources/Admin/js/template.js"></script>

</body>
</html>
