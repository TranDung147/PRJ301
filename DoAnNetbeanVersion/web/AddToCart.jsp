<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Room" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Booking Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #f2f2f2;
        }
        .success-msg {
            text-align: center;
            color: #28a745; /* Green color for success message */
            font-size: 18px;
            margin-bottom: 20px;
        }
        .error-msg {
            text-align: center;
            color: #dc3545; /* Red color for error message */
            font-size: 18px;
            margin-bottom: 20px;
        }
        .text-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Room Booking Status</h1>

   <div class="container">
    <% 
      Room bookedRoom = (Room) session.getAttribute("bookedRoom");
            if (bookedRoom != null) {
    %>
    <div class="success-msg">
        Room Booked Successfully!
    </div>
    <table>
        <tr>
            <th>Room ID</th>
            <th>Room Number</th>
            <th>Room Type</th>
            
        </tr>
        <tr>
            <td><%= bookedRoom.getRoomID() %></td>
            <td><%= bookedRoom.getRoomNumber() %></td>
            <td><%= bookedRoom.getRoomType() %></td>
           
        </tr>
    </table>
    <% } else { %>
    <div class="error-msg">
        Booking Failed. Please try again.
    </div>
    <% } //thieu session de chay lai roomDisplay%>
    <a class="text-link" href="roomDisplay.jsp">Continue viewing</a>
</div>
</body>
</html>
