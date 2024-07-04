
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="Model.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Details Information</title>
    </head>
    <style>
        /* =============== Globals ============== */
        * {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --blue: #1b3661;
            --white: #fff;
            --gray: #f5f5f5;
            --black1: #222;
            --black2: #999;
        }

        body {
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container {
            position: relative;
            width: 100%;
        }

        /* =============== Navigation ================ */
        .topbar-details {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0 10px;
        }

        .topbar-details h3 {
            color: #fffdfde7;
            text-transform: uppercase;
            letter-spacing: 5px;
            font-size: 35px;
            transition: color 0.3s ease; /* Thêm hiệu ứng transition cho màu sắc */
        }

        .navigation-admin ul li:nth-child(1) {
            margin-bottom: 40px;
        }

        .navigation-admin .logo {
            display: block;
        }

        .navigation-admin.active .logo-text, .navigation-admin .logo-text {
            display: block; /* hide the QTALD when navigation is minimized */
            transition: opacity 0.3s ease; /* thêm hiệu ứng transition */
            opacity: 1; /* mặc định là hiển thị */
        }

        .navigation-admin.active ul .logo-text {
            opacity: 0; /* ẩn văn bản khi thanh điều hướng bị thu gọn */
        }

        .navigation-admin {
            position: fixed;
            width: 300px;
            height: 100%;
            background: var(--blue);
            border-left: 10px solid var(--blue);
            transition: 0.5s;
            overflow: hidden;
            z-index: 1000;
        }
        .navigation-admin.active {
            width: 80px;
        }

        .navigation-admin ul {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
        }

        .navigation-admin ul li {
            position: relative;
            width: 100%;
            list-style: none;
            border-top-left-radius: 30px;
            border-bottom-left-radius: 30px;
        }

        .navigation-admin ul li:hover,
        .navigation-admin ul li.hovered {
            background-color: var(--white);
        }

        /* Làm cho cái ul đầu tiên (QTALD) không có hiệu ứng lúc di chuột vào */
        .navigation-admin ul li:hover:nth-child(1) {
            background-color: var(--blue);
        }

        .navigation-admin ul li a {
            position: relative;
            display: block;
            width: 100%;
            display: flex;
            text-decoration: none;
            color: var(--white);
        }
        .navigation-admin ul li:hover a,
        .navigation-admin ul li.hovered a {
            color: var(--blue);
        }

        .navigation-admin ul li a .icon {
            position: relative;
            display: block;
            min-width: 60px;
            height: 50px;
            line-height: 85px;
            text-align: center;
            overflow: hidden;
        }
        .navigation-admin ul li a .icon img {
            width: 65%;
            height: 40px;
            max-width: 100%;
        }

        .navigation-admin ul li a .title {
            position: relative;
            display: block;
            padding: 0 10px;
            height: 60px;
            line-height: 60px;
            text-align: start;
            white-space: nowrap;
        }

        /* --------- curve outside ---------- */
        .navigation-admin ul li:hover a::before,
        .navigation-admin ul li.hovered a::before {
            content: "";
            position: absolute;
            right: 0;
            top: -50px;
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;
            box-shadow: 35px 35px 0 10px var(--white);
            pointer-events: none;
        }
        .navigation-admin ul li:hover a::after,
        .navigation-admin ul li.hovered a::after {
            content: "";
            position: absolute;
            right: 0;
            bottom: -50px;
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;
            box-shadow: 35px -35px 0 10px var(--white);
            pointer-events: none;
        }

        /* ===================== Main ===================== */
        .main-details {
            position: relative;
            width: calc(100% - 300px);
            left: 300px;
            background: var(--white);
            transition: 0.5s;
            overflow: hidden;
        }
        .main-details.active {
            width: 95%;
            left: 10px;
        }

        /* Add burger menu styles */
        .burger {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            width: 30px;
            height: 25px;
            cursor: pointer;
        }

        .burger div {
            width: 100%;
            height: 4px;
            background-color: #333;
            transition: all 0.3s ease;
            margin-left: 20px;
        }

        /* Adjust navigation slide-in behavior */
        .navigation-admin.active {
            left: 0; /* Ensure the navigation bar slides in from the left */
        }

        .main-details.active {
            margin-left: 80px; /* Adjust based on the width of the navigation bar */
        }

        /* ====================== Table ========================== */
        .table-type {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .btn {
            text-decoration: none;
            color: black;
            font-weight: bolder;
        }

        .table-details {
            width: 97%;
            padding: 20px;
            margin: 25px;
            grid-template-columns: 2fr 1fr;
            grid-gap: 30px;
            position: relative;
            min-height: 815px;
            background: var(--white);
            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            border-radius: 20px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .table-details table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .table-details table thead td {
            font-weight: 600;
        }
        .table-details table tr {
            color: var(--black1);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        .table-details table tr:last-child {
            border-bottom: none;
        }
        .table-details table tbody tr:hover {
            background: var(--gray);
            color: var(--black);
        }
        .table-details table tr td {
            padding: 10px;
        }

        /* ====================== Responsive Design ========================== */
        @media (max-width: 991px) {
            .navigation-admin {
                left: -300px;
            }
            .navigation-admin.active {
                width: 300px;
                left: 0;
            }
            .main-details {
                width: 100%;
                left: 0;
            }
            .main-details.active {
                left: 300px;
            }
        }

        @media (max-width: 480px) {
            .navigation-admin {
                width: 100%;
                left: -100%;
                z-index: 1000;
            }
            .navigation-admin.active {
                width: 100%;
                left: 0;
            }
            .toggle {
                z-index: 10001;
            }
            .main-details.active .toggle {
                color: #fff;
                position: fixed;
                right: 0;
                left: initial;
            }
            .topbar-details .Logo {
                font-size: 20px;
            }
        }
    </style>
    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li class="logo">
                        <a href="index.jsp">
                            <div class="topbar-details">
                                <h3 class="logo-text">QTALD</h3>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="adminDBoard.jsp">
                            <span class="icon">
                                <img src="img/admin/dashboard.png" alt="Dashboard">
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="adminOrder.jsp">
                            <span class="icon">
                                <img src="img/admin/order.png" alt="Order">
                            </span>
                            <span class="title">Order</span>
                        </a>
                    </li>
                    <li>
                        <a href="adminDetails.jsp">
                            <span class="icon">
                                <img src="img/admin/details.png" alt="Details">
                            </span>
                            <span class="title">Detail</span>
                        </a>
                    </li>
                    <li>
                        <a href="LogoutServlet">    <!-- Logout -->
                            <span class="icon">
                                <img src="img/admin/logout.png" alt="Messages">
                            </span>
                            <span class="title">Log out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- ========================= Main ==================== -->
            <div class="main-details">
                <div class="topbar-details">
                    <div class="burger">
                        <div class="line1"></div>
                        <div class="line2"></div>
                        <div class="line3"></div>
                    </div>
                </div>

                <!-- ========================= Type of Table ==================== -->
                <div class="table-type">
                    <form id="detailForm" method="post" action="adminDetails">
                        <label for="detailType">Select Detail Type:</label>
                        <select id="detailType" name="detailType" onchange="document.getElementById('detailForm').submit();">
                            <option value="Hotel" ${param.detailType == 'Hotel' ? 'selected' : ''}>Hotel</option>
                            <option value="Plane" ${param.detailType == 'Plane' ? 'selected' : ''}>Plane</option>
                            <option value="Flight" ${param.detailType == 'Flight' ? 'selected' : ''}>Flight</option>
                            <option value="Room" ${param.detailType == 'Room' ? 'selected' : ''}>Room</option>
                            <option value="Seat" ${param.detailType == 'Seat' ? 'selected' : ''}>Seat</option>
                        </select>
                    </form>
                </div>

                <!-- ========================= Data Table ==================== -->

                <div class="table-details">
                    <c:choose>
                        <c:when test="${param.detailType == 'Hotel'}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Hotel ID</th>
                                        <th>Name</th>
                                        <th>Address</th>
                                        <th>Description</th>
                                        <th>City</th>
                                        <th>Country</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="hotel" items="${hotels}">
                                        <tr>
                                            <td>${hotel.productImage}</td>
                                            <td>${hotel.hotelId}</td>
                                            <td>${hotel.hotelName}</td>
                                            <td>${hotel.hotelAddress}</td>
                                            <td>${hotel.hotelDescription}</td>
                                            <td>${hotel.city}</td>
                                            <td>${hotel.country}</td>
                                            <td>
                                                <a href="updateHotel.jsp?id=${hotel.id}">Update</a>
                                                <a href="deleteHotel?id=${hotel.id}">Delete</a>
                                                <a href="showHotel.jsp?id=${hotel.id}">Show</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a href="adminAddHotel.jsp" class="btn">Add Hotel</a>
                        </c:when>
                        <c:when test="${param.detailType == 'Plane'}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Plane ID</th>
                                        <th>Model</th>
                                        <th>Brand</th>
                                        <th>Capacity</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="plane" items="${planeList}">
                                        <tr>
                                            <td>${plane.planeImg}</td>
                                            <td>${plane.planeID}</td>
                                            <td>${plane.planeName}</td>
                                            <td>${plane.airline}</td>
                                            <td>${plane.noSeat}</td>
                                            <td>
                                                <a href="updatePlane.jsp?id=${plane.id}">Update</a>
                                                <a href="deletePlane?id=${plane.id}">Delete</a>
                                                <a href="showPlane.jsp?id=${plane.id}">Show</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a href="adminAddPlane.jsp" class="btn">Add Plane</a>
                        </c:when>
                        <c:when test="${param.detailType == 'Flight'}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Flight ID</th>
                                        <th>Plane ID</th>
                                        <th>Date Start</th>
                                        <th>Date End</th>
                                        <th>Departure</th>
                                        <th>Arrival</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="flight" items="${flightList}">
                                        <tr>
                                            <td>${flight.id}</td>
                                            <td>${flight.planeId}</td>
                                            <td>${flight.dateStart}</td>
                                            <td>${flight.dateEnd}</td>
                                            <td>${flight.departure}</td>
                                            <td>${flight.arrival}</td>
                                            <td>
                                                <a href="updateFlight.jsp?id=${flight.id}">Update</a>
                                                <a href="deleteFlight?id=${flight.id}">Delete</a>
                                                <a href="showFlight.jsp?id=${flight.id}">Show</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a href="adminAddFlight.jsp" class="btn">Add Flight</a>
                        </c:when>
                        <c:when test="${param.detailType == 'Room'}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Room ID</th>
                                        <th>Room Number</th>
                                        <th>Type</th>
                                        <th>Availability</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="room" items="${roomList}">
                                        <tr>
                                            <td>${room.roomID}</td>
                                            <td>${room.roomNumber}</td>
                                            <td>${room.roomType}</td>
                                            <td>${room.isAvailable}</td>
                                            <td>
                                                <a href="updateRoom.jsp?id=${room.id}">Update</a>
                                                <a href="deleteRoom?id=${room.id}">Delete</a>
                                                <a href="showRoom.jsp?id=${room.id}">Show</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a href="adminAddRoom.jsp" class="btn">Add Room</a>
                        </c:when>
                        <c:when test="${param.detailType == 'Seat'}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Seat ID</th>
                                        <th>Flight ID</th>
                                        <th>Seat Number</th>
                                        <th>Type</th>
                                        <th>Availability</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="seat" items="${seatList}">
                                        <tr>
                                            <td>${seat.id}</td>
                                            <td>${seat.flightId}</td>
                                            <td>${seat.seatNo}</td>
                                            <td>${seat.type}</td>
                                            <td>${seat.availability}</td>
                                            <td>
                                                <a href="updateSeat.jsp?id=${seat.id}">Update</a>
                                                <a href="deleteSeat?id=${seat.id}">Delete</a>
                                                <a href="showSeat.jsp?id=${seat.id}">Show</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a href="adminAddSeat.jsp" class="btn">Add Seat</a>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
        <script src="assets/js/chartsJS.js"></script>

        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const burger = document.querySelector('.burger');
                                const navigation = document.querySelector('.navigation-admin');
                                const main = document.querySelector('.main-details');

                                burger.addEventListener('click', function () {
                                    navigation.classList.toggle('active');
                                    main.classList.toggle('active');
                                });
                            });
        </script>
    </body>
</html>
