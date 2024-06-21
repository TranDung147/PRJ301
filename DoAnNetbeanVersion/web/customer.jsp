<%-- Document : admin Created on : Jun 15, 2024, 9:16:54 PM Author : plmin --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Dashboard</title>
        <style>
            /* Nhớ thay đổi khi ghép code */
            /* =============== Globals ============== */
            * {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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
            .navigation-admin {
                position: fixed;
                width: 300px;
                height: 100%;
                background: var(--blue);
                border-left: 10px solid var(--blue);
                transition: 0.5s;
                overflow: hidden;
            }
            .navigation-admin.active {
                width: 80px;
            }

            .navigation-admin ul {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                padding-top: 70px;
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
                height: 60px;
                line-height: 75px;
                text-align: center;
            }
            .navigation-admin ul li a .ion-icon .icon {
                font-size: 1.75rem;
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
                position: absolute;
                width: calc(100% - 300px);
                left: 300px;
                min-height: 100vh;
                background: var(--white);
                transition: 0.5s;
            }
            .main-admin.active {
                width: calc(100% - 80px);
                left: 80px;
            }

            .topbar-admin {
                width: 100%;
                height: 60px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                text-align: right;
                padding: 0 20px;
            }

            .burger div {
                width: 30px;
                height: 4px;
                background-color: #000;
                margin: 5px;
                border-radius: 20%;
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
                grid-template-columns: 1fr 2fr;
                grid-gap: 30px;
            }

            .chartsBx .chart {
                position: relative;
                background: #fff;
                padding: 20px;
                width: 100%;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
                border: 1px solid var(--blue);
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
                color: var (--blue);
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
                font-size: 12px;
                font-weight: 500;
            }
            .status.pending {
                padding: 2px 4px;
                background: #f9ca3f;
                color: var(--white);
                border-radius: 4px;
                font-size: 12px;
                font-weight: 500;
            }
            .status.process {
                padding: 2px 4px;
                background: #1795ce;
                color: var(--white);
                border-radius: 4px;
                font-size: 12px;
                font-weight: 500;
            }
            .status.cancel {
                padding: 2px 4px;
                background: #f00;
                color: var(--white);
                border-radius: 4px;
                font-size: 12px;
                font-weight: 500;
            }

            .details-admin .recentCustomers-admin {
                position: relative;
                min-height: 500px;
                background: var(--white);
                padding: 20px;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
            }

            .details-admin .recentCustomers-admin .imgBx {
                position: relative;
                width: 40px;
                height: 40px;
                overflow: hidden;
                border-radius: 50%;
            }

            .details-admin .recentCustomers-admin img {
                position: absolute;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .details-admin .recentCustomers-admin table tr td {
                padding: 12px;
            }

            .details-admin .recentCustomers-admin table tr:hover {
                background: var(--gray);
                color: var(--black1);
            }

            .details-admin .recentCustomers-admin table tr td h4 {
                font-size: 16px;
                font-weight: 500;
                line-height: 1.2rem;
            }
            .details-admin .recentCustomers-admin table tr td h4 span {
                font-size: 14px;
                color: var(--black2);
            }

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
                    width: calc(100% - 300px);
                    left: 300px;
                }
                .cardBox-admin {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 768px) {
                .cardBox-admin {
                    grid-template-columns: repeat(1, 1fr);
                }

                .chartsBx {
                    grid-template-columns: repeat(1, 1fr);
                }

                .details-admin {
                    grid-template-columns: repeat(1, 1fr);
                }
            }

            @media (max-width: 480px) {
                .navigation-admin ul li a {
                    font-size: 0.75rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="cube-outline"></ion-icon>
                            </span>
                            <span class="title">Brand Name</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="home-outline"></ion-icon>
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a class="active" href="#">
                            <span class="icon">
                                <ion-icon name="people-outline"></ion-icon>
                            </span>
                            <span class="title">Customers</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="chatbubble-outline"></ion-icon>
                            </span>
                            <span class="title">Messages</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="help-outline"></ion-icon>
                            </span>
                            <span class="title">Help</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="settings-outline"></ion-icon>
                            </span>
                            <span class="title">Settings</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="lock-closed-outline"></ion-icon>
                            </span>
                            <span class="title">Password</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="log-out-outline"></ion-icon>
                            </span>
                            <span class="title">Sign Out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="main-admin">
                <div class="topbar-admin">
                    <div class="burger">
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                    <div class="user">
                        <img src="https://via.placeholder.com/40" />
                    </div>
                </div>

                <!-- ======================= Cards ======================= -->
                <div class="cardBox-admin">
                    <div class="card">
                        <div>
                            <div class="numbers">1,504</div>
                            <div class="cardName">Daily Views</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="eye-outline"></ion-icon>
                        </div>
                    </div>

                    <div class="card">
                        <div>
                            <div class="numbers">80</div>
                            <div class="cardName">Sales</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="cart-outline"></ion-icon>
                        </div>
                    </div>

                    <div class="card">
                        <div>
                            <div class="numbers">284</div>
                            <div class="cardName">Comments</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="chatbubbles-outline"></ion-icon>
                        </div>
                    </div>

                    <div class="card">
                        <div>
                            <div class="numbers">$7,842</div>
                            <div class="cardName">Earning</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="cash-outline"></ion-icon>
                        </div>
                    </div>
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
                                    <td>Payment</td>
                                    <td>Status</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Star Refrigerator</td>
                                    <td>$1200</td>
                                    <td>Paid</td>
                                    <td><span class="status done">Delivered</span></td>
                                </tr>
                                <tr>
                                    <td>Dell Laptop</td>
                                    <td>$110</td>
                                    <td>Due</td>
                                    <td><span class="status pending">Pending</span></td>
                                </tr>
                                <tr>
                                    <td>Apple Watch</td>
                                    <td>$1200</td>
                                    <td>Paid</td>
                                    <td><span class="status process">Processing</span></td>
                                </tr>
                                <tr>
                                    <td>Addidas Shoes</td>
                                    <td>$620</td>
                                    <td>Paid</td>
                                    <td><span class="status done">Delivered</span></td>
                                </tr>
                                <tr>
                                    <td>Star Refrigerator</td>
                                    <td>$1200</td>
                                    <td>Paid</td>
                                    <td><span class="status done">Delivered</span></td>
                                </tr>
                                <tr>
                                    <td>Dell Laptop</td>
                                    <td>$110</td>
                                    <td>Due</td>
                                    <td><span class="status pending">Pending</span></td>
                                </tr>
                                <tr>
                                    <td>Apple Watch</td>
                                    <td>$1200</td>
                                    <td>Paid</td>
                                    <td><span class="status process">Processing</span></td>
                                </tr>
                                <tr>
                                    <td>Addidas Shoes</td>
                                    <td>$620</td>
                                    <td>Paid</td>
                                    <td><span class="status done">Delivered</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- =========== New Customers List =============== -->
                    <div class="recentCustomers-admin">
                        <div class="cardHeader-admin">
                            <h2>Recent Customers</h2>
                        </div>
                        <table>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        David
                                        <br /><span>Italy</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Amit
                                        <br /><span>India</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Karim
                                        <br /><span>Morocco</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        David
                                        <br /><span>Italy</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Amit
                                        <br /><span>India</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Karim
                                        <br /><span>Morocco</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        David
                                        <br /><span>Italy</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Amit
                                        <br /><span>India</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx">
                                        <img src="https://via.placeholder.com/40" />
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        Karim
                                        <br /><span>Morocco</span>
                                    </h4>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="module" src="https://cdn.jsdelivr.net/npm/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://cdn.jsdelivr.net/npm/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</html>
