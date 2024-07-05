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

        <main>
            <div class="container">
                <div class="row mt-3">
                    <div class="col-12 center-text">
                        <h1>Seats for Flight: </h1>
                    </div>
                    <div class="row date-roomtype-container">
                        <div class="col-6">
                            <div class="form-inline">
                                <label class="sr-only">Seat Type: </label><br>
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
                    </div>
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
        </main>

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
