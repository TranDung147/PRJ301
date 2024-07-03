package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AllBookingDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    // Phương thức lấy tất cả các booking room từ CSDL
    public List<BookingRoom> getAllBookingRooms() {
        List<BookingRoom> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingRoomDetail> getAllBookingRoomDetails() {
        List<BookingRoomDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room_Detail");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoomDetail(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingTicket> getAllBookingTickets() {
        List<BookingTicket> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingTicket(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingTicketDetail> getAllBookingTicketDetails() {
        List<BookingTicketDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket_Detail");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingTicketDetail(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static List<BookingTicketDetail> getBookingTicketDetailsBySeatID(String seatID) {
        List<BookingTicketDetail> bookingTicketDetails = new ArrayList<>();
        String query = "SELECT BookingTicketID, SeatID, Price, Status FROM Booking_Ticket_Detail WHERE SeatID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, seatID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    BookingTicketDetail bookingTicketDetail = new BookingTicketDetail(
                            resultSet.getString("BookingTicketID"),
                            resultSet.getString("SeatID"),
                            resultSet.getString("Price"),
                            resultSet.getString("Status")
                    );
                    bookingTicketDetails.add(bookingTicketDetail);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingTicketDetail.class.getName()).log(Level.SEVERE, "Error fetching Booking Ticket Details by SeatID: " + seatID, e);
        }
        return bookingTicketDetails;
    }

    //------------------------------------------------------------------------------------------------------------------------
    // Lấy tất cả các roomBookingID hiện có từ cơ sở dữ liệu
    private static List<Integer> getExistingBookingIDs() {
        List<Integer> existingIDs = new ArrayList<>();
        String querySQL = "SELECT CAST(SUBSTRING(RoomBookingID, 3, LEN(RoomBookingID) - 2) AS INT) AS NumericID FROM Booking_Room ORDER BY NumericID";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(querySQL); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                existingIDs.add(rs.getInt("NumericID"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return existingIDs;
    }

    // Tìm ID nhỏ nhất chưa được sử dụng
    private static int findSmallestUnusedID(List<Integer> existingIDs) {
        if (existingIDs.isEmpty()) {
            return 1; // Nếu không có ID nào, bắt đầu từ 1
        }

        int expectedID = 1;
        for (int id : existingIDs) {
            if (id != expectedID) {
                return expectedID; // Trả về ID nhỏ nhất bị thiếu
            }
            expectedID++;
        }
        return expectedID; // Nếu không thiếu ID nào, trả về ID tiếp theo lớn nhất
    }

    // Tạo roomBookingID mới hoặc sử dụng ID nhỏ nhất chưa được sử dụng
    private static String generateNextAvailableBookingID() {
        List<Integer> existingIDs = getExistingBookingIDs(); // Lấy tất cả các ID hiện có
        int nextUnusedID = findSmallestUnusedID(existingIDs); // Tìm ID nhỏ nhất chưa được sử dụng
        int largestID = existingIDs.isEmpty() ? 0 : existingIDs.get(existingIDs.size() - 1); // Tìm ID lớn nhất hiện tại

        // Chọn ID nhỏ nhất chưa được sử dụng hoặc ID lớn nhất hiện tại + 1
        int newID = Math.max(nextUnusedID, largestID + 1);

        return String.format("RB%04d", newID); // Định dạng thành RBxxxx
    }

    // Phương thức để chèn một booking mới vào cơ sở dữ liệu
    public static String insertBookingRoom(String userID, String totalPrice) {
        String roomBookingID = null;
        String insertBookingRoomSQL = "INSERT INTO Booking_Room (RoomBookingID, UserID, TotalPrice, CreatedDate) VALUES (?, ?, ?, GETDATE())";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomSQL)) {
            // Tạo roomBookingID mới dựa trên ID hiện tại hoặc ID nhỏ nhất bị thiếu
            roomBookingID = generateNextAvailableBookingID();
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, userID);
            pstmt.setString(3, totalPrice);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return roomBookingID;
    }

    //---------------------------------------------------------------------------------------------------
    public static boolean insertBookingRoomDetail(String roomBookingID, String roomID, String price, String dateFrom, String dateTo, String status) {
        String insertBookingRoomDetailSQL = "INSERT INTO Booking_Room_Detail (RoomBookingID, RoomID, Price, DateFrom, DateTo, Status) VALUES (?, ?, ?, ?, ?, ?)";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomDetailSQL)) {
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, roomID);
            pstmt.setString(3, price);
            pstmt.setString(4, dateFrom);
            pstmt.setString(5, dateTo);

//            // Chuyển đổi chuỗi ngày thành java.sql.Timestamp
//            java.sql.Timestamp fromTimestamp = new java.sql.Timestamp(sdf.parse(dateFrom).getTime());
//            java.sql.Timestamp toTimestamp = new java.sql.Timestamp(sdf.parse(dateTo).getTime());
//            pstmt.setTimestamp(4, fromTimestamp);
//            pstmt.setTimestamp(5, toTimestamp);
            pstmt.setString(6, status);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace(); // In ra stack trace khi xảy ra lỗi SQL
            return false;
        }
