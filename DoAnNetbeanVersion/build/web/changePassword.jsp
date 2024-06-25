<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.UserDB"%>
<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Change Password</title>

        <!-- Bootstrap JS and dependencies 
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/index.css" rel="stylesheet" />
        <link href="assets/css/sort.css" rel="stylesheet" />
        <link href="assets/css/responsive" rel="stylesheet"/> -->
    </head>
    <style>
        /* Nhúng CSS nếu cần thiết */
        /* Example styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 400px;
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: auto;
            margin-top: 50px;
        }
        
        h2 {
            color: #1b3661;
            border-bottom: 2px solid #1b3661;
            padding-bottom: 10px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
        }
        
        input[type="password"], button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        
        button {
            background-color: #1b3661;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        
        button:hover {
            background-color: #0c1f3d;
        }
        
        .error-message {
            color: red;
            font-size: 0.9rem;
        }
    </style>
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
