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
        <link href="assets/css/headerfooter.css" rel="stylesheet" />
        <link href="assets/css/roomDisplay.css" rel="stylesheet" />
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
                                    <label for="single">Standard: </label>
                                    <span class="checkbox">
                                        <input id="checkboxStandard" type="checkbox" onchange="filterRooms()" />
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

                                    <label for="double">VIP: </label>
                                    <span class="checkbox">
                                        <input id="checkboxVIP" type="checkbox" onchange="filterRooms()" />
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
                                        <label for="startDate" class="sr-only">Start Date:</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" placeholder="Start Date" required>
                                    </div>
                                    <div class="date-container mx-sm-3 mb-2">
                                        <label for="endDate" class="sr-only">End Date:</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" placeholder="End Date" required>
                                    </div>
                                    <input type="hidden" id="hotelID" name="hotelID" value="${hotelID}"> <!-- Trường ẩn cho hotelID -->
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
                                <div class="room <%= roomClass %>" onclick="openModal('roomModal<%= room.getRoomID() %>')" data-room-type="<%= room.getRoomType() %>" data-room-id="<%= room.getRoomID() %>">
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
                                        <button type="button" class="btn-book" onclick="showBookingModal('<%= room.getRoomID() %>')">Book</button>
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

                <div id="bookingModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeModal('bookingModal')">&times;</span>
                        <h5>Booking Details</h5>
                        <form id="bookingForm" onsubmit="submitBooking(event)">
                            <input type="hidden" id="bookingRoomID" name="roomID">
                            <div class="form-group">
                                <label for="checkInDate">Check-in Date:</label>
                                <input type="date" id="checkInDate" name="checkInDate" required>
                            </div>
                            <div class="form-group">
                                <label for="checkOutDate">Check-out Date:</label>
                                <input type="date" id="checkOutDate" name="checkOutDate" required>
                            </div>
                            <button type="submit" id="submitButton" class="btn btn-primary">Submit</button>
                            <button type="button" id="okButton" class="btn btn-primary" style="display: none;" onclick="reloadPage()">OK</button>
                            <div id="bookingMessage" style="display:none; background-color: #d4edda; color: #155724; padding: 10px; margin-top: 10px; border: 1px solid #c3e6cb;">
                                Booking successful.
                            </div>
                        </form>
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

                function showBookingModal(roomID) {
                    document.getElementById('bookingRoomID').value = roomID;
                    openModal('bookingModal');
                }

                function submitBooking(event) {
                    event.preventDefault();
                    var form = document.getElementById('bookingForm');
                    var roomID = document.getElementById('bookingRoomID').value;
                    var checkInDate = document.getElementById('checkInDate').value;
                    var checkOutDate = document.getElementById('checkOutDate').value;
                    var hotelID = document.getElementById('hotelID').value;

                    checkLoginAndBook(roomID, checkInDate, checkOutDate, hotelID);
                }

                function checkLoginAndBook(roomID, checkInDate, checkOutDate, hotelID) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "CheckLoginServlet", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4) {
                            if (xhr.status === 200) {
                                var response = JSON.parse(xhr.responseText);
                                if (response.loggedIn) {
                                    // Nếu đã đăng nhập, tiến hành đặt phòng
                                    bookRoom(roomID, checkInDate, checkOutDate, hotelID);
                                } else {
                                    alert('You need login to book');
                                    window.location.href = 'index.jsp';
                                }
                            } else {
                                alert('Failed to check login status. Please try again.');
                            }
                        }
                    };
                    xhr.send();
                }

                function reloadPage() {
                    window.location.href = 'roomServlet?hotelID=${hotelID}&hotelName=${hotelName}';
                }

                function bookRoom(roomID, checkInDate, checkOutDate, hotelID) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "CartServlet", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4) {
                            if (xhr.status === 200) {
                                var response = JSON.parse(xhr.responseText);
                                var bookingMessageDiv = document.getElementById("bookingMessage");
                                var submitButton = document.getElementById("submitButton");
                                var okButton = document.getElementById("okButton");
                                if (response.success) {
                                    bookingMessageDiv.style.display = "block";
                                    submitButton.style.display = "none";
                                    okButton.style.display = "inline-block";
                                    var roomElement = document.querySelector(`[data-room-id='${roomID}']`);
                                    if (roomElement) {
                                        roomElement.classList.remove("room-available");
                                        roomElement.classList.add("room-not-available");
                                    }
                                } else {
                                    bookingMessageDiv.innerText = "Booking failed. Please try again.";
                                    bookingMessageDiv.style.display = "block";
                                }
                            } else {
                                bookingMessageDiv.innerText = "Failed to book room. Please try again.";
                                bookingMessageDiv.style.display = "block";
                            }
                        }
                    };
                    xhr.send("roomID=" + roomID + "&checkInDate=" + encodeURIComponent(checkInDate) + "&checkOutDate=" + encodeURIComponent(checkOutDate) + "&hotelID=" + encodeURIComponent(hotelID));
                }

                function filterRooms() {
                    var singleChecked = document.getElementById('checkboxStandard').checked;
                    var doubleChecked = document.getElementById('checkboxVIP').checked;
                    var rooms = document.querySelectorAll('.room');
                    rooms.forEach(function (room) {
                        var roomType = room.getAttribute('data-room-type');
                        var roomAvailable = room.classList.contains('room-available');

                        if ((singleChecked && doubleChecked) && roomAvailable) {
                            room.style.display = 'flex';

                        } else if ((singleChecked && roomType === 'VIP') || (doubleChecked && roomType === 'Standard')) {
                            room.style.display = 'none';
                        } else if (!roomAvailable) {
                            room.style.display = 'none';
                        } else {
                            room.style.display = 'flex';

                        }
                    });
                }



                function hideRoomsBeforeDate(event) {
                    event.preventDefault();

                    var startDate = document.getElementById('startDate').value;
                    var endDate = document.getElementById('endDate').value;
                    var hotelID = document.getElementById('hotelID').value;

                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "CheckBookedServlet", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4) {
                            if (xhr.status === 200) {
                                var response = JSON.parse(xhr.responseText);
                                console.log("Response:", response);

                                var start = new Date(startDate);
                                var end = new Date(endDate);

                                var rooms = document.querySelectorAll('.room');
                                rooms.forEach(function (room) {
                                    var roomID = room.getAttribute('data-room-id');
                                    var isBooked = response.bookings.some(function (booking) {
                                        if (booking.roomID === roomID) {
                                            var bookingStart = new Date(booking.checkInDate);
                                            var bookingEnd = new Date(booking.checkOutDate);
                                            return (bookingStart <= end && bookingEnd >= start);
                                        }
                                        return false;
                                    });

                                    if (isBooked) {
                                        room.style.display = 'none';
                                        room.classList.remove('room-available');
                                        room.classList.add('room-not-available');
                                    } else {
                                        room.style.display = 'flex'; // Hiển thị phòng nếu không bị đặt
                                        room.classList.remove('room-not-available');
                                        room.classList.add('room-available');
                                    }
                                });
                            } else {
                                console.error("Request failed with status: " + xhr.status + " " + xhr.statusText);
                                alert("Failed to fetch booking dates. Please try again.");
                            }
                        }
                    };

                    xhr.send("hotelID=" + encodeURIComponent(hotelID));
                }




                window.openModal = openModal;
                window.closeModal = closeModal;
                window.bookRoom = bookRoom;
                window.checkLoginAndBook = checkLoginAndBook;
                window.showBookingModal = showBookingModal;
                window.submitBooking = submitBooking;
                window.reloadPage = reloadPage;
                window.filterRooms = filterRooms;
                window.hideRoomsBeforeDate = hideRoomsBeforeDate;

            });

        </script>
        <%@include file="includes/footer.jsp" %>
    </body>

</html>
