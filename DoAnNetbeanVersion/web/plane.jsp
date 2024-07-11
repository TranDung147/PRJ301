<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*, DAO.DatabaseInfo, Model.Plane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách máy bay</title>

        <!-- Bootstrap JS and dependencies -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/headerfooter.css" rel="stylesheet" />
        <link href="assets/css/sort.css" rel="stylesheet" />
    </head>

    <% 
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
    <%@include file="includes/header.jsp" %>
    <% } else { %>
    <%@include file="includes/header_user.jsp" %>
    <% } %>

    <main class="mainH">  
        <div class="containerB">
            <div class="row">
                <!-- Your product list -->
                <div class="product-list" id="content">
                    <c:forEach var="p" items="${pList}">
                        <div class="cols product location">
                            <img class="image images" src="img/${p.planeImg}" alt="${p.planeImg}">
                            <h4>${p.planeName}</h4>
                            <p><span>Hãng:</span>${p.airline}</p>
                            <p><span>Còn trống:</span> ${p.noSeat}</p>
                        </div>
                    </c:forEach> 
                </div>
            </div>
        </div>
    </main>
    <%@include file="includes/footer.jsp" %>
