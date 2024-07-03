<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.User"%>
<%@page import="Model.UserDB"%>
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
                            <h1>Account Information</h1>
                            <div class="profile-info">
                                <label>Username:</label>
                                <p><span><%= userName %></span></p>
                            </div>
                            <div class="profile-info">
                                <label>Password:</label>
                                <p>
                                    <span id="passwordDisplay">********</span>
                                    <button onclick="togglePassword()">Show</button>
                                    <button id="changePasswordLink" onclick="changePassword()">Change Password</button>
                                </p>
                            </div>
                            <div class="profile-info">
                                <label>Email:</label>
                                <p><span><%= users.getEmail() %></span></p>
                            </div>
                            <div class="profile-info">
                                <label>FullName:</label>
                                <p><span><%= users.getfName() %> <%= users.getlName() %> </span></p>
                            </div>
                            <div class="profile-info">
                                <label>Address:</label>
                                <p><span><%= users.getAddress() %></span></p>
                            </div>
                            <div class="profile-info">
                                <label>Phone Number:</label>
                                <p><span><%= users.getPhone() %></span></p>
                            </div>
                            <div class="profile-info">
                                <label>Sex:</label>
                                <p><span><%= users.getSex() %></span></p>
                            </div>
                            <div class="profile-info">
                                <label>Date of Birth:</label>
                                <p><span><%= users.getDob() %></span></p>
                            </div>
                            <div class="profile-info">
                                <label>Money left:</label>
                                <p><span><%= users.getMoney() %> $</span></p>
                            </div>
                        </div>
                        <div class="change-info-button">
                            <form action="<%=response.encodeURL("UserServlet") %>" method="get">
                                <input type="hidden" name="action" value="editProfile">
                                <button type="submit">Change Information</button>
                            </form>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <% }%>


        <script>
            function togglePassword() {
                var passwordField = document.getElementById('passwordDisplay');
                var button = event.target;
                var changePasswordLink = document.getElementById('changePasswordLink');

                if (passwordField.innerHTML === "********") {
                    passwordField.innerHTML = "<%= pass %>";
                    button.textContent = "Hide";
                    changePasswordLink.style.display = 'inline'; // Hiển thị link
                } else {
                    passwordField.innerHTML = "********";
                    button.textContent = "Show";
                    changePasswordLink.style.display = 'none'; // Ẩn link
                }
            }

            // Hàm chuyển hướng đến trang thay đổi mật khẩu
            document.getElementById('changePasswordLink').onclick = function () {
                window.location.href = 'changePassword.jsp'; // Thay thế đường dẫn này bằng đường dẫn tới trang thay đổi mật khẩu của bạn
            };

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