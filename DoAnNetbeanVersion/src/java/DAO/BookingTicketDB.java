package DAO;

import Model.BookingTicket;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookingTicketDB implements DatabaseInfo {

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

    public BookingTicket getBookingTicketByBookingTicketID(String bookingTicketID) {
        BookingTicket bookingTicket = null;
        String query = "SELECT TicketBookingID, UserID, TotalPrice, CreatedDate, Status "
                + "FROM Booking_Ticket "
                + "WHERE TicketBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, bookingTicketID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bookingTicket = new BookingTicket();
                bookingTicket.setTicketBookingID(rs.getString("TicketBookingID"));
                bookingTicket.setUserID(rs.getString("UserID"));
                bookingTicket.setTotalPrice(rs.getString("TotalPrice"));
                bookingTicket.setCreatedDate(rs.getString("CreatedDate"));
                bookingTicket.setStatus(rs.getString("Status"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return bookingTicket;
    }

    //--------------------------------------------------------------------------------------------------------
    public static String getTodayBookingSeatID(String userID) {
        String seatBookingID = null;
        String getBookingSeatIDSQL = "SELECT TicketBookingID FROM Booking_Ticket WHERE UserID = ? AND Status = 'None' AND CreatedDate = CAST(GETDATE() AS DATE)";

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

    public BookingTicket getTodayAvailableBookingSeat(String id) {
        BookingTicket bt = new BookingTicket();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT TOP 1 * FROM Booking_Ticket WHERE status != 'None' and UserID = ? order by TicketBookingID DESC");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bt = new BookingTicket(
                        rs.getString("TicketBookingID"), // or rs.getString(1)
                        rs.getString("UserID"), // or rs.getString(2)
                        rs.getString("TotalPrice"), // or rs.getString(3)
                        rs.getString("CreatedDate"), // or rs.getString(4)
                        rs.getString("Status") // or rs.getString(5)
                );
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingTicketDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bt;
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

    public String insertBookingSeat(String userID, String totalPrice) {
        String seatBookingID = null;
        System.out.println(totalPrice);
        String insertBookingSeatSQL = "INSERT INTO Booking_Ticket(TicketBookingID, UserID, TotalPrice, CreatedDate, Status) VALUES (?, ?, ?, GETDATE(), ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingSeatSQL)) {
            seatBookingID = generateNewBTID(conn);
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
    
    private String generateNewBTID(Connection con) throws SQLException {
        String query = "SELECT MAX(TicketBookingID) AS maxID FROM Booking_Ticket";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String maxID = rs.getString("maxID");
                if (maxID != null) {
                    int id = Integer.parseInt(maxID.substring(2)) + 1;
                    return String.format("BT%04d", id);
                }
            }
        }
        return "TR0001";
    }
}
