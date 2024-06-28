<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Dashboard</title>
        <link href="assets/css/admindb.css" rel="stylesheet"/> 
    </head>
    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li class="logo">
                        <div class="topbar-admin">
                            <a href="index.jsp">
                                <h3 class="logo-text">QTALD</h3>
                            </a>
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
