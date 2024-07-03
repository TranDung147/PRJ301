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
        
        <form method="post" action="ChangePasswordServlet">
            <label for="currentPassword">Current Password:</label>
            <input type="password" id="currentPassword" name="currentPassword" required>
            
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <button type="submit">Change Password</button>
        </form>
        
        <!-- Optional: Display error message if passwords do not match -->
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
        
    </div>
</body>
</html>
