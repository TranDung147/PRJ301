<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt khách sạn ngon bổ rẻ</title>

        <!-- Bootstrap JS and dependencies -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/headerfooter.css" rel="stylesheet" />
    </head>

    <%
        String user = (String) session.getAttribute("user");
        if (user == null) { %>
    <%@include file="includes/header.jsp" %>
    <% } else { %>
    <%@include file="includes/header_user.jsp" %>
    <% }%>

    <style>
        .mainht {
            padding-bottom: 90px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 100%;
            position: relative;
            background: url('img/countryside.jpg'); /* Background image */
        }

        .bodyht {
            display: flex;
            flex-direction: column;
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
            margin-top: 57px;
            width: 60%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .containerht2 {
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 57px;
            width: 90%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .containerht input{
            margin-top: 0;
        }


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

        .optionals-buttonht div {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .khuhoiht {
            cursor: pointer;
        }

        .optionals-buttonht label {
            border-radius: 5px;
            font-size: 16px;
            color: #333;
            transition: background-color 0.3s ease;
        }

        /* Form styling */
        .optionalht form {
            display: flex;
            flex-direction: column;
            width: 100%;
            gap: 20px;
        }

        .boxht {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .boxht .leftht{
            margin: 10px 0;
        }

        .leftht, .rightht, .leftt, .rightt {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .leftht label{
            width: 200px;
        }

        .leftht select{
            width: 200px;
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

        .leftht img, .rightht img, .leftt img, .rightt img {
            width: 20px;
            height: 20px;
        }

        .containerht img{
            margin-top: 25px;
        }

        .optionalht input{
            margin-top: 0px;
        }

        .startht, .endht, .peopleht, .roomht {
            display: flex;
            flex-direction: column;
        }

        .rightht {
            text-align: center;
        }

        .roomht {
            align-items: center;
        }

        .containerht label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }

        .containerht input[type="text"], input[type="number"], input[type="date"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            width: 100%;
        }

        .containerht input[type="text"]:focus, input[type="number"]:focus, input[type="date"]:focus {
            border-color: #007bff;
            outline: none;
        }

        .submit-rowht {
            display: flex;
            justify-content: center;
            width: 100%;
            margin-top: 20px;
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

        .containerht img{
            margin-bottom: 10px;
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
            height: 165px;
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

        .boxht .rightss{
            justify-content: flex-end;
        }

        /* Media queries */
        @media only screen and (min-width: 1055px) {
            /* Styles for screens wider than 1055px */
            .containerht {
                width: 50%;
            }

            .containerht2 {
                width: 90%;
            }
        }

        @media only screen and (min-width: 1024px) and (max-width: 1254px) {
            /* Styles for screens between 1024px and 1254px */
            .containerht {
                width: 70%;
            }

            .containerht2 {
                width: 80%;
            }
        }

        @media only screen and (min-width: 768px) and (max-width: 1023px) {
            /* Styles for screens between 768px and 1023px */
            .containerht {
                width: 90%;
            }

            .containerht2 {
                width: 90%;
            }

            
            .btnsht {
                
            }
        }

        @media only screen and (min-width: 425px) and (max-width: 767px) {
            /* Styles for screens between 425px and 767px */
            .containerht {
                width: 95%;
            }

            .containerht2 {
                width: 95%;
            }

            .boxht {
                flex-direction: column;
                align-items: center;
            }

            .card-custom {
                width: 100%;
            }

            .pagination a {
                display: block;
                margin: 5px 0;
            }

            .bodyht{
                margin-top: 15px;
            }
            .leftht label, .leftht select{
                width: 202px;
            }
            .btnsht {
                width: 202px;
                margin-left: 30px;
            }
        }

        @media only screen and (max-width: 424px) {
            /* Styles for screens smaller than 425px */
            .containerht {
                width: 95%;
            }

            .containerht2 {
                width: 95%;
            }

            .boxht {
                flex-direction: column;
                align-items: center;
            }

            .card-custom {
                width: 100%;
            }

            .pagination a {
                display: block;
                margin: 5px 0;
            }
            .bodyht{
                margin-top: 15px;
            }
            .leftht label, .leftht select{
                width: 202px;
            }
            .btnsht {
                width: 202px;
                margin-left: 30px;
            }
        }
    </style>
    <main class="mainht">
        <div class="bodyht">
            <div class="containerht">
                <div class="headerht">
                    <h1>Đặt khách sạn của bạn ngay hôm nay!</h1>
                </div>
                <form action="HotelServlet">
                    <div class="boxht">
                        <div class="leftht">
                            <div><img src="img/people.png" alt=""></div>
                            <div class="startht">
                                <label for="city">Thành phố:</label>
                                <input type="text" id="city" name="city" placeholder="Nhập thành phố">
                            </div>
                        </div>
                        <div class="leftht">
                            <div><img src="img/people.png" alt=""></div>
                            <div class="startht">
                                <select name="roomType" id="roomType">
                                    <option value="">Chọn loại phòng</option>
                                    <option value="VIP">Phòng đặc biệt</option>
                                    <option value="Standard">Phòng thường</option>
                                </select>
                            </div>
                        </div>
                        <div class="leftht">
                            <div><img src="img/people.png" alt=""></div>
                            <div class="peopleht">
                                <label for="rooms">Số phòng:</label>
                                <input type="number" id="rooms" placeholder="Số phòng cần đặt">
                            </div>
                        </div>
                    </div>

                    <div class="boxht">
                        <div class="leftht rightss">
                            <div><img src="img/calendar.png" alt=""></div>
                            <div class="roomht">
                                <label for="checkin">Ngày nhận phòng:</label>
                                <input type="date" id="checkin">
                            </div>
                        </div>
                        <div class="leftht">
                            <div><img src="img/calendar.png" alt=""></div>
                            <div class="roomht">
                                <label for="checkout">Ngày trả phòng:</label>
                                <input type="date" id="checkout">
                            </div>
                        </div>
                    </div>
                    <div class="submit-rowht">

                        <input type="hidden" name="action" value="searchHotel">
                        <input type="hidden" name="page" value="1">
                        <button type="submit" class="btnsht">ĐẶT NGAY</button>

                    </div>
                </form>
            </div>
            <div class="containerht containerht2">
                <div class="card-container">

                    <c:if test="${hotelList != null}">
                        <c:forEach var="h" items="${hotelList}">   
                            <div class="card-custom">
                                <form action="roomServlet" method="get">
                                    <input type="hidden" name="hotelID" value="${h.hotelId}">
                                    <input type="hidden" name="hotelName" value="${h.hotelName}">      
                                    <img src="img/${h.productImage}" alt="${h.productImage}">
                                    <div class="card-body-custom">
                                        <h5> ${h.hotelName} </h5>
                                        <p>Địa chỉ: ${h.hotelAddress}, ${h.country} </p>
                                        <div class="cc">
                                            <button class="btn bg-primary text-white mx-auto xemphongbut" type="submit">Xem phòng</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${hotelList == null}">
                        <div class="alert alert-warning" role="alert">
                            No Hotel Found.
                        </div>
                    </c:if>

                </div>
                <div class="pagination">
                    <c:if test="${curPage > 1}">
                        <a href="HotelServlet?action=loadPage&page=${curPage - 1}">&laquo;</a>
                    </c:if>
                    <c:forEach var="p" items="${pageList}">
                        <a href="HotelServlet?action=loadPage&page=${p}" <c:if test="${curPage == p}">class="active"</c:if>>${p}</a>
                    </c:forEach>
                    <c:if test="${curPage < pageList.size()}">
                        <a href="HotelServlet?action=loadPage&page=${curPage + 1}">&raquo;</a>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</main>

<script>
    document.getElementById('bookingForm').addEventListener('submit', function (event) {
        var rooms = document.getElementById('roomType').value;
        document.getElementById('hiddenRooms').value = rooms;
    });
</script>
