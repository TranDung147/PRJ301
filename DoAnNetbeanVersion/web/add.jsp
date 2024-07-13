<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Object</title>
        <!-- Include your CSS and JavaScript files -->
        <link rel="stylesheet" href="styles.css">
        <script src="scripts.js"></script>
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }

        .add-form {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin: 20px auto;
            width: 80%;
            max-width: 600px;
        }

        form {
            margin-top: 20px;
        }

        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        form input[type="text"],
        form input[type="number"],
        form textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        form button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #45a049;
        }

        h2 {
            margin-top: 0;
        }
    </style>
    <body>
        <div class="add-form">
            <c:choose>
                <c:when test="${param.object == 'hotel'}">
                    <h2>Add Hotel</h2>
                    <form action="AddServlet?object=hotel" method="POST">
                        <label>ID</label>
                        <input type="text" name="hotelID" required>
                        <label>Name:</label>
                        <input type="text" name="hotelName" required>
                        <label>Address:</label>
                        <input type="text" name="hotelAddress" required>
                        <label>Description:</label>
                        <textarea name="hotelDescription"></textarea>
                        <label>City:</label>
                        <input type="text" name="city" required>
                        <label>Country:</label>
                        <input type="text" name="country" required>
                        <label>Image URL</label>
                        <input type="text" name="productImg" required>
                        <button type="submit">Add Hotel</button>
                    </form>
                </c:when>
                <c:when test="${param.object == 'plane'}">
                    <h2>Add Plane</h2>
                    <form action="AddServlet?object=plane" method="POST">
                        <label>ID:</label>
                        <input type="text" name="planeID" required>
                        <label>Name:</label>
                        <input type="text" name="planeName" required>
                        <label>Airline:</label>
                        <input type="text" name="airline" required>
                        <label>Image:</label>
                        <input type="text" name="planeImg" required>
                        <label>Number of Seats:</label>
                        <input type="number" name="noSeat" required>
                        <button type="submit">Add Plane</button>
                    </form>
                </c:when>

                <c:when test="${param.object == 'flight'}">
                    <h2>Add Flight</h2>
                    <form action="AddServlet?object=flight" method="POST">
                        <label>Flight ID:</label>
                        <input type="text" name="flightID" required>
                        <label>Plane ID:</label>
                        <input type="text" name="planeID" required>
                        <label>Date Start:</label>
                        <input type="date" name="dateStart" required>
                        <label>Date End:</label>
                        <input type="date" name="dateEnd" required>
                        <label>Departure City:</label>
                        <input type="text" name="departureCity" required>
                        <label>Arrival City:</label>
                        <input type="text" name="arrivalCity" required>
                        <label>Number of Seats Left:</label>
                        <input type="number" name="noSeatLeft" required>
                        <button type="submit">Add Flight</button>
                    </form>
                </c:when>

                <c:when test="${param.object == 'room'}">
                    <h2>Add Room</h2>
                    <form action="AddServlet?object=room" method="POST">
                        <label>Room ID:</label>
                        <input type="text" name="roomID" required>
                        <label>Hotel ID:</label>
                        <input type="text" name="hotelID" required>
                        <label>Room Number:</label>
                        <input type="number" name="roomNumber" required>
                        <label>Room Type:</label>
                        <select name="roomType" required>
                            <option value="VIP">VIP</option>
                            <option value="Standard">Standard</option>
                        </select>
                        <label>Capacity:</label>
                        <input type="number" name="capacity" required>
                        <label>Is Available:</label>
                        <select name="isAvailable" required>
                            <option value="1">Yes</option>
                            <option value="0">No</option>
                        </select>
                        <button type="submit">Add Room</button>
                    </form>
                </c:when>

                <c:when test="${param.object == 'seat'}">
                    <h2>Add Seat</h2>
                    <form action="AddServlet?object=seat" method="POST">
                        <label>Seat ID:</label>
                        <input type="text" name="seatID" required>
                        <label>Flight ID:</label>
                        <input type="text" name="flightID" required>
                        <label>Seat Number:</label>
                        <input type="number" name="seatNumber" required>
                        <label>Seat Type:</label>
                        <select name="seatType" required>
                            <option value="VIP">VIP</option>
                            <option value="Standard">Standard</option>
                        </select>
                        <label>Is Available:</label>
                        <select name="isAvailable" required>
                            <option value="1">Yes</option>
                            <option value="0">No</option>
                        </select>
                        <button type="submit">Add Seat</button>
                    </form>
                </c:when>

            </c:choose>
        </div>

    </body>
</html>
