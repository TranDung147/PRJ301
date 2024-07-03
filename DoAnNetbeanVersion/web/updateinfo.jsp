<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.UserDB"%>
<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Change Password</title>
        <link href="assets/css/changepass.css" rel="stylesheet"/> 
    </head>

</head>
<body>
    <div class="container">
        <h2>Change Password</h2>
        
        <form method="post" action="UserServlet">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Password:</label>
            <input type="text" id="password" name="password" required>
            
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" required>
            
            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" required>
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            
            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" required>
            
            <label for="sex">Sex:</label>
            <input type="text" id="sex" name="sex" required>
            
            <label for="dob">Date of Birth:</label>
            <input type="text" id="dob" name="dob" required>
            
            <button type="submit" name="action" value="change">Change Information</button>
        </form>
        
        <!-- Optional: Display error message if passwords do not match -->
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
        
    </div>
</body>
</html>
