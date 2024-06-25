<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Model.*" %>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt phòng tùy chọn</title>

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
    <% } %>
    <style>
        /* (Your CSS code remains the same) */
        body{
            height: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .room {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .room-available {
            background-color: #d4edda;
        }
        .room-not-available {
            background-color: #f8d7da;
        }
        .room:hover {
            background-color: #e2e6ea;
        }
        .room-container {
            border: 2px solid #007bff;
            padding: 15px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
            position: relative;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            right: 15px;
            top: 10px;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-book {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-book:hover {
            background-color: #218838;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
    <main>
        <div class="container">
            <div class="row mt-3">
                <div class="col-md-6">
                    <h1>Rooms for Hotel: <%= request.getAttribute("hotelID") %></h1>
                </div>
                <div class="col-md-6">
                    <form class="form-inline float-right">
                        <div class="form-group mx-sm-3 mb-2">
                            <label for="inputDate" class="sr-only">Date</label>
                            <input type="text" class="form-control" id="inputDate" placeholder="DD/MM/YYYY">
                        </div>
                        <button type="submit" class="btn btn-primary mb-2">Submit</button>
                    </form>
                </div>
            </div>
            <div class="room-container mt-3">
                <div class="row">
                    <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                    if (rooms != null) {
                        for (Room room : rooms) {
                            String roomClass = (room.getIsAvailable() == 1) ? "room-available" : "room-not-available";
                    %>
                    <div class="col-md-2 mb-3">
                        <div class="room <%= roomClass %>" onclick="openModal('roomModal<%= room.getRoomID() %>')">
                            <%= room.getRoomNumber() %>
                        </div>
                    </div>
                    <!-- Modal for room details -->
                    <div id="roomModal<%= room.getRoomID() %>" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="closeModal('roomModal<%= room.getRoomID() %>')">&times;</span>
                            <h5>Room Details - <%= room.getRoomNumber() %></h5>
                            <p>Type: <%= room.getRoomType() %></p>
                            <p>Availability: <%= (room.getIsAvailable() == 1) ? "Available" : "Not Available" %></p>
                            <div class="modal-footer">
                                <button type="button" class="btn-secondary" onclick="closeModal('roomModal<%= room.getRoomID() %>')">Close</button>
                                <% if (room.getIsAvailable() == 1) { %>
                                <button type="button" class="btn-book" onclick="checkLoginAndBook('<%= room.getRoomID() %>')">Book</button>
                                <% } else { %>
                                <button type="button" class="btn-book" disabled>Book</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% 
                        }
                    } else {
                    %>
                    <div class="col-md-12">
                        <p>No rooms available for this hotel.</p>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', (event) => {

            function openModal(modalId) {
                var modal = document.getElementById(modalId);
                if (modal) {
                    modal.style.display = "block";
                }
            }

            function closeModal(modalId) {
                var modal = document.getElementById(modalId);
                if (modal) {
                    modal.style.display = "none";
                }
            }
            function checkLoginAndBook(roomID) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "CheckLoginServlet", true); // Assuming you have a SessionCheckServlet to handle session checking
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            if (response.loggedIn) {
                                // If logged in, proceed to book the room
                                bookRoom(roomID);
                            } else {
                                alert('You need login to book');
                                window.location.href = 'index.jsp';
                            }
                        } else {
                            alert('Failed to check login status. Please try again.');
                        }
                    }
                };
                xhr.send(); // No need to send any parameters for session check
            }

            function bookRoom(roomID) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "CartServlet", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText); // Parse JSON response
                            if (response.success) {
                                alert("Room booked successfully.");
                                window.location.href = 'AddToCart.jsp'; // Redirect to confirmation page or appropriate URL
                            } else {
                                alert("Booking failed. Please try again.");
                            }
                        } else {
                            alert('Failed to book room. Please try again.');
                        }
                    }
                };
                xhr.send("roomID=" + roomID); // Send roomID as a POST parameter to CartServlet
            }


            // Expose functions to global scope to be accessible from HTML
            window.openModal = openModal;
            window.closeModal = closeModal;
            window.bookRoom = bookRoom;
            window.checkLoginAndBook = checkLoginAndBook;
        });

    </script>
    <%@include file="includes/footer.jsp" %>
