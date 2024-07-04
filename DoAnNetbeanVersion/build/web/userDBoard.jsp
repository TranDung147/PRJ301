<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.User"%>
<%@ page import="Model.UserDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                        <a href="booking">
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
                    <jsp:useBean id="userDB" class="Model.UserDB" scope="request" />
                    <% 
                        // Gọi phương thức getUserFromSession từ UserDB
                        User user = userDB.getUserFromSession(session, request);
                    
                        if (user == null) {
                            response.sendRedirect("index.jsp");
                        } else {
                            request.setAttribute("user", user);
                        }
                    %>

                    <c:choose>
                        <c:when test="${user == null}">
                            <c:redirect url="index.jsp" />
                        </c:when>
                        <c:otherwise>
                            <div class="profile-card">
                                <div class="topbar-admin">
                                    <div class="burger">
                                        <div class="line1"></div>
                                        <div class="line2"></div>
                                        <div class="line3"></div>
                                    </div>
                                </div>
                                <div>
                                    <h1>User Dashboard</h1>

                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
                    
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