<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.*" %>

<html>
<head>
    <title>Room List</title>
    <style>
        .bodyroom{
                
            margin-bottom:20px;
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
        /* Style cho các phòng */
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
            background-color: #d4edda; /* Màu xanh cho Available */
        }
        .room-not-available {
            background-color: #f8d7da; /* Màu đỏ cho Not Available */
        }
        .room:hover {
            background-color: #e2e6ea;
        }
        /* Style cho khung chứa các phòng */
        .room-container {
            border: 2px solid #007bff;
            padding: 15px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        /* Style cho nút Book */
        .btn-book {
            background-color: #28a745;
            color: white;
        }
        .btn-book:hover {
            background-color: #218838;
        }
    </style>
    <!-- Bootstrap CSS -->
 
</head>
<body class="bodyroom">
    <div class="container">
        <!-- Phần trên cùng -->
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
        
        <!-- Phần dưới -->
        <div class="room-container mt-3">
            <div class="row">
                <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                if (rooms != null) {
                    for (Room room : rooms) {
                        String roomClass = (room.getIsAvailable() == 1) ? "room-available" : "room-not-available";
                %>
                <div class="col-md-2 mb-3">
                    <div class="room <%= roomClass %>" data-toggle="modal" data-target="#roomModal<%= room.getRoomID() %>">
                        <%= room.getRoomNumber() %>
                    </div>
                </div>
                <!-- Modal for room details -->
                <div class="modal fade" id="roomModal<%= room.getRoomID() %>" tabindex="-1" role="dialog" aria-labelledby="roomModalLabel<%= room.getRoomID() %>" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="roomModalLabel<%= room.getRoomID() %>">Room Details - <%= room.getRoomNumber() %></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Type: <%= room.getRoomType() %></p>
                                <p>Availability: <%= (room.getIsAvailable() == 1) ? "Available" : "Not Available" %></p>
                                <!-- Thêm thông tin chi tiết khác nếu cần -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <% if (room.getIsAvailable() == 1) { %>
                                    <button type="button" class="btn btn-book" onclick="bookRoom(<%= room.getRoomID() %>)">Book</button>
                                <% } else { %>
                                    <button type="button" class="btn btn-book" disabled>Book</button>
                                <% } %>
                            </div>
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

    <!-- Bootstrap JS và các dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function bookRoom(roomID) {
            // Hàm này sẽ được gọi khi nút "Book" được nhấn
            // Bạn có thể thêm logic xử lý đặt phòng tại đây
            alert('Booking room: ' + roomID);
            // Ví dụ: Bạn có thể thực hiện một yêu cầu AJAX để xử lý đặt phòng trên server
        }
    </script>
</body>
</html>
