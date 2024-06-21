<%-- 
    Document   : admin
    Created on : Jun 15, 2024, 9:16:54 PM
    Author     : plmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <style>

            /* Nhớ thay đổi khi ghép code */
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

            /* ===================== Main ===================== */
            .main-admin {
                position: relative;
                width: calc(100% - 300px);
                left: 300px;
                min-height: 100vh;
                background: var(--white);
                transition: 0.5s;
                overflow: hidden;
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

            /* ======================= Cards ====================== */
            .cardBox-admin {
                position: relative;
                width: 100%;
                padding: 20px;
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                grid-gap: 30px;
            }

            .cardBox-admin .card {
                position: relative;
                background: var(--white);
                padding: 30px;
                border-radius: 20px;
                display: flex;
                justify-content: space-between;
                cursor: pointer;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            }

            .cardBox-admin .card .numbers {
                position: relative;
                font-weight: 500;
                font-size: 2.5rem;
                color: var(--blue);
            }

            .cardBox-admin .card .cardName {
                color: var(--black2);
                font-size: 1.1rem;
                margin-top: 5px;
            }

            .cardBox-admin .card .iconBx {
                font-size: 3.5rem;
                color: var(--black2);
            }

            .cardBox-admin .card:hover {
                background: var(--blue);
            }
            .cardBox-admin .card:hover .numbers,
            .cardBox-admin .card:hover .cardName,
            .cardBox-admin .card:hover .iconBx {
                color: var(--white);
            }

            /* ================== Charts JS ============== */
            .chartsBx {
                position: relative;
                width: 100%;
                padding: 20px;
                display: grid;
                grid-template-columns: 1fr;
                grid-gap: 30px;
            }

            .chartsBx .chart {
                position: relative;
                background: #fff;
                padding: 20px; /* Keep padding for the first chart */
                width: 100%;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
                border: 1px solid var(--blue);
                overflow: hidden; /* Ensure the chart stays within the bounds */
            }

            /* ================== Order Details List ============== */
            .details-admin {
                width: 100%;
                padding: 20px;
                display: grid;
                grid-template-columns: 2fr 1fr;
                grid-gap: 30px;
            }
            .details-admin .recentOrders-admin {
                position: relative;
                min-height: 500px;
                background: var(--white);
                padding: 20px;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
            }
            .details-admin .cardHeader-amdin {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }
            .cardHeader-amdin h2 {
                font-weight: 600;
                color: var(--blue);
            }

            .actions-admin a {
                text-decoration: none;
                color: var(--black1);
            }

            .actions-admin a:hover {
                color: gray;
            }
            .cardHeader-amdin .btn {
                position: relative;
                padding: 5px 10px;
                background: var(--blue);
                text-decoration: none;
                color: var(--white);
                border-radius: 6px;
            }
            .details-admin table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            .details-admin table thead td {
                font-weight: 600;
            }
            .details-admin .recentOrders-admin table tr {
                color: var(--black1);
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            }
            .details-admin .recentOrders-admin table tr:last-child {
                border-bottom: none;
            }
            .details-admin .recentOrders-admin table tbody tr:hover {
                background: var(--gray);
                color: var(--black);
            }
            .details-admin .recentOrders-admin table tr td {
                padding: 10px;
            }
            .details-admin .recentOrders-admin table tr td:last-child {
                text-align: end;
            }
            .details-admin .recentOrders-admin table tr td:nth-child(2) {
                text-align: center;
            }
            .details-admin .recentOrders-admin table tr td:nth-child(3) {
                text-align: center;
            }
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

            .recentCustomers-admin {
                position: relative;
                min-height: 500px;
                padding: 20px;
                background: var(--white);
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
            }
            .recentCustomers-admin .imgBx {
                position: relative;
                width: 40px;
                height: 40px;
                border-radius: 50px;
                overflow: hidden;
            }
            .recentCustomers-admin .imgBx img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .recentCustomers-admin table tr td {
                padding: 12px 10px;
            }
            .recentCustomers-admin table tr td h4 {
                font-size: 16px;
                font-weight: 500;
                line-height: 1.2rem;
            }
            .recentCustomers-admin table tr td h4 span {
                font-size: 14px;
                color: var(--black2);
            }
            .recentCustomers-admin table tr:hover {
                background: var(--gray);
                color: var(--black1);
            }
            .recentCustomers-admin table tr:hover td h4 span {
                color: var(--black2);
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
                .cardBox-admin {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 768px) {
                .details-admin {
                    grid-template-columns: 1fr;
                }
                .recentOrders-admin {
                    overflow-x: auto;
                }
                .status.inProgress {
                    white-space: nowrap;
                }
            }

            @media (max-width: 480px) {
                .cardBox-admin {
                    grid-template-columns: repeat(1, 1fr);
                }
                .cardHeader-admin h2 {
                    font-size: 20px;
                }
                .user-admin {
                    min-width: 40px;
                }
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
                .topbad-admin .Logo {
                    font-size: 20px;
                }
            }
            /* Adjusting the grid layout for larger screens */
            @media (min-width: 992px) {
                .chartsBx {
                    grid-template-columns: 0.5fr 1fr;
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
                        <div class="topbar-admin">
                            <h3 class="logo-text">QTALD</h3>
                        </div>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <img src="img/admin/dashboard.png" alt="Dashboard">
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <img src="img/admin/customer.png" alt="Customers">
                            </span>
                            <span class="title">Customers</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <img src="img/admin/order.png" alt="Orders">
                            </span>
                            <span class="title">Orders</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <img src="img/admin/logout.png" alt="Messages">
                            </span>
                            <span class="title">Log out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- ========================= Main ==================== -->
            <div class="main-admin">
                <div class="topbar-admin">
                    <div class="burger">
                        <div class="line1"></div>
                        <div class="line2"></div>
                        <div class="line3"></div>
                    </div>
                </div>
                <!-- ======================= Cards ================== -->
                <div class="cardBox-admin">
                    <div class="card">
                        <div>
                            <div class="numbers">1,504</div>
                            <div class="cardName">Daily Views</div>
                        </div>
                    </div>

                    <div class="card">
                        <div>
                            <div class="numbers">80</div>
                            <div class="cardName">Orders</div>
                        </div>
                    </div>

                    <div class="card">
                        <div>
                            <div class="numbers">284</div>
                            <div class="cardName">Comments</div>
                        </div>
                    </div>

                    <div class="card">
                        <div>
                            <div class="numbers">$7,842</div>
                            <div class="cardName">Earning</div>
                        </div>
                    </div>
                </div>

                <!-- ================ Add Charts JS ================= -->
                <div class="chartsBx">
                    <div class="chart"><canvas id="chart-1"></canvas></div>
                    <div class="chart"><canvas id="chart-2"></canvas></div>
                </div>

                <!-- ================ Order Details List ================= -->
                <div class="details-admin">
                    <div class="recentOrders-admin">
                        <div class="cardHeader-amdin">
                            <h2>Recent Orders</h2>
                            <a href="#" class="btn">View All</a>
                        </div>

                        <table>
                            <thead>
                                <tr>
                                    <td>Name</td>
                                    <td>Price</td>
                                    <td>Actions</td>
                                    <td>Status</td>
                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <td>Phòng Tổng Thống</td>
                                    <td>$1000</td>
                                    <td class="actions-admin">
                                        <a href="#">Edit</a>
                                        <a href="#">Delete</a>
                                    </td>
                                    <td><span class="status done">Done</span></td>
                                </tr>
                                <tr>
                                    <td>Phòng VIP</td>
                                    <td>$500</td>
                                    <td class="actions-admin">
                                        <a href="#">Edit</a>
                                        <a href="#">Delete</a>
                                    </td>
                                    <td><span class="status processing">Processing</span></td>
                                </tr>
                                <tr>
                                    <td>Phòng Đôi Thường</td>
                                    <td>$1200</td>
                                    <td class="actions-admin">
                                        <a href="#">Edit</a>
                                        <a href="#">Delete</a>
                                    </td>
                                    <td><span class="status canceled">Canceled</span></td>
                                </tr>
                                <tr>
                                    <td>Phòng Đơn</td>
                                    <td>$1200</td>
                                    <td class="actions-admin">
                                        <a href="#">Edit</a>
                                        <a href="#">Delete</a>
                                    </td>
                                    <td><span class="status done">Done</span></td>
                                </tr>
                                <tr>
                                    <td>Phòng Tổng Thống</td>
                                    <td>$110</td>
                                    <td class="actions-admin">
                                        <a href="#">Edit</a>
                                        <a href="#">Delete</a>
                                    </td>
                                    <td><span class="status processing">Processing</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- ================= New Customers ================ -->
                    <div class="recentCustomers-admin">
                        <div class="cardHeader-admin">
                            <h2>Recent Customers</h2>
                        </div>

                        <table>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="assets/imgs/customer02.jpg" alt="" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Huynh Dinh Thien <br />
                                        <span>Phòng Tổng Thống</span>
                                    </h4>
                                </td>
                            </tr>

                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="assets/imgs/customer01.jpg" alt="" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Bui Le Viet Anh <br />
                                        <span>Phòng Thường Đôi</span>
                                    </h4>
                                </td>
                            </tr>

                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="assets/imgs/customer02.jpg" alt="" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Dinh Nguyen Khanh Luan <br />
                                        <span>Phòng Thường Đôi</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="assets/imgs/customer02.jpg" alt="" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Pham Le Minh Quan <br />
                                        <span>Phòng VIP1</span>
                                    </h4>
                                </td>
                            </tr>

                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="assets/imgs/customer01.jpg" alt="" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Tran Trung Dung <br />
                                        <span>Phòng VIP2</span>
                                    </h4>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
        <script src="assets/js/chartsJS.js"></script>

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
