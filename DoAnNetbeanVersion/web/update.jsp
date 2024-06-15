<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Hotel" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Product</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                display: flex;
                justify-content: center; /* Center align content horizontally */
                align-items: center; /* Center align content vertically */
                height: 100vh; /* Full viewport height */
                margin: 0; /* Remove default margin */
            }
            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                max-width: 600px; /* Limit maximum width of content */
                width: 100%;
                text-align: center; /* Center align content inside container */
            }
            h1 {
                color: #333;
                margin-top: 20px; /* Space between heading and top of container */
            }
            .form-container {
                margin-top: 20px; /* Space between form and heading */
            }
            input[type="text"], input[type="submit"] {
                width: calc(100% - 20px);
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 3px;
                font-size: 16px;
                box-sizing: border-box;
            }
            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #45a049;
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
            <p>You cannot access Update Hotel because you are not an admin!</p>
            <% } else { %>
            <h1>Update Hotel - ID: <%= request.getParameter("hotelId").trim() %></h1>
            <h3 class="error-message">${requestScope.error}</h3>
            <div class="form-container">
                <%
                    // Retrieve parameters from request
                    String HotelId = request.getParameter("hotelId").trim();
                    String HotelName = request.getParameter("hotelName").trim(); // Trim to remove extra spaces
                    String HotelDescription = request.getParameter("hotelDescription").trim();
                    String HotelAddress = request.getParameter("hotelAddress").trim();
                    String City = request.getParameter("city").trim();
                    String Country = request.getParameter("country").trim();

                   // Create a Hotel object with retrieved data
                   // Hotel hotel = new Hotel(hotelId, hotelName, hotelDescription, hotelAddress, city, country);
                    Hotel hotel = new Hotel(HotelId, HotelName, HotelDescription, HotelAddress, City, Country);
                %>

                <form action="HotelServlet" method="post">
                    <input type="hidden" name="hotelId" value="<%= hotel.getHotelId() %>">
                    Hotel Name: <input type="text" name="hotelName" value="<%= hotel.getHotelName() %>"><br>
                    Hotel Description: <input type="text" name="hotelDescription" value="<%= hotel.getHotelDescription() %>"><br>
                    Hotel Address: <input type="text" name="hotelAddress" value="<%= hotel.getHotelAddress() %>"><br>
                    City: <input type="text" name="city" value="<%= hotel.getCity() %>"><br>
                    Country: <input type="text" name="country" value="<%= hotel.getCountry() %>"><br>
                    <input type="submit" name="action" value="Update">
                </form>


                <% } %>
                <%-- Button to return to table_product.jsp --%>
                <form action="table_product.jsp">
                    <button type="submit" class="return-button">Return to Product Table</button>
                </form>
            </div>
        </div>
    </body>
</html>
