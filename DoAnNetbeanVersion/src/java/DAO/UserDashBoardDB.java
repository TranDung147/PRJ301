
package DAO;

import Model.HotelBooking;
import Model.PlaneBooking;
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
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDashBoardDB implements DatabaseInfo  {
    
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

    //order------------------------------------------------------------------------------------
    public boolean updateBookingRoomStatus(String roomBookingID, String status) {
        String query = "UPDATE Booking_Room SET Status = ? WHERE RoomBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setString(2, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateBookingRoomDetailStatus(String roomBookingID, String status) {
        String query = "UPDATE Booking_Room_Detail SET Status = ? WHERE RoomBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setString(2, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateRoomAvailability(String roomBookingID, boolean isAvailable) {
        String query = "UPDATE Room SET IsAvailable = ? WHERE RoomID IN "
                + "(SELECT RoomID FROM Booking_Room_Detail WHERE RoomBookingID = ?)";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setBoolean(1, isAvailable);
            stmt.setString(2, roomBookingID);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean createTransaction(String transactionID, String userID, String roomBookingID, String amount, String status) {
        String query = "INSERT INTO Transactions (TransactionID, UserID, RoomBookingID, TransactionDate, Amount, Status) "
                + "VALUES (?, ?, ?, GETDATE(), ?, ?)";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, transactionID);
            stmt.setString(2, userID);
            stmt.setString(3, roomBookingID);
            stmt.setString(4, amount);
            stmt.setString(5, status);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
}
