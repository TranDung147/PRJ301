package DAO;

import Model.BookingRoom;
import Model.BookingRoomDetail;
import Model.BookingTicket;
import Model.BookingTicketDetail;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookingTicketDetailDB implements DatabaseInfo {

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

    public void removeBookingTicket(String bookingId) {
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Booking_Ticket_Detail WHERE BookingTicketID = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, bookingId);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingTicketDetailDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
