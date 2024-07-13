package DAO;

import Model.HotelBooking;
import Model.PlaneBooking;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import Model.BookingRoom;
import Model.BookingRoomDetail;
import Model.BookingTicket;
import Model.BookingTicketDetail;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDashBoardDB implements DatabaseInfo {

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

    //BookingServlet function-User-Cart --------------------------------------------------------------------------------------
    //View------------------------------------------------------------------------------------
    public List<HotelBooking> getAllHotelBookings(String id) {
        List<HotelBooking> bookings = new ArrayList<>();
        String query = "SELECT br.RoomBookingID, u.Username, h.HotelName, h.HotelAddress, r.RoomNumber, "
                + "r.RoomType, brd.Price, brd.DateFrom, brd.DateTo, brd.Status "
                + "FROM Booking_Room br "
                + "JOIN Booking_Room_Detail brd ON br.RoomBookingID = brd.RoomBookingID "
                + "JOIN Room r ON brd.RoomID = r.RoomID "
                + "JOIN Hotel h ON r.HotelID = h.HotelID "
                + "JOIN Users u ON br.UserID = u.UserID "
                // + "WHERE u.UserID = ? "
                + "WHERE br.RoomBookingID = ? "
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
                // + "WHERE u.UserID = ? "
                + "WHERE bt.TicketBookingID = ? "
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

    //delete------------------------------------------------------------------------------------
    public boolean deleteRoomBookingDetailByID(String roomBookingID) {
        boolean success = false;

        try (Connection con = getConnect(); PreparedStatement stmt
                = con.prepareStatement("DELETE FROM Booking_Room_Detail WHERE RoomBookingID = ?")) {

            stmt.setString(1, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with ID: " + roomBookingID, ex);
        }

        return success;
    }

    public boolean deleteRoomBookingByID(String roomBookingID) {
        boolean success = false;

        try (Connection con = getConnect(); PreparedStatement stmt
                = con.prepareStatement("DELETE FROM Booking_Room WHERE RoomBookingID = ?")) {

            stmt.setString(1, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with ID: " + roomBookingID, ex);
        }

        return success;
    }

    public boolean deleteTicketBookingDetailByID(String ticketBookingID) {
        boolean success = false;

        try (Connection con = getConnect(); PreparedStatement stmt
                = con.prepareStatement("DELETE FROM Booking_Ticket_Detail WHERE BookingTicketID = ?")) {

            stmt.setString(1, ticketBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with ID: " + ticketBookingID, ex);
        }

        return success;
    }

    public boolean deleteTicketBookingByID(String ticketBookingID) {
        boolean success = false;

        try (Connection con = getConnect(); PreparedStatement stmt
                = con.prepareStatement("DELETE FROM Booking_Ticket WHERE TicketBookingID = ?")) {

            stmt.setString(1, ticketBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with ID: " + ticketBookingID, ex);
        }

        return success;
    }
    
    public boolean updateSeatAvailabilityToTrue(String ticketBookingID) {
        boolean success = false;
        String query = "UPDATE Seat SET IsAvailable = 'True' WHERE SeatID IN "
                + "(SELECT SeatID FROM Booking_Ticket_Detail WHERE BookingTicketID = ?)";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, ticketBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }

    //order------------------------------------------------------------------------------------
    public boolean updateBookingRoomStatus(String roomBookingID) {
        boolean success = false;
        String query = "UPDATE Booking_Room SET Status = 'Pending' WHERE RoomBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }

    public boolean updateBookingRoomDetailStatus(String roomBookingID) {
        boolean success = false;
        String query = "UPDATE Booking_Room_Detail SET Status = 'Confirmed' WHERE RoomBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }

    public boolean updateBookingTicketStatus(String ticketBookingID) {
        boolean success = false;
        String query = "UPDATE Booking_Ticket SET Status = 'Pending' WHERE TicketBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, ticketBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }

    public boolean updateBookingTicketDetailStatus(String roomBookingID) {
        boolean success = false;
        String query = "UPDATE Booking_Ticket_Detail SET Status = 'Confirmed' WHERE BookingTicketID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }

    public boolean updateSeatAvailability(String ticketBookingID) {
        boolean success = false;
        String query = "UPDATE Seat SET IsAvailable = 'False' WHERE SeatID IN "
                + "(SELECT SeatID FROM Booking_Ticket_Detail WHERE BookingTicketID = ?)";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, ticketBookingID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
    }

    //deleteRoomDetail------------------------------------------------------------------------------------ 
    public BookingRoomDetail deleteRoomDetailByNumber(String roomNumber, String userId) {
        BookingRoomDetail bookingRoomDetail = null;

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(
                "SELECT brd.* "
                + "FROM Booking_Room_Detail brd "
                + "JOIN Booking_Room br ON brd.RoomBookingID = br.RoomBookingID "
                + "JOIN Room r ON r.RoomID = brd.RoomID "
                + "WHERE r.RoomNumber = ? AND br.UserID = ?")) {

            stmt.setString(1, roomNumber);
            stmt.setString(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bookingRoomDetail = new BookingRoomDetail();
                    bookingRoomDetail.setRoomBookingID(rs.getString("RoomBookingID"));
                    bookingRoomDetail.setRoomID(rs.getString("RoomID"));
                    bookingRoomDetail.setPrice(rs.getString("Price"));
                    bookingRoomDetail.setDateFrom(rs.getString("DateFrom"));
                    bookingRoomDetail.setDateTo(rs.getString("DateTo"));
                    bookingRoomDetail.setStatus(rs.getString("Status"));
                }
            }

            if (bookingRoomDetail != null) {
                try (PreparedStatement deleteStmt = con.prepareStatement(
                        "DELETE FROM Booking_Room_Detail "
                        + "WHERE RoomBookingID IN ("
                        + "    SELECT brd.RoomBookingID "
                        + "    FROM Booking_Room_Detail brd "
                        + "    JOIN Booking_Room br ON brd.RoomBookingID = br.RoomBookingID "
                        + "    JOIN Room r ON r.RoomID = brd.RoomID "
                        + "    WHERE r.RoomNumber = ? AND br.UserID = ?"
                        + ")"
                        + "AND RoomID IN ("
                        + "    SELECT r.RoomID"
                        + "    FROM Room r"
                        + "    WHERE r.RoomNumber = ?"
                        + ")")) {

                    deleteStmt.setString(1, roomNumber);
                    deleteStmt.setString(2, userId);
                    deleteStmt.setString(3, roomNumber);

                    int rowsAffected = deleteStmt.executeUpdate();
                    if (rowsAffected == 0) {
                        bookingRoomDetail = null; // Không có hàng nào bị xóa, giá trị price không hợp lệ
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with room number: " + roomNumber + " and user ID: " + userId, ex);
        }

        return bookingRoomDetail;
    }

    public BookingRoom getBookingRoomById(String roomBookingID) {
        BookingRoom bookingRoom = null;

        String query = "SELECT RoomBookingID, UserID, TotalPrice, CreatedDate, Status "
                + "FROM Booking_Room "
                + "WHERE RoomBookingID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, roomBookingID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bookingRoom = new BookingRoom();
                    bookingRoom.setRoomBookingID(rs.getString("RoomBookingID"));
                    bookingRoom.setUserID(rs.getString("UserID"));
                    bookingRoom.setTotalPrice(rs.getString("TotalPrice"));
                    bookingRoom.setCreatedDate(rs.getString("CreatedDate"));
                    bookingRoom.setStatus(rs.getString("Status"));
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error getting booking room with ID: " + roomBookingID, ex);
        }

        return bookingRoom;
    }

    public static boolean updatePriceBRoomAfterDeleteBRoomDetail(String bookingRoomID, String additionalPrice) {
        String updateTotalPriceSQL = "UPDATE Booking_Room SET TotalPrice = ? WHERE RoomBookingID = ?";

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

    //deleteTicketDetail------------------------------------------------------------------------------------ 
    public BookingTicketDetail deleteTicketDetailByNumber(String seatNumber, String userId) {
        BookingTicketDetail bookingTicketDetail = null;

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(
                "SELECT btd.* "
                + "FROM Booking_Ticket_Detail btd "
                + "JOIN Booking_Ticket bt ON btd.BookingTicketID = bt.TicketBookingID "
                + "JOIN Seat s ON s.SeatID = btd.SeatID "
                + "WHERE s.SeatNumber = ? AND bt.UserID = ?")) {

            stmt.setString(1, seatNumber);
            stmt.setString(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bookingTicketDetail = new BookingTicketDetail();
                    bookingTicketDetail.setBookingTicketID(rs.getString("BookingTicketID"));
                    bookingTicketDetail.setSeatID(rs.getString("SeatID"));
                    bookingTicketDetail.setPrice(rs.getString("Price"));
                    bookingTicketDetail.setStatus(rs.getString("Status"));
                }
            }

            if (bookingTicketDetail != null) {
                try (PreparedStatement deleteStmt = con.prepareStatement(
                        "DELETE FROM Booking_Ticket_Detail "
                        + "WHERE BookingTicketID IN ("
                        + "    SELECT btd.BookingTicketID "
                        + "    FROM Booking_Ticket_Detail btd "
                        + "    JOIN Booking_Ticket bt ON btd.BookingTicketID = bt.TicketBookingID "
                        + "    JOIN Seat s ON s.SeatID = btd.SeatID"
                        + "    WHERE s.SeatNumber = ? AND bt.UserID = ?"
                        + ")"
                        + "AND SeatID IN ("
                        + "    SELECT s.SeatID"
                        + "    FROM Seat s"
                        + "    WHERE s.SeatNumber = ?"
                        + ");")) {

                    deleteStmt.setString(1, seatNumber);
                    deleteStmt.setString(2, userId);
                    deleteStmt.setString(3, seatNumber);

                    int rowsAffected = deleteStmt.executeUpdate();
                    if (rowsAffected == 0) {
                        bookingTicketDetail = null; // Không có hàng nào bị xóa, giá trị price không hợp lệ
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with seat number: " + seatNumber + " and user ID: " + userId, ex);
        }

        return bookingTicketDetail;
    }

    public BookingTicket getBookingTicketById(String ticketBookingID) {
        BookingTicket bookingTicket = null;

        String query = "SELECT TicketBookingID, UserID, TotalPrice, CreatedDate, Status "
                + "FROM Booking_Ticket "
                + "WHERE TicketBookingID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, ticketBookingID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bookingTicket = new BookingTicket();
                    bookingTicket.setTicketBookingID(rs.getString("TicketBookingID"));
                    bookingTicket.setUserID(rs.getString("UserID"));
                    bookingTicket.setTotalPrice(rs.getString("TotalPrice"));
                    bookingTicket.setCreatedDate(rs.getString("CreatedDate"));
                    bookingTicket.setStatus(rs.getString("Status"));
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error getting booking ticket with ID: " + ticketBookingID, ex);
        }

        return bookingTicket;
    }

    public static boolean updatePriceBTicketAfterDeleteBTicketDetail(String bookingTicketID, String additionalPrice) {
        String updateTotalPriceSQL = "UPDATE Booking_Ticket SET TotalPrice = ? WHERE TicketBookingID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(updateTotalPriceSQL)) {
            pstmt.setString(1, additionalPrice);
            pstmt.setString(2, bookingTicketID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
            return false;
        }
    }

    //Insert Ticket into Transaction-----------------------------------------------------------------------------------------------
    public boolean insertTranTicket(String userID, String bookingTicketID, String price) {
        try (Connection con = getConnect()) {
            String transactionID = checkPendingTransaction(con, userID);
            if (transactionID == null) {
                transactionID = createNewTransaction(con, userID, bookingTicketID, price);
            } else {
                boolean ticketExists = checkBookingTicketInTransaction(con, transactionID, bookingTicketID);
                if (ticketExists) {
                    transactionID = createNewTransaction(con, userID, bookingTicketID, price);
                } else {
                    updateTransaction(con, transactionID, bookingTicketID, price);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return true;
    }

    private String checkPendingTransaction(Connection con, String userID) throws SQLException {
        String query = "SELECT TransactionID FROM Transactions WHERE UserID = ? AND Status = 'Pending' AND TransactionDate = CONVERT(DATE, GETDATE())";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("checkPendingTransaction");
                return rs.getString("TransactionID");
            }
        }
        return null;
    }

    private boolean checkBookingTicketInTransaction(Connection con, String transactionID, String bookingTicketID) throws SQLException {
        String query = "SELECT 1 FROM Transactions WHERE TransactionID = ? AND TicketBookingID = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, transactionID);
            stmt.setString(2, bookingTicketID);
            ResultSet rs = stmt.executeQuery();
            System.out.println("checkBookingTicketInTransaction");
            return rs.next();
        }
    }

    private String createNewTransaction(Connection con, String userID, String bookingTicketID, String price) throws SQLException {
        String transactionID = generateNewTransactionID(con);
        String query = "INSERT INTO Transactions (TransactionID, UserID, TicketBookingID, TransactionDate, Status, Amount) VALUES ( ?, ?, ?, CONVERT(DATE, GETDATE()), 'Pending', ?)";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, transactionID);
            stmt.setString(2, userID);
            stmt.setString(3, bookingTicketID);
            stmt.setString(4, price);
            stmt.executeUpdate();
        }
        return transactionID;
    }

    private void updateTransaction(Connection con, String transactionID, String bookingTicketID, String price) throws SQLException {
        String query = "UPDATE Transactions SET TicketBookingID = ?, Amount = Amount + ? WHERE TransactionID = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, bookingTicketID);
            stmt.setString(3, transactionID);
            stmt.setString(2, price);
            stmt.executeUpdate();
        }
        System.out.println("updateTransaction");
    }

    private String generateNewTransactionID(Connection con) throws SQLException {
        String query = "SELECT MAX(TransactionID) AS maxID FROM Transactions";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String maxID = rs.getString("maxID");
                if (maxID != null) {
                    int id = Integer.parseInt(maxID.substring(2)) + 1;
                    return String.format("TR%04d", id);
                }
            }
        }
        return "TR0001";
    }

    //Insert Room into Transaction-----------------------------------------------------------------------------------------------
    public boolean insertTranRoom(String userID, String roomBookingID, String totalPrice) {
        try (Connection con = getConnect()) {
            String transactionID = checkPendingTransaction(con, userID);
            if (transactionID == null) {
                transactionID = createNewTransaction(con, userID, roomBookingID, totalPrice, "Room");
            } else {
                boolean roomExists = checkRoomBookingInTransaction(con, transactionID, roomBookingID);
                if (roomExists) {
                    transactionID = createNewTransaction(con, userID, roomBookingID, totalPrice, "Room");
                } else {
                    updateTransaction(con, transactionID, roomBookingID, totalPrice, "Room");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return true;
    }

    private boolean checkRoomBookingInTransaction(Connection con, String transactionID, String roomBookingID) throws SQLException {
        String query = "SELECT 1 FROM Transactions WHERE TransactionID = ? AND RoomBookingID = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, transactionID);
            stmt.setString(2, roomBookingID);
            ResultSet rs = stmt.executeQuery();
            System.out.println("checkRoomBookingInTransaction");
            return rs.next();
        }
    }

    private String createNewTransaction(Connection con, String userID, String bookingID, String totalPrice, String type) throws SQLException {
        String transactionID = generateNewTransactionID(con);
        String query = "INSERT INTO Transactions (TransactionID, UserID, RoomBookingID, TransactionDate, Status, Amount) VALUES (?, ?, ?, CAST(GETDATE() AS DATE), 'Pending', ?)";
        if (type.equals("Ticket")) {
            query = "INSERT INTO Transactions (TransactionID, UserID, TicketBookingID, TransactionDate, Status, Amount) VALUES (?, ?, ?, CAST(GETDATE() AS DATE), 'Pending', ?)";
        }
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, transactionID);
            stmt.setString(2, userID);
            stmt.setString(3, bookingID);
            stmt.setString(4, totalPrice);
            stmt.executeUpdate();
        }
        return transactionID;
    }

    private void updateTransaction(Connection con, String transactionID, String bookingID, String price, String type) throws SQLException {
        String query = "UPDATE Transactions SET RoomBookingID = ?, Amount = Amount + ? WHERE TransactionID = ?";
        if (type.equals("Ticket")) {
            query = "UPDATE Transactions SET TicketBookingID = ?, Amount = Amount + ? WHERE TransactionID = ?";
        }
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, bookingID);
            stmt.setString(3, transactionID);
            stmt.setString(2, price);
            stmt.executeUpdate();
        }
        System.out.println("updateTransaction");
    }

}
