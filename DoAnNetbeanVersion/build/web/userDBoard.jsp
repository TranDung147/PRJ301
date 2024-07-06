<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.User"%>
<%@ page import="Model.UserDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Profile Details</title>
        <link href="assets/css/userdb.css" rel="stylesheet"/>
        <link href="assets/css/customer.css" rel="stylesheet"/> 
    </head>
     <style>
        /* Booking Tables */
        .booking-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .booking-table th, .booking-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .booking-table th {
            background-color: #f2f2f2;
        }

        .hotel-bookings, .plane-bookings {
            margin-top: 30px;
        }

        .hotel-bookings h2, .plane-bookings h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }
    </style>
    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li class="logo">
                        <div class="topbar-admin">
                            <a class="h3modi" href="index.jsp">
                                <h3 class="logo-text">QTALD</h3>
                            </a>
                        </div>
                    </li>
                    <li>
                        <a href="userDBoard.jsp">
                            <span class="icon">
                                <img src="img/admin/dashboard.png" alt="Dashboard">
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="customer.jsp">
                            <span class="icon">
                                <img src="img/admin/customer.png" alt="Information">
                            </span>
                            <span class="title">Information</span>
                        </a>
                    </li>
                    <li>
                        <a href="booking">
                            <span class="icon">
                                <img src="img/admin/order.png" alt="Booking Cart">
                            </span>
                            <span class="title">Cart</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- ========================= Main ==================== -->
            <div class="main-admin">
                <!-- =============== Header ================ -->
                <div class="information">
                    <jsp:useBean id="userDB" class="Model.UserDB" scope="session" />
                    <% 
                        // Gọi phương thức getUserFromSession từ UserDB
                        User user = userDB.getUserFromSession(session, request);
                        
                        if (user == null) {
                            response.sendRedirect("index.jsp");
                        } else {
                            request.setAttribute("user", user);
                        }
                    %>

                    <c:choose>
                        <c:when test="${user == null}">
                            <c:redirect url="index.jsp" />
                        </c:when>
                        <c:otherwise>
                            <div class="profile-card">
                                <div class="topbar-admin">
                                    <div class="burger">
                                        <div class="line1"></div>
                                        <div class="line2"></div>
                                        <div class="line3"></div>
                                    </div>
                                </div>
                                <div>
                                    <h1>User Dashboard</h1>
                                </div>
                                <!-- Hotel Bookings Section -->
                                <div class="hotel-bookings">
                                    <h2>Your Hotel Bookings</h2>
                                    <table class="booking-table">
                                        <thead>
                                            <tr>
                                                <th>Hotel Name</th>
                                                <th>Hotel Address</th>
                                                <th>Room Number</th>
                                                <th>Room Type</th>
                                                <th>Price</th>
                                                <th>Date From</th>
                                                <th>Date To</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="booking" items="${hotelBookings}">
                                                <tr>
                                                    <td><c:out value="${booking.hotelName}" /></td>
                                                    <td><c:out value="${booking.hotelAddress}" /></td>
                                                    <td><c:out value="${booking.roomNumber}" /></td>
                                                    <td><c:out value="${booking.roomType}" /></td>
                                                    <td><c:out value="${booking.price}" /></td>
                                                    <td><c:out value="${booking.dateFrom}" /></td>
                                                    <td><c:out value="${booking.dateTo}" /></td>
                                                    <td><c:out value="${booking.status}" /></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Plane Bookings Section -->
                                <div class="plane-bookings">
                                    <h2>Your Plane Bookings</h2>
                                    <table class="booking-table">
                                        <thead>
                                            <tr>
                                                <th>Plane Name</th>
                                                <th>Departure City</th>
                                                <th>Arrival City</th>
                                                <th>Start Time</th>
                                                <th>Seat Number</th>
                                                <th>Seat Type</th>
                                                <th>Price</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="booking" items="${planeBookings}">
                                                <tr>
                                                    <td><c:out value="${booking.planeName}" /></td>
                                                    <td><c:out value="${booking.locationFrom}" /></td>
                                                    <td><c:out value="${booking.locationTo}" /></td>
                                                    <td><c:out value="${booking.startTime}" /></td>
                                                    <td><c:out value="${booking.seatNumber}" /></td>
                                                    <td><c:out value="${booking.seatType}" /></td>
                                                    <td><c:out value="${booking.price}" /></td>
                                                    <td><c:out value="${booking.status}" /></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
                    
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const burger = document.querySelector('.burger');
                const navigation = document.querySelector('.navigation-admin');
                const main = document.querySelector('.main-admin');
                const profileCard = document.querySelector('.profile-card'); // Select the profile card

                burger.addEventListener('click', function () {
                    navigation.classList.toggle('active');
                    main.classList.toggle('active');
                    profileCard.classList.toggle('active'); // Toggle the active class on the profile card
                });
            });
        </script>


    </body>
</html>