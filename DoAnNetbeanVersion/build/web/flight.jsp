<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt máy bay ngon bổ rẻ</title>

        <!-- Bootstrap JS and dependencies -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link href="assets/css/headerfooter.css" rel="stylesheet" />

        <style>
            .mainht {
                padding-bottom: 50px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
                width: 100%;
                position: relative;
                background: url('img/citycenter.jpg'); /* Background image */
            }

            .bodyht {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                height: 100%;
            }

            .containerht {
                box-sizing: border-box;
                background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 30px;
                width: 60%;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            /* Header styling */
            .headerht {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 20px;
                text-align: center;
            }

            .headerht h1 {
                font-size: 24px;
                color: #333;
                margin-bottom: 10px;
            }

            .headerht .optionals-buttonht {
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .optionals-buttonht input[type="radio"] {
                width: 10%;
            }

            .optionals-buttonht label {
                background-color: #f0f0f0; /* Background color for labels */
                padding: 10px 25px;
                border-radius: 5px;
                font-size: 16px;
                color: #333;
                transition: background-color 0.3s ease;
            }

            .optionals-buttonht {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Form styling */
            .optionalht form {
                display: flex;
                flex-direction: column;
                width: 100%;
                gap: 20px;
            }

            .optionalht input, .optionalht select {
                margin-top: 0px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 202px;
            }

            .optionalht input:focus, .optionalht select:focus {
                border-color: #007bff;
                outline: none;
            }


            /* Input row styling */
            .boxht {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }

            .leftht,
            .rightht,
            .leftt,
            .rightt {
                flex: 1;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .leftht img,
            .rightht img,
            .leftt img,
            .rightt img {
                width: 20px;
                height: 20px;
            }

            .containerht img{
                margin-top: 20px;
            }

            .startht,
            .endht,
            .peopleht,
            .roomht {
                display: flex;
                flex-direction: column;
            }

            .containerht label {
                font-size: 14px;
                color: #666;
                margin-bottom: 5px;
            }

            .containerht input[type="text"],
            input[type="number"],
            input[type="date"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 100%;
            }

            .containerht input[type="text"]:focus,
            input[type="number"]:focus,
            input[type="date"]:focus {
                border-color: #007bff;
                outline: none;
            }

            /* Submit button row */
            .submit-rowht {
                display: flex;
                justify-content: center;
                width: 100%;
            }

            .btnsht {
                padding: 10px 20px;
                background-color: #007bff;
                color: #ffffff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                width: 100%; /* Full width for the button */
                text-align: center;
            }

            .btnsht:hover {
                background-color: #0056b3;
            }

            .timeht input{
                width: 127%;
            }
            .card-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
            }

            .card-custom {
                width: 18rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            .card-custom img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }

            .card-body-custom {
                padding: 20px;
                text-align: center;
            }

            .card-body-custom h5 {
                font-size: 16px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .card-body-custom p {
                font-size: 14px;
                color: #333;
            }

            .card-body-custom .price {
                font-size: 18px;
                color: red;
                margin: 10px 0;
            }

            .btn-custom {
                background-color: #ffc107;
                color: #fff;
                font-weight: bold;
                padding: 10px;
                border: none;
                border-radius: 5px;
                width: 100%;
                cursor: pointer;
            }

            .btn-custom:hover {
                background-color: #e0a800;
            }
            /*CSS 123456789*/
            #khoihanh {
                display: flex;
                justify-content: center;
            }

            .pagination {
                display: inline-block;
                margin-top: 20px;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
                border: 1px solid #ddd;
                margin: 0 4px;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }

            .leftht select{
                width: 250px;
                height: 50px;

                font-size: 14px;
                color: #666;
                margin-bottom: 5px;

                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 100%;

                margin-top: 25px;
            }
        </style>
    </head>


    <% 
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
    <%@include file="includes/header.jsp" %>
    <% } else { %>
    <%@include file="includes/header_user.jsp" %>
    <% } %>

    <main class="mainht">
        <div class="bodyht">
            <div class="containerht">
                <div class="titleht">
                    <h1>Đặt chuyến bay ngay tại đây</h1>
                </div>
                <form action="FlightServlet">
                    <div class="optionalht">
                        <div class="boxht">
                            <div class="leftht">
                                <div><img src="img/airplane.png" alt=""></div>
                                <div class="startht">
                                    <label for="start">Bay từ</label>
                                    <input type="text" id="start" name="start" placeholder="Bay từ" required>
                                </div>
                            </div>
                            <div class="rightht">
                                <div><img src="img/placeholder.png" alt=""></div>
                                <div class="endht">
                                    <label for="end">Bay đến</label>
                                    <input type="text" id="end" name="end" placeholder="Bay đến" required>
                                </div>
                            </div>
                        </div>

                        <div class="boxht">
                            <div class="leftht">
                                <div><img src="img/people.png" alt=""></div>
                                <div class="peopleht">
                                    <label for="people">Hành khách</label>
                                    <input type="text" id="people" name="people" placeholder="Hành khách" required>
                                </div>
                            </div>
                            <div class="rightht duoiht">
                                <div><img src="img/exit.png" alt=""></div>
                                <div class="roomht">
                                    <label for="room">Hạng</label>
                                    <select name="roomType" id="roomType" required>
                                        <option value="">Chọn loại ghế</option>
                                        <option value="VIP">VIP</option>
                                        <option value="Standard">Standard</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="boxht box1ht timeht">
                            <div class="leftht" id="khoihanh">
                                <div><img src="img/calendar.png" alt=""></div>
                                <div class="roomht">
                                    <label for="date">Khởi hành:</label>
                                    <input type="date" id="date" name="date" required>
                                </div>
                            </div>
                        </div>
                        <br>
                        <input type="hidden" name="action" value="search">
                        <input type="hidden" name="page" value="1">
                        <div class="submit-rowht">
                            <button type="submit" class="btnsht">TÌM CHUYẾN BAY</button>
                        </div>
                    </div>
                </form>

                <div class="card-container">
                    <c:if test="${flightList != null}">
                        <c:forEach var="f" items="${flightList}">
                            <div class="card-custom">
                                <img src="img/airbusa320.jpg" alt="Flight Image">
                                <div class="card-body-custom">
                                    <h5> ${f.getDepartureCity()} đến ${f.getArrivalCity()} </h5>
                                    <p>Khởi hành: ${f.getDateStart()} </p>
                                    <form action="SeatServlet" method="post">
                                        <input type="hidden" name="flightID" value="${f.getFlightID()}">
                                        <button type="submit" class="btn-custom">Xem chỗ ngồi</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${flightList == null}">
                        <div class="alert alert-warning" role="alert">
                            No Flight Found.
                        </div>
                    </c:if>

                </div>
                <div class="pagination">
                    <c:if test="${curPage > 1}">
                        <a href="FlightServlet?action=loadPage&page=${curPage - 1}">&laquo;</a>
                    </c:if>
                    <c:forEach var="p" items="${pageList}">
                        <a href="FlightServlet?action=loadPage&page=${p}" <c:if test="${curPage == p}">class="active"</c:if>>${p}</a>
                    </c:forEach>
                    <c:if test="${curPage < pageList.size()}">
                    <a href="FlightServlet?action=loadPage&page=${curPage + 1}">&raquo;</a>
                    </c:if>

                </div>
            </div>
        </div>
    </main>
