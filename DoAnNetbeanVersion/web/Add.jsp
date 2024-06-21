<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Hotel</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            h1 {
                color: #333;
                text-align: center;
            }

            .container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                padding: 20px;
                width: 100%;
                max-width: 400px;
                box-sizing: border-box;
            }

            .container h3 {
                color: #333;
                text-align: center;
            }

            .container form {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .container table {
                width: 100%;
                border-spacing: 0;
            }

            .container td {
                padding: 5px 0;
            }

            .container input[type="text"],
            .container input[type="submit"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                margin-bottom: 10px;
            }

            .container input[type="submit"] {
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .container input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .container p {
                color: #d9534f;
                text-align: center;
            }

            .container .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
            
            /* Styling for the return button */
        .return-button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .return-button:hover {
            background-color: #218838;
        }
        </style>
    </head>
    <body>
        <div class="container">
            <%
            // Retrieve the user name from session
            String userName = (String) session.getAttribute("role");

            // Check if user is admin
            boolean isAdmin = "admin".equals(userName);
            %>

            <% if (!isAdmin) { %>
            <p>You cannot access Add Hotel because you are not an admin!</p>
            <% } else { %>
            <h1>Add a new Hotel</h1>
            <h3 class="error-message">${requestScope.error}</h3>
            <form name="input" action="HotelServlet" method="post">
                <table>
                    <tr>
                        <td>Hotel ID</td>
                        <td><input type="text" name="id"></td>
                    </tr>
                    <tr>
                        <td>Hotel Name</td>
                        <td><input type="text" name="name"></td>
                    </tr>
                    <tr>
                        <td>Hotel Description</td>
                        <td><input type="text" name="des"></td>
                    </tr>
                    <tr>
                        <td>Hotel Address</td>
                        <td><input type="text" name="address"></td>
                    </tr>
                    <tr>
                        <td>City</td>
                        <td><input type="text" name="city"></td>
                    </tr>
                    <tr>
                        <td>Country</td>
                        <td><input type="text" name="country"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" name="action" value="Add"></td>
                    </tr>
                </table>
            </form>


            <% } %>
            <%-- Button to return to table_product.jsp --%>
            <form action="table_product.jsp">
                <button type="submit" class="return-button">Return to Product Table</button>
            </form>
        </div>
    </body>
</html>
