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
                            <h1>Dash Board</h1>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
        <% }%>


        <script>
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