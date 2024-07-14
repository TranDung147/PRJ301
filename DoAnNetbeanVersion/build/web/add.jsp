<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Object</title>
        <!-- Include your CSS and JavaScript files -->
        <link rel="stylesheet" href="admindb.css">
        <script src="scripts.js"></script>
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
        .topbar-admin {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0 10px;
        }

        .topbar-admin h3 {
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
        .main-admin {
            position: relative;
            width: calc(100% - 300px);
            left: 300px;
            background: var(--white);
            transition: 0.5s;
        }
        .main-admin.active {
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

        .main-admin.active {
            margin-left: 80px; /* Adjust based on the width of the navigation bar */
        }

        /* ====================== Form ========================== */
        .add-form h2 {
            font-weight: 650;
            letter-spacing: 2px;
            color: var(--blue);
        }

        .add-form {
            background-color: #fff;
            padding: 20px;
            margin: 20px auto;
            width: 80%;
            max-width: 600px;
            background: var(--white);
            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            border-radius: 20px;
        }

        form {
            margin-top: 20px;
        }

        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        form input[type="text"],
        form input[type="number"],
        form textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        form button {
            background-color: #2e4c7d; /* #4CAF50 */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #121e31; /* #45a049 */
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
            .main-admin {
                width: 100%;
                left: 0;
            }
            .main-admin.active {
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
            .main-admin.active .toggle {
                color: #fff;
                position: fixed;
                right: 0;
                left: initial;
            }
            .topbar-admin .Logo {
                font-size: 20px;
            }
        }
    </style>
    <body>
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li class="logo">
                        <a href="index.jsp">
                            <div class="topbar-admin">
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
                        <a href="adminDetails?detailType=Hotel">
                            <span class="icon">
                                <img src="img/admin/details.png" alt="Details">
                            </span>
                            <span class="title">Detail</span>
                        </a>
                    </li>
                    <li>
                        <a onclick="logout();">    <!-- Logout -->
                            <span class="icon">
                                <img src="img/admin/logout.png" alt="Messages">
                            </span>
                            <span class="title">Log out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="main-admin">
                <div class="topbar-admin">
                    <div class="burger">
                        <div class="line1"></div>
                        <div class="line2"></div>
                        <div class="line3"></div>
                    </div>
                </div>
                <div class="add-form">
                    <c:choose>
                        <c:when test="${param.object == 'hotel'}">
                            <h2>Add Hotel</h2>
                            <form action="AddServlet?object=hotel" method="POST">
                                <label>ID:</label>
                                <input type="text" name="hotelID" required>
                                <label>Name:</label>
                                <input type="text" name="hotelName" required>
                                <label>Address:</label>
                                <input type="text" name="hotelAddress" required>
                                <label>Description:</label>
                                <textarea name="hotelDescription"></textarea>
                                <label>City:</label>
                                <input type="text" name="city" required>
                                <label>Country:</label>
                                <input type="text" name="country" required>
                                <label>Image URL</label>
                                <input type="text" name="productImg" required>
                                <button type="submit">Add Hotel</button>
                            </form>
                        </c:when>
                        <c:when test="${param.object == 'plane'}">
                            <h2>Add Plane</h2>
                            <form action="AddServlet?object=plane" method="POST">
                                <label>ID:</label>
                                <input type="text" name="planeID" required>
                                <label>Name:</label>
                                <input type="text" name="planeName" required>
                                <label>Airline:</label>
                                <input type="text" name="airline" required>
                                <label>Image:</label>
                                <input type="text" name="planeImg" required>
                                <label>Number of Seats:</label>
                                <input type="number" name="noSeat" required>
                                <button type="submit">Add Plane</button>
                            </form>
                        </c:when>

                        <c:when test="${param.object == 'flight'}">
                            <h2>Add Flight</h2>
                            <form action="AddServlet?object=flight" method="POST">
                                <label>Flight ID:</label>
                                <input type="text" name="flightID" required>
                                <label>Plane ID:</label>
                                <input type="text" name="planeID" required>
                                <label>Date Start:</label>
                                <input type="date" name="dateStart" required>
                                <label>Date End:</label>
                                <input type="date" name="dateEnd" required>
                                <label>Departure City:</label>
                                <input type="text" name="departureCity" required>
                                <label>Arrival City:</label>
                                <input type="text" name="arrivalCity" required>
                                <label>Number of Seats Left:</label>
                                <input type="number" name="noSeatLeft" required>
                                <button type="submit">Add Flight</button>
                            </form>
                        </c:when>

                        <c:when test="${param.object == 'room'}">
                            <h2>Add Room</h2>
                            <form action="AddServlet?object=room" method="POST">
                                <label>Room ID:</label>
                                <input type="text" name="roomID" required>
                                <label>Hotel ID:</label>
                                <input type="text" name="hotelID" required>
                                <label>Room Number:</label>
                                <input type="number" name="roomNumber" required>
                                <label>Room Type:</label>
                                <select name="roomType" required>
                                    <option value="VIP">VIP</option>
                                    <option value="Standard">Standard</option>
                                </select>
                                <label>Capacity:</label>
                                <input type="number" name="capacity" required>
                                <label>Is Available:</label>
                                <select name="isAvailable" required>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>
                                <button type="submit">Add Room</button>
                            </form>
                        </c:when>

                        <c:when test="${param.object == 'seat'}">
                            <h2>Add Seat</h2>
                            <form action="AddServlet?object=seat" method="POST">
                                <label>Seat ID:</label>
                                <input type="text" name="seatID" required>
                                <label>Flight ID:</label>
                                <input type="text" name="flightID" required>
                                <label>Seat Number:</label>
                                <input type="number" name="seatNumber" required>
                                <label>Seat Type:</label>
                                <select name="seatType" required>
                                    <option value="VIP">VIP</option>
                                    <option value="Standard">Standard</option>
                                </select>
                                <label>Is Available:</label>
                                <select name="isAvailable" required>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>
                                <button type="submit">Add Seat</button>
                            </form>
                        </c:when>

                    </c:choose>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const burger = document.querySelector('.burger');
                const navigation = document.querySelector('.navigation-admin');
                const main = document.querySelector('.main-admin');

                burger.addEventListener('click', function () {
                    navigation.classList.toggle('active');
                    main.classList.toggle('active');
                });
            });
        </script>
    </body>
</html>
