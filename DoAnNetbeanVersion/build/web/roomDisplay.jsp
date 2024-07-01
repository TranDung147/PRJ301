<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="Model.*" %>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt phòng tùy chọn</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
       
        <link href="assets/css/roomDisplay.css" rel="stylesheet" />
         <link href="assets/css/headerfooter.css" rel="stylesheet" />
    </head>

    <body>
        <% 
        String user = (String) session.getAttribute("user");
        if (user == null) { %>
        <%@include file="includes/header.jsp" %>
        <% } else { %>
        <%@include file="includes/header_user.jsp" %>
        <% } %>

        <main>
            <div class="container">
                <div class="row mt-3">
                    <div class="col-12 center-text">
                        <h1>Rooms for Hotel: ${hotelName}</h1>
                    </div>
                    <div class="row date-roomtype-container">
                        <div class="col-6">
                            <div class="form-inline">
                                <label class="sr-only">Room Type: </label><br>
                                <!--Checkbox example-->
                                <div class="checkbox-wrapper-30">
                                    <label for="single">Single: </label>
                                    <span class="checkbox">
                                        <input id="checkboxSingle" type="checkbox" onchange="filterRooms()" />
                                        <svg>
                                        <use xlink:href="#checkbox-30" class="checkbox"></use>
                                        </svg>
                                    </span>
                                    <svg xmlns="http://www.w3.org/2000/svg" style="display:none">
                                    <symbol id="checkbox-30" viewBox="0 0 22 22">
                                        <path fill="none" stroke="currentColor"
                                              d="M5.5,11.3L9,14.8L20.2,3.3l0,0c-0.5-1-1.5-1.8-2.7-1.8h-13c-1.7,0-3,1.3-3,3v13c0,1.7,1.3,3,3,3h13 c1.7,0,3-1.3,3-3v-13c0-0.4-0.1-0.8-0.3-1.2" />
                                    </symbol>
                                    </svg>

                                    <label for="double">Double: </label>
                                    <span class="checkbox">
                                        <input id="checkboxDouble" type="checkbox" onchange="filterRooms()" />
                                        <svg>
                                        <use xlink:href="#checkbox-30" class="checkbox"></use>
                                        </svg>
                                    </span>
                                    <svg xmlns="http://www.w3.org/2000/svg" style="display:none">
                                    <symbol id="checkbox-30" viewBox="0 0 22 22">
                                        <path fill="none" stroke="currentColor"
                                              d="M5.5,11.3L9,14.8L20.2,3.3l0,0c-0.5-1-1.5-1.8-2.7-1.8h-13c-1.7,0-3,1.3-3,3v13c0,1.7,1.3,3,3,3h13 c1.7,0,3-1.3,3-3v-13c0-0.4-0.1-0.8-0.3-1.2" />
                                    </symbol>
                                    </svg>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-inline">
                                <form class="form-inline float-left" onsubmit="hideRoomsBeforeDate(event)">
                                    <div class="date-container mx-sm-3 mb-2">
                                        <label for="inputDate" class="sr-only">Date:</label>
                                        <input type="date" class="form-control" id="inputDate" placeholder="DD/MM/YYYY">
                                    </div>
                                    <button type="submit" class="btn btn-primary mb-2">Submit</button>
                                </form>
                            </div>
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
                                <div class="room <%= roomClass %>" onclick="openModal('roomModal<%= room.getRoomID() %>')" data-room-type="<%= room.getRoomType() %>">
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

                function filterRooms() {
                    var singleChecked = document.getElementById('checkboxSingle').checked;
                    var doubleChecked = document.getElementById('checkboxDouble').checked;

                    var rooms = document.querySelectorAll('.room');
                    rooms.forEach(function (room) {
                        var roomType = room.getAttribute('data-room-type');
                        var roomAvailable = room.classList.contains('room-available');

                        if ((singleChecked && doubleChecked) && roomAvailable) {
                            room.style.display = 'flex';
                        
                        } else if ((singleChecked && roomType === 'Double') || (doubleChecked && roomType === 'Single')) {
                            room.style.display = 'none';
                        } else if (!roomAvailable) {
                            room.style.display = 'none';
                        } else {
                            room.style.display = 'flex';
                            
                        }

                    }   
                    );
                }
                    function hideRoomsBeforeDate(event) {
                    event.preventDefault(); // Ngăn chặn form submit lại

                    var inputDate = document.getElementById('inputDate').value; 
                    var rooms = document.querySelectorAll('.room');

    
                    rooms.forEach(function (room) {
                        var roomDate = room.getAttribute('data-room-date');

                        if (roomDate && roomDate < inputDate) {
                            room.style.display = 'none';
                            room.classList.remove('room-available');
                            room.classList.add('room-not-available');
                        }
                    });
                }

                window.openModal = openModal;
                window.closeModal = closeModal;
                window.bookRoom = bookRoom;
                window.checkLoginAndBook = checkLoginAndBook;
                window.filterRooms = filterRooms;
                window.hideRoomsBeforeDate = hideRoomsBeforeDate;
            });

        </script>
        <%@include file="includes/footer.jsp" %>
    </body>

</html>
