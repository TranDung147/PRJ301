

<%@page contentType="text/html" import="Model.*,java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="hotel" class="Model.Hotel" scope="request"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                text-align: center; /* Center-align all text */
            }
            h1 {
                background-color: #333;
                color: #fff;
                padding: 10px;
                text-align: center; /* Center-align h1 text */
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                text-align: center; /* Center-align table content */
            }
            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: center; /* Center-align table headers and data */
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #e0e0e0;
            }
            form {
                margin: 0;
                text-align: center; /* Center-align form content */
            }
            .fixleng {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .text {
                display: inline-block;
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                text-align: center; /* Center-align button text */
                text-decoration: none;
                margin: 10px 0;
                cursor: pointer;
                border-radius: 5px;
            }
            .text:hover {
                background-color: #45a049;
            }
            .logout {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center; /* Center-align button text */
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 10px 0;
                cursor: pointer;
                border-radius: 5px;
            }
            .logout:hover {
                background-color: #da190b;
            }
            .delete-link {
                color: #f44336;
                cursor: pointer;
                text-decoration: none;
            }
            .delete-link:hover {
                text-decoration: underline;
            }

        </style>
    </head>
    <body>
        <h1>Hello: <%= session.getAttribute("user") %></h1>
        <h1>List of Hotels</h1>
        <table border="1px" width="40%">
            <tr>
                <th>ID</th>
                <th>Hotel Name</th>
                <th>Hotel Description</th>
                <th>Hotel Address</th>
                <th>City</th>
                <th>Country</th>
                
                    <% if ("admin".equals(session.getAttribute("role"))) { %>
                <th colspan="2">Action</th>
                    <% } else if ("user".equals(session.getAttribute("role"))) { %>
                <th>Buy Action</th>
                    <% } %>
            </tr>
            <%
                ArrayList<Hotel> allHotels = HotelDB.listAll();
                if (allHotels != null) {
                    for (Hotel i : allHotels) {
                        request.setAttribute("hotel", i);
            %>
            <tr>
                <td><jsp:getProperty name="hotel" property="hotelId" /></td>
                <td><jsp:getProperty name="hotel" property="hotelName" /></td>
                <td><jsp:getProperty name="hotel" property="hotelDescription" /></td>
                <td><jsp:getProperty name="hotel" property="hotelAddress" /></td>
                <td><jsp:getProperty name="hotel" property="city" /></td>
                <td><jsp:getProperty name="hotel" property="country" /></td>
                <% if ("admin".equals(session.getAttribute("role"))) { %>
                <td>
                    <form action="update.jsp" method="get" style="display:inline;">
                        <input class="fixleng" type="hidden" name="hotelId" value="<jsp:getProperty name='hotel' property='hotelId' />">
                        <input class="fixleng" type="hidden" name="hotelName" value="<jsp:getProperty name='hotel' property='hotelName' />">
                        <input class="fixleng" type="hidden" name="hotelDescription" value="<jsp:getProperty name='hotel' property='hotelDescription' />">
                        <input class="fixleng" type="hidden" name="hotelAddress" value="<jsp:getProperty name='hotel' property='hotelAddress' />">
                        <input class="fixleng" type="hidden" name="city" value="<jsp:getProperty name='hotel' property='city' />">
                        <input class="fixleng" type="hidden" name="country" value="<jsp:getProperty name='hotel' property='country' />">
                        <input class="fixleng" type="submit" value="Update">
                    </form>
                </td>
                <td>
                    <a href="#" onclick="doDelete('<jsp:getProperty name="hotel" property="hotelId" />')">Delete</a>
                </td>
                <% } else if ("user".equals(session.getAttribute("role"))) { %>
                <td>
                    <form action="CartServlet" method="get" style="display: flex; align-items: center;">
                        <input class="fixleng" type="hidden" name="hotelId" value="<jsp:getProperty name='hotel' property='hotelId' />">
                        <input class="fixleng" type="hidden" name="hotelName" value="<jsp:getProperty name='hotel' property='hotelName' />">
                        <input class="fixleng" type="hidden" name="hotelDescription" value="<jsp:getProperty name='hotel' property='hotelDescription' />">
                        <input class="fixleng" type="hidden" name="hotelAddress" value="<jsp:getProperty name='hotel' property='hotelAddress' />">
                        <input class="fixleng" type="hidden" name="city" value="<jsp:getProperty name='hotel' property='city' />">
                        <input class="fixleng" type="hidden" name="country" value="<jsp:getProperty name='hotel' property='country' />">
                        <input class="fixleng" type="submit" value="Add to Cart">
                    </form>
                </td>
                <% } %>
            </tr>
            <%   }
                } else {
            %>
            <tr>
                <td colspan="5">No hotels available.</td>
            </tr>
            <%
                }
            %>
        </table>
        <% if ("admin".equals(session.getAttribute("role"))) { %>
        <a class="text" href="Add.jsp">Add Hotel</a>
        <% } else { %>
        <a class="text" href="AddToCart.jsp">View Cart</a>
        <% } %>
        <form action="<%=response.encodeURL("UserServlet") %>" method="get">
            <input class="logout" type="submit" name="action" value="Log Out">
        </form>
    </body>
    <script type="text/javascript">
        function doDelete(hotelId) {
            if (confirm('Are you sure you want to delete this hotel?')) {
                const url = 'HotelServlet?action=delete&id=' + hotelId;
                window.location.href = url;
            }
        }
    </script>
</html>