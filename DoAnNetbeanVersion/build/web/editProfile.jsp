<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="path/to/editProfile.css">
</head>
<body>
    <div class="container">
        <h1>Edit Profile Information</h1>
        <form action="<%=response.encodeURL("UserServlet") %>" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= userName %>" readonly>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="********" readonly>
                    <button type="button" onclick="togglePassword()">Show</button>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= users.getEmail() %>">
                </div>
                <div class="form-group">
                    <label for="fullname">Full Name:</label>
                    <input type="text" id="fullname" name="fullname" value="<%= users.getfName() %> <%= users.getlName() %>">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= users.getAddress() %>">
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number:</label>
                    <input type="text" id="phone" name="phone" value="<%= users.getPhone() %>">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="sex">Sex:</label>
                    <input type="text" id="sex" name="sex" value="<%= users.getSex() %>">
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" value="<%= users.getDob() %>">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="money">Money left:</label>
                    <input type="text" id="money" name="money" value="<%= users.getMoney() %> $">
                </div>
            </div>
            <button type="submit" class="submit-button">Save Changes</button>
        </form>
    </div>
</body>
</html>

