<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Dashboard</title>
        <link href="assets/css/admindb.css" rel="stylesheet"/>
        <style>
            .navigation-admin ul li.logo:hover a::before,
            .navigation-admin ul li.logo.hovered a::before,
            .navigation-admin ul li.logo:hover a::after,
            .navigation-admin ul li.logo.hovered a::after {
                content: none; /* Remove the curve motion effect for the QTALD logo */
            }
            .charts-container {
                display: flex;
                flex-direction: column; /* Đặt nút chọn năm nằm trên cùng */
                align-items: center; /* Căn giữa nội dung */
                margin-bottom: 20px;
                padding-top: 10px;
            }

            #yearSelect {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
                font-size: 14px;
                color: #333;
                cursor: pointer;
                transition: border-color 0.3s;
                width: 100px;
                height: 50px;
                margin-bottom: 20px; /* Khoảng cách dưới để phân tách với các biểu đồ */
            }

            .chartsBx {
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }

            #myPieChart, #plots {
                max-width: 49%;
                max-height: 400px;
                margin-bottom: 0;
            }




            #yearSelect:hover {
                border-color: #007BFF;
            }

            #yearSelect:focus {
                outline: none;
                border-color: #007BFF;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }
        </style>

    </head>
    <body>
        <!-- =============== Navigation ================ -->
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
                            <div class="numbers" id="totalOrders">${totalOrders!= null ? totalOrders : 0}</div>
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
                            <div class="numbers" id="totalPricesDisplay">
                                ${totalPrices != null ? totalPrices : 0.0}
                            </div>
                            <div class="cardName">Earning</div>
                        </div>
                    </div>

                </div>

                <!-- ================ Add Charts JS ================= -->
                <div class="charts-container">
                    <select id="yearSelect">
                        <option value="2023">2023</option>
                        <option value="2024">2024</option>
                    </select>

                    <div class="chartsBx">
                        <canvas id="myPieChart" width="400px" height="400px"></canvas>
                        <canvas id="plots" width="400px" height="400px"></canvas>
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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



        <script>
                                  document.addEventListener('DOMContentLoaded', function () {
                                      const ctxPie = document.getElementById("myPieChart").getContext('2d');
                                      const ctxBar = document.getElementById("plots").getContext('2d');
                                      const yearSelect = document.getElementById("yearSelect");

                                      let chartPie = null;
                                      let chartBar = null;

                                      function fetchData() {
                                          const selectedYear = yearSelect.value;
                                          const url = `GetDataServlet`;

                                          fetch(url, {
                                              method: 'POST',
                                              headers: {
                                                  'Content-Type': 'application/json'
                                              },
                                              body: JSON.stringify({year: selectedYear})
                                          })
                                                  .then(response => response.json())
                                                  .then(data => {
                                                      console.log('Dữ liệu JSON nhận được:', data);
                                                      const totalPrices = data.totalPrices || 0.0;
                                                      const totalOrders = data.totalOrders || 0;
                                                      document.getElementById('totalOrders').textContent = totalOrders;
                                                      document.getElementById('totalPricesDisplay').textContent = totalPrices;
                                                      const roomBookingCounts = data.roomBookingCounts || {};
                                                      const ticketBookingCounts = data.ticketBookingCounts || {};
                                                      const roomPrices = data.roomPrices || {};
                                                      const ticketPrices = data.ticketPrices || {};
                                                      const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];




                                                      // Cập nhật biểu đồ pie
                                                      if (chartPie) {
                                                          chartPie.destroy();
                                                      }

                                                      chartPie = new Chart(ctxPie, {
                                                          type: 'pie',
                                                          data: {
                                                              labels: ['Room VIP', 'Room Standard', 'Seat VIP', 'Seat Standard'],
                                                              datasets: [{
                                                                      data: [
                                                                          roomBookingCounts['VIP'] || 0,
                                                                          roomBookingCounts['Standard'] || 0,
                                                                          ticketBookingCounts['VIP'] || 0,
                                                                          ticketBookingCounts['Standard'] || 0
                                                                      ],
                                                                      backgroundColor: ['#ff6384', '#ff9f40', '#36a2eb', '#4bc0c0'],
                                                                      borderColor: '#fff',
                                                                      borderWidth: 1
                                                                  }]
                                                          },
                                                          options: {
                                                              responsive: true,
                                                              maintainAspectRatio: false,
                                                              layout: {
                                                                  padding: {
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 10,
                                                                      bottom: 10
                                                                  }
                                                              },
                                                              plugins: {
                                                                  legend: {
                                                                      position: 'top'
                                                                  },
                                                                  tooltip: {
                                                                      callbacks: {
                                                                          label: function (tooltipItem) {
                                                                              return tooltipItem.label + ': ' + tooltipItem.raw;
                                                                          }
                                                                      }
                                                                  }
                                                              }
                                                          }
                                                      });

                                                      // Cập nhật biểu đồ bar
                                                      if (chartBar) {
                                                          chartBar.destroy();
                                                      }

                                                      chartBar = new Chart(ctxBar, {
                                                          type: 'bar',
                                                          data: {
                                                              labels: months,
                                                              datasets: [
                                                                  {
                                                                      label: 'Room VIP Earning',
                                                                      data: roomPrices[0] || [],
                                                                      backgroundColor: '#ff6384',
                                                                      borderColor: '#fff',
                                                                      borderWidth: 1
                                                                  },
                                                                  {
                                                                      label: 'Room Standard Earning',
                                                                      data: roomPrices[1] || [],
                                                                      backgroundColor: '#ff9f40',
                                                                      borderColor: '#fff',
                                                                      borderWidth: 1
                                                                  },
                                                                  {
                                                                      label: 'Seat VIP Earning',
                                                                      data: ticketPrices[0] || [],
                                                                      backgroundColor: '#36a2eb',
                                                                      borderColor: '#fff',
                                                                      borderWidth: 1
                                                                  },
                                                                  {
                                                                      label: 'Seat Standard Earning',
                                                                      data: ticketPrices[1] || [],
                                                                      backgroundColor: '#4bc0c0',
                                                                      borderColor: '#fff',
                                                                      borderWidth: 1
                                                                  }
                                                              ]
                                                          },
                                                          options: {
                                                              responsive: true,
                                                              maintainAspectRatio: false,
                                                              indexAxis: 'x',
                                                              scales: {
                                                                  x: {
                                                                      stacked: true,
                                                                      beginAtZero: true
                                                                  },
                                                                  y: {
                                                                      stacked: true,
                                                                      beginAtZero: true
                                                                  }
                                                              },
                                                              layout: {
                                                                  padding: {
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 10,
                                                                      bottom: 10
                                                                  }
                                                              },
                                                              plugins: {
                                                                  legend: {
                                                                      position: 'top'
                                                                  },
                                                                  tooltip: {
                                                                      callbacks: {
                                                                          label: function (tooltipItem) {
                                                                              return tooltipItem.label + ': ' + tooltipItem.raw;
                                                                          }
                                                                      }
                                                                  }
                                                              }
                                                          }
                                                      });
                                                  })
                                                  .catch(error => console.error('Error fetching data:', error));
                                      }

                                      yearSelect.addEventListener('change', fetchData);
                                      fetchData();

                                      const burger = document.querySelector('.burger');
                                      const navigation = document.querySelector('.navigation-admin');
                                      const main = document.querySelector('.main-admin');

                                      burger.addEventListener('click', function () {
                                          navigation.classList.toggle('active');
                                          main.classList.toggle('active');
                                      });

                                      function logout() {
                                          const url = "<%=response.encodeURL(request.getContextPath() + "/UserServlet?action=Log Out")%>";
                                          window.location.href = url;
                                      }
                                  });


        </script>
    </body>
</html>