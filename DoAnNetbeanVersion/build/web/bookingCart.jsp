<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.User"%>
<%@page import="Model.UserDB"%>
<%@page import="Model.AllBookingDB"%>
<%@page import="java.util.List"%>
<%@page import="Model.HotelBooking"%>
<%@page import="Model.PlaneBooking"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
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
                        <a href="bookingCart.jsp">
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

                    <%
                        // Allow access only if session exists
                        String user = null;
                        String pass = null;
                        if (session.getAttribute("user") == null || session.getAttribute("pass") == null) {
                            response.sendRedirect("index.jsp");
                        } else {
                            user = (String) session.getAttribute("user");
                            pass = (String) session.getAttribute("pass");
                        }

                        String userName = null;
                        String sessionID = null;
                        Cookie[] cookies = request.getCookies();
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                if (cookie.getName().equals("user")) userName = cookie.getValue();
                                if (cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
                                if (cookie.getName().equals("pass")) pass = cookie.getValue();
                            }
                        } else {
                            sessionID = session.getId();
                        }

                        if (session != null) {
                            String sessionUser = (String) session.getAttribute("user");
                            String sessionPass = (String) session.getAttribute("pass");
                            if (sessionUser != null && sessionPass != null) {
                                userName = sessionUser;
                                pass = sessionPass;
                            }
                        }
                    
                        UserDB userDB = new UserDB();
                        User users = userDB.getUsers(userName, pass);
                    
                        if (users != null) {
                    %>
                    <div class="profile-card">
                        <div class="topbar-admin">
                            <div class="burger">
                                <div class="line1"></div>
                                <div class="line2"></div>
                                <div class="line3"></div>
                            </div>
                        </div>
                        <!-- Hiển thị session ID, username, và các thông tin khác -->
                        <div>
                            <h1>Your Cart Order</h1>
                        </div>

                        <%-- Hotel Bookings Section --%>
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
                                    <% 
                                       // Get all hotel bookings for the user
                                       AllBookingDB a = new AllBookingDB();
                                       
                                       List<HotelBooking> hotelBookings = a.getAllHotelBookings(users.getUserID());
                                       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                                       for (HotelBooking booking : hotelBookings) {
                                    %>
                                    <tr>
                                        <td><%= booking.getHotelName() %></td>
                                        <td><%= booking.getHotelAddress() %></td>
                                        <td><%= booking.getRoomNumber() %></td>
                                        <td><%= booking.getRoomType() %></td>
                                        <td><%= booking.getPrice() %></td>
                                        <td><%= booking.getDateFrom() %></td>
                                        <td><%= booking.getDateTo() %></td>
                                        <td><%= booking.getStatus() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>


                        <%-- Plane Bookings Section --%>
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
                                    <% 
                                        AllBookingDB b = new AllBookingDB();
                                        
                                       // Get all plane bookings for the user
                                       List<PlaneBooking> planeBookings = b.getAllPlaneBookings(users.getUserID());

                                       for (PlaneBooking booking : planeBookings) {
                                    %>
                                    <tr>
                                        <td><%= booking.getPlaneName() %></td>
                                        <td><%= booking.getLocationFrom() %></td>
                                        <td><%= booking.getLocationTo() %></td>
                                        <td><%= booking.getStartTime() %></td>
                                        <td><%= booking.getSeatNumber() %></td>
                                        <td><%= booking.getSeatType() %></td>
                                        <td><%= booking.getPrice() %></td>
                                        <td><%= booking.getStatus() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <% }%>


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