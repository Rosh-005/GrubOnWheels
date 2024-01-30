<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Payment Transaction</title>
    <style>
        body {
        background-image: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(Resources/images/card.jpg);
        background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: gold;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        input[type="text"],
        input[type="email"]{
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="number"] {
            width: 50%;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }
    </style>
<script src="https://js.stripe.com/v3/"></script>
</head>
<body>

<%
            if (request.getParameter("Failed") != null) {
            	 String errorMessage = request.getParameter("errorMessage");
            	 if(errorMessage != null){%>
            		 <script>alert("<%=errorMessage%>");</script><%
            	 }
            	 else{%>
            		 <script>alert('Payment failed! Please try again');</script><%
            	 }%>
          
        <%}
        %>
        
<%
            if (request.getParameter("DBInsertFailed") != null) {%>
        <script>alert('Your order is not updated! Please try again...If transaction is completed, the payment will be refunded');</script>  
        <%}
        %>
        
    <div class="container">
        <h1>Payment Transaction Page</h1>
        <form action="PaymentServlet" method="post" id="payment-form">
            <label for="Name">Name: </label>
            
            <input type="text" id="name" name="name" placeholder="Enter your name" required><br>
            
            <label for="email">Email: </label>
            <input type="email" id="email" name="email" placeholder="Enter your email address" required><br>
            
            <%String totAmount = request.getParameter("orderTotal");%>
            <label for="amount">Amount:</label>
            <input type="text" id="amount" name="amount" value="<%=(totAmount!=null ? totAmount : session.getAttribute("orderTotal").toString()) %>" required readonly="readonly"><br>
            <div id="card-element"></div>
            <!-- Add a hidden field to store the Stripe publishable key -->
            <input type="hidden" id="stripePublicKey">
            <input type="hidden" id="stripeToken" name="stripeToken">
            
            <button type="button" id="payButton">Make Payment</button>
            
        </form>
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', async () => {
    	console.log('DOMContentLoaded event triggered');
        const stripePublicKey = 'pk_test_51NfmIXAgP2g1yK8lYSXx0IdNnSOfUUTsJ57ytkIPjtErGWed6joqclJXmqSUDL9plKG096HJvYbsgEE7CXInWhSm00WCM5yJgQ';
        const stripe = Stripe(stripePublicKey);
        var elements = stripe.elements();
        var card = elements.create('card', { hidePostalCode: true });
        
        // Mounting the card Element to the DOM
        card.mount('#card-element');
        
            console.log('Card Element is mounted');
        // Handling the payment button click
        document.getElementById('payButton').addEventListener('click', async () => {
        	console.log('Button clicked');
            const {token, error} = await stripe.createToken(card); 
            
            if (error) {
                
                console.error(error.message);
            } else {
                const form = document.querySelector('#payment-form');
                const tokenInput = document.getElementById('stripeToken');
                tokenInput.value = token.id;
                form.submit();
            }
        });
    });
    
</script>
    
</body>
</html>
