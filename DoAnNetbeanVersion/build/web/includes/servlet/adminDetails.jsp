<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Details Information</title>
        <link href="assets/css/admindb.css" rel="stylesheet"/>
    </head>
    <style>
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
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
        }

        .table-details .addsearch {
            display: flex; /* Sắp xếp các phần tử trong addsearch theo hàng ngang */
            justify-content: space-between; /* Căn phần tử trái và phải của addsearch ra hai đầu */
            align-items: center; /* Căn phần tử theo chiều dọc */
            margin-bottom: 20px; /* Khoảng cách dưới addsearch */
        }

        .table-details .addsearch button{
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            text-decoration: none;
            border-radius: 5px;
        }
        .table-details table td, .table-details table th {
            text-align: center;
            vertical-align: middle;
        }

        .table-details .addsearch button:hover {
            background-color: #45a049; /* Đổi màu nền khi di chuột qua */
        }
        .addsearch .btn {
            background-color: #007bff; /* Màu nền */
            margin-right: 5px;
            color: white; /* Màu chữ */
            padding: 10px 20px; /* Khoảng cách bên trong */
            text-decoration: none; /* Loại bỏ gạch chân */
            border-radius: 5px; /* Bo góc */
            border: none; /* Loại bỏ viền */
            font-size: 16px; /* Cỡ chữ */
            transition: background-color 0.3s ease; /* Hiệu ứng khi hover */
        }

        .addsearch .btn:hover {
            background-color: #0056b3; /* Màu nền khi hover */
        }

        /* Định kiểu cho form tìm kiếm */
        .addsearch form {
            display: flex;
            align-items: center;
        }

        .addsearch input[type="text"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
            font-size: 16px;
            width:300px;
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
        .table-details table tr td a {
            display: inline-block;
            padding: 5px 15px;
            margin: 2px 5px;

            border-radius: 3px;
            text-decoration: none;
            font-size: 14px;
            width: 80px;
        }

        .table-details table tr td a.update-btn {
            background-color: #007bff;
            color: white;
        }

        .table-details table tr td a.update-btn:hover {
            background-color: #0056b3;
        }

        .table-details table tr td a.delete-btn {
            background-color: #dc3545;
            color: white;
        }

        .table-details table tr td a.delete-btn:hover {
            background-color: #c82333;
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
        <jsp:useBean id="userDB" class="DAO.UserDB" scope="session" />
        <%
            // Get the user from the session
            User user = userDB.getUserFromSession(session, request);

            // Check if the user is logged in and is an admin
            if (user == null || !"admin".equals(user.getUsername())) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>
        <!-- =============== Navigation ================ -->
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
                        <a href="AdminServlet?action=fetchDetails&detailType=Hotel">
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
                    <form id="detailForm" method="post" action="AdminServlet?action=fetchDetails">
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
                            <div class="addsearch">
                                <a href="AddServlet?object=hotel" class="btn">Add Hotel</a>
                                <form action="searchHotelServlet" method="GET">
                                    <input type="text" id="searchHotel" placeholder="Search..." oninput="performSearch('Hotel')">
                                </form>
                            </div>
                            <table data-type="Hotel">
                                <thead>
                                    <tr>
                                        <th>Hotel ID</th>
                                        <th>Name</th>
                                        <th>Address</th>
                                        <th>Description</th>
                                        <th>City</th>
                                        <th>Country</th>
                                        <th>ImageURL</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="hotelTableBody">
                                    <c:forEach var="hotel" items="${hotels}">
                                        <tr>
                                            <td>${hotel.hotelId}</td>
                                            <td>${hotel.hotelName}</td>
                                            <td>${hotel.hotelAddress}</td>
                                            <td>${hotel.hotelDescription}</td>
                                            <td>${hotel.city}</td>
                                            <td>${hotel.country}</td>
                                            <td>${hotel.productImage}</td>
                                            <td>
                                                <a href="CRUD?id=${hotel.hotelId}&detailType=Hotel&action=update" class="update-btn">Update</a>
                                                <a href="CRUD?id=${hotel.hotelId}&detailType=Hotel&action=delete" class="delete-btn">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </c:when>

                        <c:when test="${param.detailType == 'Plane'}">
                            <div class="addsearch">
                                <a href="AddServlet?object=plane" class="btn">Add Plane</a>
                                <form action="searchPlaneServlet" method="GET">
                                    <input type="text" id="searchPlane" placeholder="Search..." oninput="performSearch('Plane')">
                                </form>
                            </div>
                            <table data-type="Plane">
                                <thead>
                                    <tr>
                                        <th>Plane ID</th>
                                        <th>Plane Name</th>
                                        <th>Airline</th>
                                        <th>ImageURL</th>
                                        <th>Number of Seat</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="planeTableBody">
                                    <c:forEach var="plane" items="${planes}">
                                        <tr>
                                            <td>${plane.planeID}</td>
                                            <td>${plane.planeName}</td>
                                            <td>${plane.airline}</td>
                                            <td>${plane.planeImg}</td>
                                            <td>${plane.noSeat}</td>
                                            <td>
                                                <a href="CRUD?id=${plane.planeID}&detailType=Plane&action=update" class="update-btn">Update</a>
                                                <a href="CRUD?id=${plane.planeID}&detailType=Plane&action=delete" class="delete-btn">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </c:when>
                        <c:when test="${param.detailType == 'Flight'}">
                            <div class="addsearch">
                                <a href="AddServlet?object=flight" class="btn">Add Flight</a>
                                <form action="searchFlightServlet" method="GET">
                                    <input type="text" id="searchFlight" placeholder="Search..." oninput="performSearch('Flight')">                                  
                                </form>
                            </div>
                            <table data-type="Flight">
                                <thead>
                                    <tr>
                                        <th>Flight ID</th>
                                        <th>Plane ID</th>
                                        <th>Date Start</th>
                                        <th>Date End</th>
                                        <th>Departure</th>
                                        <th>Arrival</th>
                                        <th>Number of Seat Left</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="flightTableBody">
                                    <c:forEach var="flight" items="${flights}">
                                        <tr>
                                            <td>${flight.flightID}</td>
                                            <td>${flight.planeID}</td>
                                            <td>${flight.dateStart}</td>
                                            <td>${flight.dateEnd}</td>
                                            <td>${flight.departureCity}</td>
                                            <td>${flight.arrivalCity}</td>
                                            <td>${flight.noSeatLeft}</td>
                                            <td>
                                                <a href="CRUD?id=${flight.flightID}&planeId=${flight.planeID}&detailType=Flight&action=update" class="update-btn">Update</a>
                                                <a href="CRUD?id=${flight.flightID}&detailType=Flight&action=delete" class="delete-btn">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:when test="${param.detailType == 'Room'}">
                            <div class="addsearch">
                                <a href="AddServlet?object=room" class="btn">Add Room</a>
                                <form action="searchRoomServlet" method="GET">
                                    <input type="text" id="searchRoom" placeholder="Search..." oninput="performSearch('Room')">                                  
                                </form>
                            </div>
                            <table data-type="Room">
                                <thead>
                                    <tr>
                                        <th>Room ID</th>
                                        <th>Hotel ID</th>
                                        <th>Room Number</th>
                                        <th>Type</th>
                                        <th>Capacity</th>
                                        <th>Availability</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="roomTableBody">
                                    <c:forEach var="room" items="${rooms}">
                                        <tr>
                                            <td>${room.roomID}</td>
                                            <td>${room.hotelID}</td>
                                            <td>${room.roomNumber}</td>
                                            <td>${room.roomType}</td>
                                            <td>${room.capacity}</td>
                                            <td>${room.isAvailable}</td>
                                            <td>
                                                <a href="CRUD?id=${room.roomID}&hotelID=${room.hotelID}&detailType=Room&action=update" class="update-btn">Update</a>
                                                <a href="CRUD?id=${room.roomID}&detailType=Room&action=delete" class="delete-btn">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:when test="${param.detailType == 'Seat'}">
                            <div class="addsearch">
                                <a href="AddServlet?object=seat" class="btn">Add Seat</a>
                                <form action="searchSeatServlet" method="GET">
                                    <input type="text" id="searchSeat" placeholder="Search..." oninput="performSearch('Seat')">                                 
                                </form>
                            </div>
                            <table data-type="Seat">
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
                                <tbody id="seatTableBody">
                                    <c:forEach var="seat" items="${seats}">
                                        <tr>
                                            <td>${seat.seatID}</td>
                                            <td>${seat.flightID}</td>
                                            <td>${seat.seatNumber}</td>
                                            <td>${seat.seatType}</td>
                                            <td>${seat.isAvailable}</td>
                                            <td>
                                                <a href="CRUD?id=${seat.seatID}&flightID=${seat.flightID}&detailType=Seat&action=update" class="update-btn">Update</a>
                                                <a href="CRUD?id=${seat.seatID}&detailType=Seat&action=delete" class="delete-btn">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <script>

            function performSearch(type) {
                let valueSearchInput;
                let tableBody;

                switch (type) {
                    case 'Hotel':
                        valueSearchInput = document.getElementById("searchHotel").value.trim().toUpperCase();
                        tableBody = document.getElementById("hotelTableBody");
                        break;
                    case 'Plane':
                        valueSearchInput = document.getElementById("searchPlane").value.trim().toUpperCase();
                        tableBody = document.getElementById("planeTableBody");
                        break;
                    case 'Flight':
                        valueSearchInput = document.getElementById("searchFlight").value.trim().toUpperCase();
                        tableBody = document.getElementById("flightTableBody");
                        break;
                    case 'Room':
                        valueSearchInput = document.getElementById("searchRoom").value.trim().toUpperCase();
                        tableBody = document.getElementById("roomTableBody");
                        break;
                    case 'Seat':
                        valueSearchInput = document.getElementById("searchSeat").value.trim().toUpperCase();
                        tableBody = document.getElementById("seatTableBody");
                        break;
                }

                let rows = tableBody.querySelectorAll("tr");
                rows.forEach(row => {
                    let cellText = row.cells[1].textContent.toUpperCase();
                    row.style.display = cellText.includes(valueSearchInput) ? "" : "none";
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                const burger = document.querySelector('.burger');
                const navigation = document.querySelector('.navigation-admin');
                const main = document.querySelector('.main-details');

                burger.addEventListener('click', function () {
                    navigation.classList.toggle('active');
                    main.classList.toggle('active');
                });
            });
            function logout() {
                // Tạo một URL để gửi yêu cầu đăng xuất
                const url = "<%=response.encodeURL(request.getContextPath() + "/UserServlet?action=Log Out")%>";

                // Tạo một yêu cầu GET để đăng xuất
                window.location.href = url;
            }
        </script>
    </body>
</html>