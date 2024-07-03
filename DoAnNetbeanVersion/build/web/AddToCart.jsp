<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Booking Details</h1>
    
    <% 
        Object bookedItem = session.getAttribute("bookedItem");
        List<Model.BookingTicketDetail> bookingTicketDetails = (List<Model.BookingTicketDetail>) session.getAttribute("bookingTicketDetails");
        
        if (bookedItem != null && bookedItem instanceof Model.Room) {
            Model.Room room = (Model.Room) bookedItem;
    %>
            <h2>Room Information:</h2>
            <p>Room ID: <%= room.getRoomID() %></p>
            <p>Room Number: <%= room.getRoomNumber() %></p>         
            <p>RoomType: <%= room.getRoomType() %></p>
    <% 
        }
        
        if (bookingTicketDetails != null && !bookingTicketDetails.isEmpty()) {
    %>
            <h2>Booking Ticket Details:</h2>
            <table>
                <thead>
                    <tr>
                        <th>Booking Ticket ID</th>
                        <th>Seat ID</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Model.BookingTicketDetail detail : bookingTicketDetails) { %>
                        <tr>
                            <td><%= detail.getBookingTicketID() %></td>
                            <td><%= detail.getSeatID() %></td>
                            <td><%= detail.getPrice() %></td>
                            <td><%= detail.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
    <% 
        }
        
        if (bookedItem == null && (bookingTicketDetails == null || bookingTicketDetails.isEmpty())) {
            out.println("No booking details available.");
        }
    %>
  <br/>
    <a href="index.jsp">Back to Home</a>
</body>
</html>
