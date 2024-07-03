<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chọn chỗ ngồi</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
    <link href="assets/css/headerfooter.css" rel="stylesheet" />
    <link href="assets/css/roomDisplay.css" rel="stylesheet" />
    <style>
        .room {
            border: 1px solid #ccc;
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .room-available {
            background-color: lightgreen;
        }

        .room-not-available {
            background-color: lightcoral;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            transition: opacity 0.3s ease;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal.show {
            display: block;
        }

        .modal-content.show {
            opacity: 1;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-footer {
            margin-top: 10px;
            text-align: right;
        }

        .btn-secondary {
            background-color: #ccc;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn-book {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn-book:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <% 
        String user = (String) session.getAttribute("user");
        if (user == null) { 
    %>
    <%@include file="includes/header.jsp" %>
    <% } else { %>
    <%@include file="includes/header_user.jsp" %>
    <% } %>

    <div class="container">
        <div class="row mt-3">
            <div class="col-12 center-text">
                <h1>Seats for Flight</h1>
                <div class="room-container mt-3">
                    <div class="row">
                        <% 
                            List<Seat> seats = (List<Seat>) request.getAttribute("seatList");
                            if (seats != null && !seats.isEmpty()) {
                                for (Seat seat : seats) {
                                    String seatClass = (seat.getIsAvailable() == 1) ? "room-available" : "room-not-available";
                        %>
                            <div class="col-md-2 mb-3">
                                <div class="room <%= seatClass %>" onclick="openModal('seatModal<%= seat.getSeatID() %>')" data-room-type="<%= seat.getSeatType() %>" data-room-id="<%= seat.getSeatID() %>">
                                    <%= seat.getSeatNumber() %>
                                </div>
                            </div>

                            <!-- Modal for seat details -->
                            <div id="seatModal<%= seat.getSeatID() %>" class="modal">
                                <div class="modal-content">
                                    <span class="close" onclick="closeModal('seatModal<%= seat.getSeatID() %>')">&times;</span>
                                    <h5>Seat Details - <%= seat.getSeatNumber() %></h5>
                                    <p>Type: <%= seat.getSeatType() %></p>
                                    <p>Availability: <%= (seat.getIsAvailable() == 1) ? "Available" : "Not Available" %></p>
                                    <div class="modal-footer">
                                        <button type="button" class="btn-secondary" onclick="closeModal('seatModal<%= seat.getSeatID() %>')">Close</button>
                                        <% if (seat.getIsAvailable() == 1) { %>
                                        <button type="button" class="btn-book" onclick="bookSeat('<%= seat.getSeatID() %>', '<%= seat.getFlightID() %>')">Book</button>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        <% 
                                }
                            } else {
                        %>
                        <div class="col-md-12">
                            <p>No seats available for this flight.</p>
                        </div>
                        <% } %>
                    </div>        
                </div>
            </div>
        </div>
    </div>

    <%@include file="includes/footer.jsp" %>

    <script>
        function openModal(modalId) {
            var modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.add("show");
                var content = modal.querySelector(".modal-content");
                content.classList.add("show");
            }
        }

        function closeModal(modalId) {
            var modal = document.getElementById(modalId);
            if (modal) {
                var content = modal.querySelector(".modal-content");
                content.classList.remove("show");
                setTimeout(() => modal.classList.remove("show"), 300);
            }
        }

        function bookSeat(seatID, flightID) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "CartServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            alert("Ticket booked successfully.");
                            var seatElement = document.querySelector(`[data-room-id='${seatID}']`);
                            if (seatElement) {
                                seatElement.classList.remove("room-available");
                                seatElement.classList.add("room-not-available");
                            }
                            closeModal('seatModal' + seatID);
                        } else {
                            alert("Booking failed. Please try again.");
                        }
                    } else {
                        alert('Failed to book ticket. Please try again.');
                    }
                }
            };
            xhr.send("seatID=" + seatID + "&FlightID=" + encodeURIComponent(flightID));
        }

        window.openModal = openModal;
        window.closeModal = closeModal;
        window.bookSeat = bookSeat;
    </script>
</body>
</html>
