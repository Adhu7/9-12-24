<%-- <%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>Payment Success</title>
</head>
<body>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }
    %>
    
    <%
        String paymentId = request.getParameter("razorpay_payment_id");
        String userId = request.getParameter("userId");
        String amount = request.getParameter("amount");

        if (paymentId != null && !paymentId.isEmpty()) {
            // Payment was successful
            // TODO: Insert order details into the database, and send confirmation email to the user
           
            out.println("<h2>Payment Successful!</h2>");
            out.println("<p>Payment ID: " + paymentId + "</p>");
            out.println("<p>User ID: " + userId + "</p>");
            out.println("<p>Total Amount: &#8377;" + amount + "</p>");
        } else {
            // Payment failed or was canceled
            out.println("<h2>Payment Failed!</h2>");
            out.println("<p>Please try again.</p>");
        }
    %>
</body>
</html>
 --%>
 <%@ page import="dao.PayementDao" %>
<%@ page import="bean.PaymentBean" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>Payment Success</title>
</head>
<body>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Retrieve payment details from the request
    String paymentId = request.getParameter("razorpay_payment_id");
    int userId = Integer.parseInt(request.getParameter("userId"));
    int artId = Integer.parseInt(request.getParameter("artId"));
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String zip = request.getParameter("zip");
    String country = request.getParameter("country");
    String phone = request.getParameter("phone");
    double amount = Double.parseDouble(request.getParameter("amount"));
    String paymentStatus = "Success"; // Assuming success for this scenario

    // Create PaymentBean and insert payment details into the database
    PaymentBean payment = new PaymentBean();
    payment.setUserId(userId);
    payment.setTransactionId(paymentId);
    payment.setArtId(artId);
    payment.setName(name);
    payment.setAddress(address);
    payment.setCity(city);
    payment.setState(state);
    payment.setZip(zip);
    payment.setCountry(country);
    payment.setPhone(phone);
    payment.setAmount(amount);
    payment.setPaymentStatus(paymentStatus);

    PayementDao paymentDao = new PayementDao();
    boolean isInserted = paymentDao.insertPayment(payment);

    if (isInserted) {
        // Display success message and payment details
         response.sendRedirect("home.jsp");
%>
<%--         <h2>Payment Successful!</h2>
        <p><strong>Payment ID:</strong> <%= paymentId %></p>
        <p><strong>User ID:</strong> <%= userId %></p>
        <p><strong>Art ID:</strong> <%= artId %></p>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Address:</strong> <%= address %></p>
        <p><strong>City:</strong> <%= city %></p>
        <p><strong>State:</strong> <%= state %></p>
        <p><strong>ZIP Code:</strong> <%= zip %></p>
        <p><strong>Country:</strong> <%= country %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
        <p><strong>Total Amount:</strong> &#8377;<%= amount %></p> --%>
        
      
<%
    } else {
        // Display error message if insertion fails
%>
        <h2>Payment Failed!</h2>
        <p>There was an issue saving your payment details. Please contact support.</p>
<%
    }
%>
</body>
</html>
 