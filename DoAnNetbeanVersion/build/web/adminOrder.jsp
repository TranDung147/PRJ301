<%-- 
    Document   : order
    Created on : Jul 1, 2024, 11:44:43 PM
    Author     : plmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="Model.BookingRoomDetail" %>
<%@ page import="Model.BookingTicketDetail" %>
<%@ page import="Model.AllBookingDB" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Order Management</title>

        <!-- Bootstrap JS and dependencies 
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/index.css" rel="stylesheet" />
        <link href="assets/css/sort.css" rel="stylesheet" />
        <link href="assets/css/responsive" rel="stylesheet"/> -->
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
        .topbar-order {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0 10px;
        }

        .topbar-order h3 {
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
        .main-order {
            position: relative;
            width: calc(100% - 300px);
            left: 300px;
            min-height: 100vh;
            background: var(--white);
            transition: 0.5s;
            overflow: hidden;
        }
        .main-order.active {
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

        .main-order.active {
            margin-left: 80px; /* Adjust based on the width of the navigation bar */
        }

        /* ====================== Table ========================== */
        .table-order {
            width: 97%;
            padding: 20px;
            margin: 25px;
            grid-template-columns: 2fr 1fr;
            grid-gap: 30px;
            position: relative;
            min-height: 810px;
            background: var(--white);
            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            border-radius: 20px;
            justify-content: space-between;
            align-items: flex-start;
        }

        .table-order h2 {
            font-weight: 600;
            color: var(--blue);
        }

        .table-order a {
            text-decoration: none;
            color: var(--black1);
        }

        .top-table-order {
            display: flex;
        }

        .bot-table-order {
            display: flex;
        }

        .table-order table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .table-order table thead td {
            font-weight: 600;
        }
        .table-order table tr {
            color: var(--black1);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        .table-order table tr:last-child {
            border-bottom: none;
        }
        .table-order table tbody tr:hover {
            background: var(--gray);
            color: var(--black);
        }
        .table-order table tr td {
            padding: 10px;
        }

        /* Căn chỉnh vị trí thông tin của bảng */
        .table-order table tr td:nth-child(1) {
            text-align: left;
        }
        .table-order table tr td:nth-child(2) {
            text-align: center;
        }
        .table-order table tr td:nth-child(3) {
            text-align: center;
        }
        .table-order table tr td:nth-child(4) {
            text-align: center;
        }
        .table-order table tr td:nth-child(5) {
            text-align: center;
        }
        .table-order table tr td:last-child {
            text-align: end;
        }

        /* PENDINGPENDINGPENDINGPENDINGPENDINGPENDINGPENDINGPENDINGPENDING */
        .status.done {
            padding: 2px 4px;
            background: #8de02c;
            color: var(--white);
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
        }
        .status.processing {
            padding: 2px 4px;
            background: #e9b10a;
            color: var(--white);
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
        }
        .status.canceled {
            padding: 2px 4px;
            background: #f00;
            color: var(--white);
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
        }

        /* PENDINGPENDINGPENDINGPENDINGPENDINGPENDINGPENDINGPENDINGPENDING */

        /* ====================== Responsive Design ========================== */
        @media (max-width: 991px) {
            .navigation-admin {
                left: -300px;
            }
            .navigation-admin.active {
                width: 300px;
                left: 0;
            }
            .main-order {
                width: 100%;
                left: 0;
            }
            .main-order.active {
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
            .main-order.active .toggle {
                color: #fff;
                position: fixed;
                right: 0;
                left: initial;
            }
            .topbar-order .Logo {
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
                            <div class="topbar-order">
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
            <div class="main-order">
                <div class="topbar-order">
                    <div class="burger">
                        <div class="line1"></div>
                        <div class="line2"></div>
                        <div class="line3"></div>
                    </div>
                </div>

                <div class="table-order">
                    <div class="top-table-order">
                        <h2>Room Orders</h2>
                    </div>
                    <div class="bot-table-order">
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Room ID</th>
                                    <th>Price</th>
                                    <th>Date From</th>
                                    <th>Date To</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                        AllBookingDB a = new AllBookingDB();
                        List<BookingRoomDetail> bookingRooms = a.getAllBookingRoomDetails();
                        request.setAttribute("bookingRooms", bookingRooms);
                                %>
                                <c:forEach var="order" items="${bookingRooms}">
                                    <tr>
                                        <td>${order.roomBookingID}</td>
                                        <td>${order.roomID}</td>
                                        <td>${order.price}</td>
                                        <td>${order.dateFrom}</td>
                                        <td>${order.dateTo}</td>
                                        <td>${order.status}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="table-order">
                    <div class="top-table-order">
                        <h2>Ticket Orders</h2>
                    </div>
                    <div class="bot-table-order">
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Seat ID</th>
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
                                <c:forEach var="order" items="${bookingTicketDetails}">
                                    <tr>
                                        <td>${order.bookingTicketID}</td>
                                        <td>${order.seatID}</td>
                                        <td>${order.price}</td>
                                        <td>${order.status}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const burger = document.querySelector('.burger');
                    const navigation = document.querySelector('.navigation-admin');
                    const main = document.querySelector('.main-order');

                    burger.addEventListener('click', function () {
                        navigation.classList.toggle('active');
                        main.classList.toggle('active');
                    });
                });
            </script>
        </div>
    </body>
</html>