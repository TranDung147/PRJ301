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

    private static String generateUniqueBookingID() {
        String uniqueID = UUID.randomUUID().toString().substring(0, 6);
        return uniqueID;
    }
}
