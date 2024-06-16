<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông tin khách sạn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100vh;
        }
        .hotel-container {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            overflow: hidden;
        }
        .hotel-header {
            background: #007bff;
            color: #ffffff;
            padding: 20px;
            text-align: center;
        }
        .hotel-details {
            padding: 20px;
        }
        .hotel-details p {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
        }
        .hotel-details img {
            max-width: 100%;
            border-radius: 10px;
        }
        .hotel-details span {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="hotel-container">
        <div class="hotel-header">
            <h1>Thông tin khách sạn</h1>
        </div>
        <div class="hotel-details">
            <p><span>ID:</span> ${hotel.hotelId}</p>
            <p><span>Tên:</span> ${hotel.hotelName}</p>
            <p><span>Địa chỉ:</span> ${hotel.hotelAddress}</p>
            <p><span>Mô tả:</span> ${hotel.hotelDescription}</p>
            <p><span>Thành phố:</span> ${hotel.city}</p>
            <p><span>Quốc gia:</span> ${hotel.country}</p>
            <img src="img/${hotel.productImage}" alt="Hình ảnh khách sạn">
        </div>
    </div>
</body>
</html>
