<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 20px;
            }
            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"],
            select,
            input[type="date"],
            input[type="number"] {
                width: 80%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            button {
                padding: 10px 15px;
                background-color: #5cb85c;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #4cae4c;
            }
            .button-container {
                text-align: left;
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.detail == null}">
            <p>No detail found in session!</p>
        </c:if>

        <c:if test="${sessionScope.detail != null}">
            <form action="CRUD?type=${sessionScope.type}" method="post">
                <input type="hidden" name="id" value="${param.id}">

                <c:choose>
                    <c:when test="${sessionScope.type == 'Hotel'}">
                        <label>Name:</label>
                        <input type="text" name="name" value="${sessionScope.detail.hotelName}" required>
                        <label>Address:</label>
                        <input type="text" name="address" value="${sessionScope.detail.hotelAddress}" required>
                        <label>Description:</label>
                        <input type="text" name="description" value="${sessionScope.detail.hotelDescription}" required>
                        <label>City:</label>
                        <input type="text" name="city" value="${sessionScope.detail.city}" required>
                        <label>Country:</label>
                        <input type="text" name="country" value="${sessionScope.detail.country}" required>
                        <label>Image URL:</label>
                        <input type="text" name="imageURL" value="${sessionScope.detail.productImage}" required>
                    </c:when>

                    <c:when test="${sessionScope.type == 'Plane'}">
                        <label>Plane Name:</label>
                        <input type="text" name="name" value="${sessionScope.detail.planeName}" required>
                        <label>Airline:</label>
                        <input type="text" name="airline" value="${sessionScope.detail.airline}" required>
                        <label>Plane Image:</label>
                        <input type="text" name="planeImg" value="${sessionScope.detail.planeImg}" required>
                        <label>Number of Seats:</label>
                        <input type="number" name="noSeat" value="${sessionScope.detail.noSeat}" required min="1">
                    </c:when>


                    <c:when test="${sessionScope.type == 'Flight'}">
                        <input type="hidden" name="planeId" value="${param.planeId}">
                        <label>Departure Date:</label>
                        <input type="date" name="departureDate" value="${sessionScope.detail.dateStart}" required>
                        <label>Date End:</label>
                        <input type="date" name="dateEnd" value="${sessionScope.detail.dateEnd}" required>
                        <label>Departure City:</label>
                        <input type="text" name="departureCity" value="${sessionScope.detail.departureCity}" required>
                        <label>Arrival City:</label>
                        <input type="text" name="arrivalCity" value="${sessionScope.detail.arrivalCity}" required>
                        <label>Seats Left:</label>
                        <input type="number" name="noSeatLeft" value="${sessionScope.detail.noSeatLeft}" required min="0">
                    </c:when>

                    <c:when test="${sessionScope.type == 'Room'}">
                        <input type="hidden" name="hotelID" value="${param.hotelID}">
                        <label>Room Number:</label>
                        <input type="text" name="roomNumber" value="${sessionScope.detail.roomNumber}" required>
                        <label>Room Type:</label>
                        <input type="text" name="roomType" value="${sessionScope.detail.roomType}" required>
                        <label>Capacity:</label>
                        <input type="number" name="capacity" value="${sessionScope.detail.capacity}" required min="1">
                        <label>Is Available:</label>
                        <select name="isAvailable" required>
                            <option value="1" ${sessionScope.detail.isAvailable == 1 ? 'selected' : ''}>Yes</option>
                            <option value="0" ${sessionScope.detail.isAvailable == 0 ? 'selected' : ''}>No</option>
                        </select>
                    </c:when>

                    <c:when test="${sessionScope.type == 'Seat'}">
                        <input type="hidden" name="flightID" value="${param.flightID}">
                        <label>Seat Number:</label>
                        <input type="text" name="seatNumber" value="${sessionScope.detail.seatNumber}" required>
                        <label>Seat Type:</label>
                        <input type="text" name="seatType" value="${sessionScope.detail.seatType}" required>
                        <label>Is Available:</label>
                        <select name="isAvailable" required>
                            <option value="1" ${sessionScope.detail.isAvailable == 1 ? 'selected' : ''}>Yes</option>
                            <option value="0" ${sessionScope.detail.isAvailable == 0 ? 'selected' : ''}>No</option>
                        </select>
                    </c:when>
                </c:choose>

                <div class="button-container">
                    <button type="submit">Update ${sessionScope.type}</button>
                </div>
            </form>
        </c:if>
    </body>
</html>
