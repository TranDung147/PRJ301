<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.User"%>
<%@ page import="DAO.UserDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Profile Details</title>
        <link href="assets/css/userdb.css" rel="stylesheet" />
        <link href="assets/css/customer.css" rel="stylesheet" />
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
                        <a href="customer.jsp">
                            <span class="icon">
                                <img src="img/admin/customer.png" alt="Information">
                            </span>
                            <span class="title">Information</span>
                        </a>
                    </li>
                    <li>
                        <a href="UserServlet?action=booking">
                            <span class="icon">
                                <img src="img/admin/order.png" alt="Booking Cart">
                            </span>
                            <span class="title">Cart</span>
                        </a>
                    </li>
                    <li>
                        <a href="thanhtoan">
                            <span class="icon">
                                <img src="img/admin/order.png" alt="Order Cart">
                            </span>
                            <span class="title">Your Order</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- ========================= Main ==================== -->
            <div class="main-admin">
                <div class="information">
                    <jsp:useBean id="userDB" class="DAO.UserDB" scope="session" />
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
                                    <h1>Account Information</h1>
                                    <div class="profile-info">
                                        <label>Username:</label>
                                        <p><span>${user.username}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Password:</label>
                                        <p>
                                            <span id="passwordDisplay">********</span>
                                            <button onclick="togglePassword()">Show</button>
                                        </p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Email:</label>
                                        <p><span>${user.email}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>FullName:</label>
                                        <p><span>${user.fName} ${user.lName}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Address:</label>
                                        <p><span>${user.address}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Phone Number:</label>
                                        <p><span>${user.phone}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Sex:</label>
                                        <p><span>${user.sex}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Date of Birth:</label>
                                        <p><span>${user.dob}</span></p>
                                    </div>
                                    <div class="profile-info">
                                        <label>Money left:</label>
                                        <p><span>${user.money} $</span></p>
                                    </div>
                                </div>
                                <div class="change-info-button">
                                    <form action="updateinfo.jsp">
                                        <button type="submit">Change Information</button>
                                    </form>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script>
            function togglePassword() {
                var passwordField = document.getElementById('passwordDisplay');
                var button = event.target;

                if (passwordField.innerHTML === "********") {
                    passwordField.innerHTML = "${user.password}";
                    button.textContent = "Hide";
                } else {
                    passwordField.innerHTML = "********";
                    button.textContent = "Show";
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                const burger = document.querySelector('.burger');
                const navigation = document.querySelector('.navigation-admin');
                const main = document.querySelector('.main-admin' );
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