//        } catch (ParseException e) {
//            e.printStackTrace(); // In ra stack trace khi xảy ra lỗi phân tích cú pháp
//            return false;
//        }
    }

    public List<java.sql.Date[]> getDateFromToDateByRoomBookingID(String roomBookingID) {
        List<java.sql.Date[]> dateRanges = new ArrayList<>();
        String query = "SELECT DateFrom, DateTo FROM Booking_Room_Detail WHERE RoomBookingID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, roomBookingID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    java.sql.Date dateFrom = resultSet.getDate("DateFrom");
                    java.sql.Date dateTo = resultSet.getDate("DateTo");
                    java.sql.Date[] dates = {dateFrom, dateTo};
                    dateRanges.add(dates);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching date ranges by RoomBookingID: " + roomBookingID, e);
        }
        return dateRanges;
    }

    public List<String> getRoomBookingIDsByRoomID(String roomID) {
        List<String> roomBookingIDs = new ArrayList<>();
        String query = "SELECT RoomBookingID FROM Booking_Room_Detail WHERE RoomID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, roomID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    roomBookingIDs.add(resultSet.getString("RoomBookingID"));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching RoomBookingIDs by RoomID: " + roomID, e);
        }
        return roomBookingIDs;
    }

    //--------------------------------------------------------------------------------------------------------
    // Lấy danh sách các đơn đặt phòng khách sạn
    public List<HotelBooking> getAllHotelBookings(String id) {
        List<HotelBooking> bookings = new ArrayList<>();
        String query = "SELECT br.RoomBookingID, u.Username, h.HotelName, h.HotelAddress, r.RoomNumber, "
                + "r.RoomType, brd.Price, brd.DateFrom, brd.DateTo, brd.Status "
                + "FROM Booking_Room br "
                + "JOIN Booking_Room_Detail brd ON br.RoomBookingID = brd.RoomBookingID "
                + "JOIN Room r ON brd.RoomID = r.RoomID "
                + "JOIN Hotel h ON r.HotelID = h.HotelID "
                + "JOIN Users u ON br.UserID = u.UserID "
                + "WHERE u.UserID = ? "
                + "ORDER BY br.CreatedDate DESC";

        try (Connection connection = getConnect(); PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HotelBooking booking = new HotelBooking();
                    booking.setHotelName(rs.getString("HotelName"));
                    booking.setHotelAddress(rs.getString("HotelAddress"));
                    booking.setRoomNumber(rs.getString("RoomNumber"));
                    booking.setRoomType(rs.getString("RoomType"));
                    booking.setPrice(rs.getDouble("Price"));
                    booking.setDateFrom(rs.getString("DateFrom"));
                    booking.setDateTo(rs.getString("DateTo"));
                    booking.setStatus(rs.getString("Status"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Lấy danh sách các đơn đặt vé máy bay
    public List<PlaneBooking> getAllPlaneBookings(String id) {
        List<PlaneBooking> bookings = new ArrayList<>();
        String query = "SELECT bt.TicketBookingID, u.Username, p.PlaneName, f.DepartureCity, f.ArrivalCity, "
                + "f.DateStart, f.DateEnd, s.SeatNumber, s.SeatType, btd.Price, btd.Status "
                + "FROM Booking_Ticket bt "
                + "JOIN Booking_Ticket_Detail btd ON bt.TicketBookingID = btd.BookingTicketID "
                + "JOIN Seat s ON btd.SeatID = s.SeatID "
                + "JOIN Flight f ON s.FlightID = f.FlightID "
                + "JOIN Plane p ON f.PlaneID = p.PlaneID "
                + "JOIN Users u ON bt.UserID = u.UserID "
                + "WHERE u.UserID = ? "
                + "ORDER BY bt.CreatedDate DESC";

        try (Connection connection = getConnect(); PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PlaneBooking booking = new PlaneBooking();
                    booking.setPlaneName(rs.getString("PlaneName"));
                    booking.setStartTime(rs.getString("DateStart"));
                    booking.setLocationFrom(rs.getString("DepartureCity"));
                    booking.setLocationTo(rs.getString("ArrivalCity"));
                    booking.setSeatNumber(rs.getString("SeatNumber"));
                    booking.setSeatType(rs.getString("SeatType"));
                    booking.setPrice(rs.getDouble("Price"));
                    booking.setStatus(rs.getString("Status"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    //-------------------------------------------------------------------------------------
    
    public static List<BookingRoomDetail> getRoomOrders() throws SQLException {
        List<BookingRoomDetail> roomOrders = new ArrayList<>();

        try (Connection connection = getConnect()) {
            String roomOrderSql = "SELECT * FROM Booking_Room_Detail";
            PreparedStatement roomOrderPs = connection.prepareStatement(roomOrderSql);
            ResultSet roomOrderRs = roomOrderPs.executeQuery();
            while (roomOrderRs.next()) {
                BookingRoomDetail roomOrder = new BookingRoomDetail(
                        roomOrderRs.getString("RoomBookingID"),
                        roomOrderRs.getString("RoomID"),
                        roomOrderRs.getString("Price"),
                        roomOrderRs.getString("DateFrom"),
                        roomOrderRs.getString("DateTo"),
                        roomOrderRs.getString("Status")
                );
                roomOrders.add(roomOrder);
            }
        }

        return roomOrders;
    }

    public static List<BookingTicketDetail> getTicketOrders() throws SQLException {
        List<BookingTicketDetail> ticketOrders = new ArrayList<>();

        try (Connection connection = getConnect()) {
            String ticketOrderSql = "SELECT * FROM Booking_Ticket_Detail";
            PreparedStatement ticketOrderPs = connection.prepareStatement(ticketOrderSql);
            ResultSet ticketOrderRs = ticketOrderPs.executeQuery();
            while (ticketOrderRs.next()) {
                BookingTicketDetail ticketOrder = new BookingTicketDetail(
                        ticketOrderRs.getString("BookingTicketID"),
                        ticketOrderRs.getString("SeatID"),
                        ticketOrderRs.getString("Price"),
                        ticketOrderRs.getString("Status")
                );
                ticketOrders.add(ticketOrder);
            }
        }

        return ticketOrders;
    }

}
