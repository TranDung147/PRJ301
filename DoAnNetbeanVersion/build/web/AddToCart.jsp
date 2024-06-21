<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
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
        .total-row {
            font-weight: bold;
        }
        .empty-cart-msg {
            text-align: center;
            color: #666;
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
    <h1>Order Cart</h1>
    <table>
        <tr>
            <th>ID</th>
                <th>Hotel Name</th>
                <th>Hotel Description</th>
                <th>Hotel Address</th>
                <th>City</th>
                <th>Country</th>
        </tr>
        <%
            ArrayList<Hotel> cart = (ArrayList<Hotel>) session.getAttribute("cart");
            if (cart != null && !cart.isEmpty()) {
                double totalAmount = 0;
                for (Hotel ht : cart) {
                    double total = 1;
                    //double total = t.getPrice() * t.getQuantity();
                    totalAmount += total;
        %>
        <tr>
            <td><%= ht.getHotelId() %></td>
            <td><%= ht.getHotelName() %></td>
            <td>$ <%= ht.getHotelDescription() %></td>
            <td><%= ht.getHotelAddress() %></td>
            <td><%= ht.getCity() %></td>
            <td><%= ht.getCountry() %></td>
            <td>$ <%= String.format("%.2f", total) %></td>
        </tr>
        <% 
                }
        %>
        <tr class="total-row">
            <td colspan="4" style="text-align: right;">Total Amount:</td>
            <td>$ <%= String.format("%.2f", totalAmount) %></td>
        </tr>
        <% 
            } else {
        %>
        <tr>
            <td colspan="5" class="empty-cart-msg">Your cart is empty.</td>
        </tr>
        <% 
            }
        %>
    </table>
    <a class="text-link" href="table_product.jsp">Continue viewing</a>
</body>
</html>
