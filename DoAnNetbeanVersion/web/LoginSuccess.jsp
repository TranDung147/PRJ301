<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.*, Controller.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Success Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 20px;
            }

            h2 {
                color: #333;
                text-align: center;
            }

            table {
                width: 50%;
                margin: 20px auto;
                border-collapse: collapse;
                border: 1px solid #ccc;
                background-color: #fff;
            }

            table th, table td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ccc;
            }

            table th {
                background-color: #f2f2f2;
                font-weight: bold;
            }

            form {
                text-align: center;
                margin-top: 20px;
            }

            input[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50;
                border: none;
                color: #fff;
                cursor: pointer;
                font-size: 16px;
                border-radius: 4px;
                margin-right: 10px; /* Adjust margin to separate buttons */
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            a.checkout {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
            }

            a.checkout:hover {
                background-color: #0056b3;
            }

            /* Style for the logout button */
            input[type="submit"].logout {
                background-color: #dc3545; /* Red color for logout */
            }

            input[type="submit"].logout:hover {
                background-color: #c82333; /* Darker red on hover */
            }

            /* Center the checkout link */
            .centered {
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <%--session--%>
        <%
        //allow access only if session exists
        String user = null;
        if(session.getAttribute("user") == null){
                response.sendRedirect("index.jsp");
        }else user = (String) session.getAttribute("user");
        String userName = null;
        String sessionID = null;
        Cookie[] cookies = request.getCookies();
        if(cookies !=null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("user")) userName = cookie.getValue();
                if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
            }
        }else{
                sessionID = session.getId();
        }
        if (session != null) {
        String sessionUser = (String) session.getAttribute("user");
            if (sessionUser != null) {
                userName = sessionUser;
            }
        }      

        %>

        <h2>Hello <%=userName %>, Login successful. </h2>
        <table>
            <tr>
                <th>Session ID</th>
                <th>Username</th>
            </tr>
            <tr>
                <td><%=sessionID%></td>
                <td><%=userName %></td>
            </tr>
        </table>
        <br>
        <form action="table_product.jsp">
            <input type="submit" value="List Hotel" name="list">
        </form>
        <form action="UserDashboard">
            <input type="submit" value="Dashboard">
        </form>
        <!-- Centered checkout link -->
        <div class="centered">
            <a class="checkout" href="<%=response.encodeURL("CheckoutPage.jsp") %>">Checkout Page</a>
        </div>
        <form action="<%=response.encodeURL("UserServlet") %>" method="get">
            <input type="submit" name="action" value="Log Out" class="logout">
        </form>
    </body>
</html>
