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
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingRoom> getAllUserBookingRooms(String id) {
        List<BookingRoom> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room WHERE UserID = ? and status = ?");
            stmt.setString(1, id);
            stmt.setString(2, "None");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
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
                list.add(new BookingTicket(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingTicket> getAllUserBookingTickets(String id) {
        List<BookingTicket> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket WHERE UserID = ? and status = ?");
            stmt.setString(1, id);
            stmt.setString(2, "None");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingTicket(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
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

    public static String getTodayBookingRoomID(String userID) {
        String bookingRoomID = null;
        String getBookingRoomIDSQL = "SELECT RoomBookingID FROM Booking_Room WHERE UserID = ? AND CreatedDate = CAST(GETDATE() AS DATE)";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(getBookingRoomIDSQL)) {
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                bookingRoomID = rs.getString("RoomBookingID");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return bookingRoomID;
    }

    public static boolean updateTotalPrice(String bookingRoomID, String additionalPrice) {
        String updateTotalPriceSQL = "UPDATE Booking_Room SET TotalPrice = ISNULL(TotalPrice, 0) + ? WHERE RoomBookingID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(updateTotalPriceSQL)) {
            pstmt.setString(1, additionalPrice);
            pstmt.setString(2, bookingRoomID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
            return false;
        }
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

        return String.format("BR%04d", newID); // Định dạng thành RBxxxx
    }

    // Phương thức để chèn một booking mới vào cơ sở dữ liệu
    public static String insertBookingRoom(String userID, String totalPrice) {
        String roomBookingID = null;
        String insertBookingRoomSQL = "INSERT INTO Booking_Room (RoomBookingID, UserID, TotalPrice, CreatedDate, Status) VALUES (?, ?, ?, GETDATE(), ?)";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomSQL)) {
            // Tạo roomBookingID mới dựa trên ID hiện tại hoặc ID nhỏ nhất bị thiếu
            roomBookingID = generateNextAvailableBookingID();
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, userID);
            pstmt.setString(3, totalPrice);
            pstmt.setString(4, "None");
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
    public static String getTodayBookingSeatID(String userID) {
        String seatBookingID = null;
        String getBookingSeatIDSQL = "SELECT TicketBookingID FROM Booking_Ticket WHERE UserID = ? AND CreatedDate = CAST(GETDATE() AS DATE)";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(getBookingSeatIDSQL)) {
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                seatBookingID = rs.getString("TicketBookingID");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return seatBookingID;
    }

    public static boolean updateSeatTotalPrice(String bookingSeatID, String additionalPrice) {
        String updateTotalPriceSQL = "UPDATE Booking_Ticket SET TotalPrice = ISNULL(TotalPrice, 0) + ? WHERE TicketBookingID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(updateTotalPriceSQL)) {
            pstmt.setString(1, additionalPrice);
            pstmt.setString(2, bookingSeatID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
            return false;
        }
    }

    public static String insertBookingSeat(String userID, String totalPrice) {
        String seatBookingID = null;
        String insertBookingSeatSQL = "INSERT INTO Booking_Ticket(TicketBookingID, UserID, TotalPrice, CreatedDate, Status) VALUES (?, ?, ?, GETDATE(), ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingSeatSQL)) {
            seatBookingID = generateUniqueBookingID();
            pstmt.setString(1, seatBookingID);
            pstmt.setString(2, userID);
            pstmt.setString(3, totalPrice);
            pstmt.setString(4, "None");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error inserting booking seat: " + userID, e);
        }
        return seatBookingID;
    }

    public static boolean insertBookingTicketDetail(String bookingTicketID, String seatID, String price, String status) throws ParseException {
        String insertBookingTicketDetailSQL = "INSERT INTO Booking_Ticket_Detail (BookingTicketID, SeatID, Price, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingTicketDetailSQL)) {
            pstmt.setString(1, bookingTicketID);
            pstmt.setString(2, seatID);
            pstmt.setString(3, price);
            pstmt.setString(4, status);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> getBookingTicketIDBySeatID(String seatID) {
        List<String> bookingTicketID = new ArrayList<>();
        String query = "SELECT BookingTicketID FROM Booking_Ticket_Detail WHERE seatID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, seatID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    bookingTicketID.add(resultSet.getString("BookingTicketID"));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching BookingTicketIDs by SeatID: " + seatID, e);
        }
        return bookingTicketID;
    }

    private static String generateUniqueBookingID() {
        String uniqueID = UUID.randomUUID().toString().substring(0, 6);
        return uniqueID;
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

    //-------------------------------------------------------------------------------------------------
    // In ra tất cả các Orders ở status Pending trong adminOders.jsp - nauQ
    public List<BookingRoomDetail> getAllOrderBRD() {
        List<BookingRoomDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room_Detail WHERE status = 'Pending'");
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

    public List<BookingTicketDetail> getAllOrderBTD() {
        List<BookingTicketDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket_Detail WHERE status = 'Pending'");
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

    // Cập nhật status Order (Pending -> Confirmed/Declined) trong adminDetails.jsp - nauQ
    public boolean updateRoomOrderStatus(String orderId, String status) {
        String sql = "UPDATE Booking_Room_Detail SET Status = ? WHERE RoomBookingID = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, orderId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTicketOrderStatus(String orderId, String status) {
        String sql = "UPDATE Booking_Ticket_Detail SET Status = ? WHERE BookingTicketID = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, orderId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // In ra tất cả các Order đã được duyệt trong adminOrder.jsp vào adminOrderHistory.jsp - nauQ
    public List<BookingRoomDetail> getAllProcessedBookingRoomDetails() {
        List<BookingRoomDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room_Detail where status = 'Approved' OR status = 'Declined'");
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

    public List<BookingTicketDetail> getAllProcessedBookingTicketDetails() {
        List<BookingTicketDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket_Detail where status = 'Approved' OR status = 'Declined'");
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

    // Xóa Order trong adminOrderHistory.jsp
    public void removeBookingRoom(String bookingId) {
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Booking_Room_Detail WHERE RoomBookingID = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, bookingId);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(AllBookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeBookingTicket(String bookingId) {
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Booking_Ticket_Detail WHERE BookingTicketID = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, bookingId);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(AllBookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
