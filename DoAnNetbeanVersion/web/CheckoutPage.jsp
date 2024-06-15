<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out Page</title>
    </head>
    <body>
        <style>
            body{
            background-size: cover;
            background-position-y: -80px;
            font-size: 16px;
        }
        h2{
            text-align: center;
            font-style: italic;
        }
        input{
            display: flex;
            margin: 10px auto;
            border: 2px solid orange;
            border-radius: 5px;
            background-color: rgba(87, 85, 85, 0.8); 
            width: 5%;
            height: 50px;
            color: white;
            padding-left: 1%;
        }
        </style>
        <%--session--%>
        
    <%
    String userName = null;
    //allow access only if session exists
    if(session.getAttribute("user") == null){
            response.sendRedirect("login.html");
    }else userName = (String) session.getAttribute("user");
    String sessionID = null;
    Cookie[] cookies = request.getCookies();
    if(cookies !=null){
    for(Cookie cookie : cookies){
            if(cookie.getName().equals("user")) userName = cookie.getValue();
    }
    }
    %>

        <h2>Hi <%=userName %>, do the checkout.</h2>
        <br>
        <form action="<%=response.encodeURL("LogoutServlet") %>" method="get">
            <input type="submit" value="Logout" >
        </form>
    </body>
</html>