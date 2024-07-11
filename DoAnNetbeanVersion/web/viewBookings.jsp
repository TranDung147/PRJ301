<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.BookingRoom" %>
<%@ page import="Model.BookingRoomDetail" %>
<%@ page import="Model.BookingTicket" %>
<%@ page import="Model.BookingTicketDetail" %>
<%@ page import="DAO.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .table-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        table {
            width: 48%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Booking Information</h1>
        <div class="table-container">
            <!-- Booking Room Table -->
            <table>
                <caption>Booking Room</caption>
                <thead>
                    <tr>
                        <th>RoomBookingID</th>
                        <th>UserID</th>
                        <th>TotalPrice</th>
                        <th>CreatedDate</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AllBookingDB a = new AllBookingDB();
                        List<BookingRoom> bookingRooms = a.getAllBookingRooms();
                        request.setAttribute("bookingRooms", bookingRooms);
                    %>
                    <c:forEach var="bookingRoom" items="${bookingRooms}">
                        <tr>
                            <td><c:out value="${bookingRoom.roomBookingID}"/></td>
                            <td><c:out value="${bookingRoom.userID}"/></td>
                            <td><c:out value="${bookingRoom.totalPrice}"/></td>
                            <td><c:out value="${bookingRoom.createdDate}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Booking Room Detail Table -->
            <table>
                <caption>Booking Room Detail</caption>
                <thead>
                    <tr>
                        <th>RoomBookingID</th>
                        <th>RoomID</th>
                        <th>Price</th>
                        <th>DateFrom</th>
                        <th>DateTo</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AllBookingDB b = new AllBookingDB();
                        List<BookingRoomDetail> bookingRoomDetails = b.getAllBookingRoomDetails();
                        request.setAttribute("bookingRoomDetails", bookingRoomDetails);
                    %>
                    <c:forEach var="bookingRoomDetail" items="${bookingRoomDetails}">
                        <tr>
                            <td><c:out value="${bookingRoomDetail.roomBookingID}"/></td>
                            <td><c:out value="${bookingRoomDetail.roomID}"/></td>
                            <td><c:out value="${bookingRoomDetail.price}"/></td>
                            <td><c:out value="${bookingRoomDetail.dateFrom}"/></td>
                            <td><c:out value="${bookingRoomDetail.dateTo}"/></td>
                            <td><c:out value="${bookingRoomDetail.status}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Booking Ticket Table -->
            <table>
                <caption>Booking Ticket</caption>
                <thead>
                    <tr>
                        <th>TicketBookingID</th>
                        <th>UserID</th>
                        <th>TotalPrice</th>
                        <th>CreatedDate</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AllBookingDB c = new AllBookingDB();
                        List<BookingTicket> bookingTickets = c.getAllBookingTickets();
                        request.setAttribute("bookingTickets", bookingTickets);
                    %>
                    <c:forEach var="bookingTicket" items="${bookingTickets}">
                        <tr>
                            <td><c:out value="${bookingTicket.ticketBookingID}"/></td>
                            <td><c:out value="${bookingTicket.userID}"/></td>
                            <td><c:out value="${bookingTicket.totalPrice}"/></td>
                            <td><c:out value="${bookingTicket.createdDate}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Booking Ticket Detail Table -->
            <table>
                <caption>Booking Ticket Detail</caption>
                <thead>
                    <tr>
                        <th>BookingTicketID</th>
                        <th>SeatID</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AllBookingDB d = new AllBookingDB();
                        List<BookingTicketDetail> bookingTicketDetails = d.getAllBookingTicketDetails();
                        request.setAttribute("bookingTicketDetails", bookingTicketDetails);
                    %>
                    <c:forEach var="bookingTicketDetail" items="${bookingTicketDetails}">
                        <tr>
                            <td><c:out value="${bookingTicketDetail.bookingTicketID}"/></td>
                            <td><c:out value="${bookingTicketDetail.seatID}"/></td>
                            <td><c:out value="${bookingTicketDetail.price}"/></td>
                            <td><c:out value="${bookingTicketDetail.status}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
                    
                    
        </div>
    </div>
</body>
</html>
