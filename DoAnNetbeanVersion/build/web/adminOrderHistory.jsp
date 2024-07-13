<%-- 
    Document   : adminOrderHistory
    Created on : Jul 4, 2024, 5:48:09 PM
    Author     : plmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="DAO.TransactionDB" %>
<%@ page import="Model.Transaction" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Order History Page</title>
        <style>
            /* =============== CHANGED IN THIS FILE ============== */
            .action-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px; /* Adjust the gap between buttons */
            }

            .action-buttons form {
                margin: 0; /* Remove default form margins */
            }

            .action-buttons button {
                border: none;
                background: none;
                padding: 0;
                cursor: pointer;
            }

            .action-buttons button img {
                vertical-align: middle; /* Align image vertically within the button */
            }

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
            .topbar-history {
                width: 100%;
                height: 60px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 0 10px;
            }

            .topbar-history h3 {
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

            .navigation-admin ul li.logo:hover a::before,
            .navigation-admin ul li.logo.hovered a::before,
            .navigation-admin ul li.logo:hover a::after,
            .navigation-admin ul li.logo.hovered a::after {
                content: none; /* Remove the curve motion effect for the QTALD logo */
            }

            /* ===================== Main ===================== */
            .main-history {
                position: relative;
                width: calc(100% - 300px);
                left: 300px;
                min-height: 100vh;
                background: var(--white);
                transition: 0.5s;
                overflow: hidden;
            }
            .main-history.active {
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

            .main-history.active {
                margin-left: 80px; /* Adjust based on the width of the navigation bar */
            }

            /* ====================== Table ========================== */
            .table-history {
                width: 97%;
                padding: 20px;
                margin: 25px;
                grid-template-columns: 2fr 1fr;
                grid-gap: 30px;
                position: relative;
                min-height: 150px;
                background: var(--white);
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
                justify-content: space-between;
                align-items: flex-start;
            }

            .table-history h2 {
                font-weight: 600;
                color: var(--blue);
            }

            .table-history a {
                text-decoration: none;
                color: var(--black1);
            }

            .top-table-history {
                display: flex;
            }

            .bot-table-history {
                display: flex;
            }

            .table-history table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            .table-history table thead td {
                font-weight: 600;
            }
            .table-history table tr {
                color: var(--black1);
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            }
            .table-history table tr:last-child {
                border-bottom: none;
            }
            .table-history table tbody tr:hover {
                background: var(--gray);
                color: var(--black);
            }
            .table-history table tr td {
                padding: 10px;
                text-align: center; /* Căn chỉnh vị trí thông tin của bảng */
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
                .main-history {
                    width: 100%;
                    left: 0;
                }
                .main-history.active {
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
                .main-history.active .toggle {
                    color: #fff;
                    position: fixed;
                    right: 0;
                    left: initial;
                }
                .topbar-history .logo {
                    font-size: 20px;
                }
            }
        </style>
    </head>
    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li class="logo">
                        <a href="index.jsp">
                            <div class="topbar-history">
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
                        <a href="adminOrderHistory.jsp">
                            <span class="icon">
                                <img src="img/admin/orderHistory.png" alt="Order History">
                            </span>
                            <span class="title">Order History</span>
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
            <div class="main-history">
                <div class="topbar-history">
                    <div class="burger">
                        <div class="line1"></div>
                        <div class="line2"></div>
                        <div class="line3"></div>
                    </div>
                </div>

                <!-- ========================= Processed Order History ==================== -->
                <div class="table-history">
                    <div class="top-table-history">
                        <h2>Processed Orders</h2>
                    </div>
                    <div class="bot-table-history">
                        <table>
                            <thead>
                                <tr>
                                    <th>Transaction ID</th>
                                    <th>User ID</th>
                                    <th>Room Booking ID</th>
                                    <th>Ticket Booking ID</th>
                                    <th>Date</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <%
                    TransactionDB transactionDB = new TransactionDB();
                    List<Transaction> transactions = transactionDB.getApprovedTransactions();
                    request.setAttribute("transactions", transactions);
                            %>
                            <tbody>
                                <%-- Retrieve transactions from the request attribute --%>
                                <c:forEach var="order" items="${transactions}">
                                    <tr>
                                        <td>${order.transactionId}</td>
                                        <td>${order.userId}</td>
                                        <td>${order.roomBookingId}</td>
                                        <td>${order.ticketBookingId}</td>
                                        <td>${order.transactionDate}</td>
                                        <td>${order.amount}</td>
                                        <td class="status">${order.status}</td>
                                        <td>
                                            <div class="action-buttons">

                                                <form action="AdminRemoveOrderHistoryServlet" method="post">
                                                    <input type="hidden" name="transactionId" value="${order.transactionId}">
                                                    <input type="hidden" name="roomBookingId" value="${order.roomBookingId}">
                                                    <input type="hidden" name="ticketBookingId" value="${order.ticketBookingId}">

                                                    <button type="submit" style="border:none; background:none; padding:0;">
                                                        <img src="img/admin/decline.png" value="room" alt="Remove" title="Remove" width="20px" height="20px" style="cursor:pointer;">
                                                    </button>
                                                </form>

                                                <form action="AdminOrderActionServlet" method="post">
                                                    <input type="hidden" name="transactionId" value="${order.transactionId}">
                                                    <input type="hidden" name="roomBookingId" value="${order.roomBookingId}">
                                                    <input type="hidden" name="ticketBookingId" value="${order.ticketBookingId}">

                                                    <button type="submit" name="action" value="viewDetails" class="view-details" data-transaction-id="${order.transactionId}" data-room-booking-id="${order.roomBookingId}" data-ticket-booking-id="${order.ticketBookingId}" style="border:none; background:none; padding:0;">
                                                        <img src="img/admin/view.png" alt="View" title="View Details" width="20px" height="20px" style="cursor:pointer;">
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const burger = document.querySelector('.burger');
                const navigation = document.querySelector('.navigation-admin');
                const main = document.querySelector('.main-history');

                burger.addEventListener('click', function () {
                    navigation.classList.toggle('active');
                    main.classList.toggle('active');
                });
            });
        </script>
    </body>
</html>
