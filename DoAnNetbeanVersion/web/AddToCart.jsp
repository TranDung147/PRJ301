<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Room" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Booking Status</title>
    <link href="assets/css/cart.css" rel="stylesheet" />
</head>
<body>
    <h1>Room Booking Status</h1>

   <div class="container">
    <% 
      Room bookedRoom = (Room) session.getAttribute("bookedRoom");
            if (bookedRoom != null) {
    %>
    <div class="success-msg">
        Room Booked Successfully!
    </div>
    <table>
        <tr>
            <th>Room ID</th>
            <th>Room Number</th>
            <th>Room Type</th>
            
        </tr>
        <tr>
            <td><%= bookedRoom.getRoomID() %></td>
            <td><%= bookedRoom.getRoomNumber() %></td>
            <td><%= bookedRoom.getRoomType() %></td>
           
        </tr>
    </table>
    <% } else { %>
    <div class="error-msg">
        Booking Failed. Please try again.
    </div>
    <% } //thieu session de chay lai roomDisplay%>
    <a class="text-link" href="roomDisplay.jsp">Continue viewing</a>
</div>
</body>
</html>
