<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.HotelBooking" %>
<%@ page import="Model.PlaneBooking" %>
<%@ page import="Model.AllBookingDB" %>
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
            <!-- Hotel Booking Table -->
            <table>
                <caption>Hotel Booking</caption>
                <thead>
                    <tr>
                        <th>HotelName</th>
                        <th>HotelAddress</th>
                        <th>RoomNumber</th>
                        <th>RoomType</th>
                        <th>Price</th>
                        <th>DateFrom</th>
                        <th>DateTo</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AllBookingDB a = new AllBookingDB();
                        List<HotelBooking> hotelBookings = a.getAllHotelBookings();
                        request.setAttribute("hotelBookings", hotelBookings);
                    %>
                    <c:forEach var="hotelBooking" items="${hotelBookings}">
                        <tr>
                            <td><c:out value="${hotelBooking.hotelName}"/></td>
                            <td><c:out value="${hotelBooking.hotelAddress}"/></td>
                            <td><c:out value="${hotelBooking.roomNumber}"/></td>
                            <td><c:out value="${hotelBooking.roomType}"/></td>
                            <td><c:out value="${hotelBooking.price}"/></td>
                            <td><c:out value="${hotelBooking.dateFrom}"/></td>
                            <td><c:out value="${hotelBooking.dateTo}"/></td>
                            <td><c:out value="${hotelBooking.status}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Plane Booking Table -->
            <table>
                <caption>Plane Booking</caption>
                <thead>
                    <tr>
                        <th>PlaneName</th>
                        <th>StartTime</th>
                        <th>LocationFrom</th>
                        <th>LocationTo</th>
                        <th>SeatNumber</th>
                        <th>SeatType</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AllBookingDB b = new AllBookingDB();
                        List<PlaneBooking> planeBookings = b.getAllPlaneBookings();
                        request.setAttribute("planeBookings", planeBookings);
                    %>
                    <c:forEach var="planeBooking" items="${planeBookings}">
                        <tr>
                            <td><c:out value="${planeBooking.planeName}"/></td>
                            <td><c:out value="${planeBooking.startTime}"/></td>
                            <td><c:out value="${planeBooking.locationFrom}"/></td>
                            <td><c:out value="${planeBooking.locationTo}"/></td>
                            <td><c:out value="${planeBooking.seatNumber}"/></td>
                            <td><c:out value="${planeBooking.seatType}"/></td>
                            <td><c:out value="${planeBooking.price}"/></td>
                            <td><c:out value="${planeBooking.status}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
