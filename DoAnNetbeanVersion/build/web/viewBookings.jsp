<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Bookings</title>
    <!-- Add your CSS links here -->
</head>
<body>
    <h1>All Bookings</h1>
    
    <!-- Display Booking Room Data -->
    <h2>Booking Room Data</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Room Booking ID</th>
                <th>User ID</th>
                <th>Total Price</th>
                <th>Status</th>
                <th>Created Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="booking" items="${bookingRoomList}">
                <tr>
                    <td>${booking.RoomBookingID}</td>
                    <td>${booking.UserID}</td>
                    <td>${booking.TotalPrice}</td>
                    <td>${booking.Status}</td>
                    <td>${booking.CreatedDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- Display Booking Room Detail Data -->
    <h2>Booking Room Detail Data</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Room Booking ID</th>
                <th>Room ID</th>
                <th>Price</th>
                <th>Date From</th>
                <th>Date To</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="detail" items="${bookingRoomDetailList}">
                <tr>
                    <td>${detail.RoomBookingID}</td>
                    <td>${detail.RoomID}</td>
                    <td>${detail.Price}</td>
                    <td>${detail.DateFrom}</td>
                    <td>${detail.DateTo}</td>
                    <td>${detail.Status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- Display Booking Ticket Data -->
    <h2>Booking Ticket Data</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Ticket Booking ID</th>
                <th>User ID</th>
                <th>Total Price</th>
                <th>Status</th>
                <th>Created Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ticket" items="${bookingTicketList}">
                <tr>
                    <td>${ticket.TicketBookingID}</td>
                    <td>${ticket.UserID}</td>
                    <td>${ticket.TotalPrice}</td>
                    <td>${ticket.Status}</td>
                    <td>${ticket.CreatedDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- Display Booking Ticket Detail Data -->
    <h2>Booking Ticket Detail Data</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Booking Ticket ID</th>
                <th>Seat ID</th>
                <th>Price</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ticketDetail" items="${bookingTicketDetailList}">
                <tr>
                    <td>${ticketDetail.BookingTicketID}</td>
                    <td>${ticketDetail.SeatID}</td>
                    <td>${ticketDetail.Price}</td>
                    <td>${ticketDetail.Status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
</body>
</html>
