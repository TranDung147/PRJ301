<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.User"%>
<%@ page import="Model.UserDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Update Information</title>
        <link href="assets/css/changeinfouser.css" rel="stylesheet" />
    </head>
    <body>
        <div class="container">
            <div class="main-admin">
                <div class="information">
                    <h1>Update Your Information</h1>

                    <jsp:useBean id="userDB" class="Model.UserDB" scope="session" />
                    <% 
                        // Gọi phương thức getUserFromSession từ UserDB
                        User user = userDB.getUserFromSession(session, request);
                        
                        if (user == null) {
                            response.sendRedirect("index.jsp");
                        } else {
                            request.setAttribute("user", user);
                        }
                    %>
                    <form action="UserServlet" method="post">
                        <input type="hidden" name="userID" value="${user.userID}" />
                        <div class="row">
                            <div class="profile-info">
                                <label>Username:</label>
                                <input type="text" name="username" value="${user.username}" />
                            </div>
                            <div class="profile-info">
                                <label>Password:</label>
                                <input type="text" name="password" value="${user.password}" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="profile-info">
                                <label>First Name:</label>
                                <input type="text" name="fName" value="${user.fName}" />
                            </div>
                            <div class="profile-info">
                                <label>Last Name:</label>
                                <input type="text" name="lName" value="${user.lName}" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="profile-info">
                                <label>Sex:</label>
                                <input type="text" name="sex" value="${user.sex}" />
                            </div>
                            <div class="profile-info">
                                <label>Date of Birth:</label>
                                <input type="date" name="dob" value="${user.dob}" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="profile-info">
                                <label>Email:</label>
                                <input type="email" name="email" value="${user.email}" />
                            </div>
                            <div class="profile-info">
                                <label>Address:</label>
                                <input type="text" name="address" value="${user.address}" />
                            </div>
                        </div>
                        <div class="profile-info">
                            <label>Phone Number:</label>
                            <input type="text" name="phone" value="${user.phone}" />
                        </div>
                        <div class="change-info-button">
                            <button type="submit" name="action" value="update">Update Information</button>
                        </div>
                    </form>
                    <%-- Kiểm tra và hiển thị thông báo lỗi nếu có --%>
                    <% String error = request.getParameter("error");
                       if (error != null && error.equals("UpdateFailed")) { %>
                    <div class="error-message">
                        Update failed. Please try again.
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>

