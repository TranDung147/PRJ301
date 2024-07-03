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

        .leftht, .rightht, .leftt, .rightt {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .leftht label{
            width: 250px;
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


    </style>
    <main class="mainht">
        <div class="bodyht">
            <div class="containerht">
                <div class="headerht">
                    <h1>Đặt khách sạn của bạn ngay hôm nay!</h1>
                </div>
                <div class="boxht">
                    <div class="leftht">
                        <div><img src="img/people.png" alt=""></div>
                        <div class="startht">
                            <label for="city">Thành phố:</label>
                            <input type="text" id="city" placeholder="Nhập thành phố">
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
                    <div class="leftht">
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
                    <form action="roomServlet" method="post" id="bookingForm">
                        <input type="hidden" name="action" value="bookRoom">
                        <input type="hidden" name="rooms" id="hiddenRooms">
                        <button type="submit" class="btnsht">ĐẶT NGAY</button>
                    </form>
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
