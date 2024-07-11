package DAO;

import Model.Seat;
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

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SeatDB implements DatabaseInfo {

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

    public static Seat getSeat(String seatID) {
        Seat seat = null;
        try (Connection con = getConnect()) {
            String query = "SELECT SeatID, FlightID, SeatNumber, SeatType, IsAvailable FROM Seat WHERE SeatID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, seatID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                seat = new Seat(rs.getString("SeatID"), rs.getString("FlightID"), rs.getInt("SeatNumber"), rs.getString("SeatType"), rs.getInt("IsAvailable"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seat;
    }

    public static List<Seat> getSeatByFlight(String FlightID) {
        List<Seat> seatList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT seatID, flightID, seatNumber, seatType, IsAvailable FROM Seat WHERE FlightID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, FlightID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat(
                        rs.getString("seatID"),
                        rs.getString("flightID"),
                        rs.getInt("seatNumber"),
                        rs.getString("seatType"),
                        rs.getInt("IsAvailable")
                );
                seatList.add(seat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seatList;
    }

    public static Seat bookSeat(String seatID) {
        Seat bookedSeat = null;
        try (Connection con = getConnect()) {
            String updateQuery = "UPDATE Seat SET IsAvailable = 0 WHERE SeatID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, seatID);
                int rowsUpdated = updateStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    Logger.getLogger(RoomDB.class.getName()).log(Level.INFO, "Seat updated successfully for Seat ID: " + seatID);
                    bookedSeat = getSeat(seatID);
                } else {
                    Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "No rows updated for Seat ID: " + seatID);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error booking seat with ID: " + seatID, ex);
        }
        return bookedSeat;
    }

    public ArrayList<Seat> getAllSeats() {
        ArrayList<Seat> list = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT * FROM Seat";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Seat(rs.getString("SeatID"), rs.getString("FlightID"), rs.getInt("SeatNumber"), rs.getString("SeatType"), rs.getInt("IsAvailable")));
            }
            con.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static String BookingTicketDetail(String seatID) {
        String price = null;
        try (Connection con = getConnect()) {
            String updateQuery = "select s.SeatType from Booking_Ticket_Detail btd\n"
                    + "inner join Seat s on btd.SeatID = s.SeatID\n"
                    + "where s.SeatID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, seatID);
                ResultSet rs = updateStmt.executeQuery();
                if (rs.next()) {
                    String seatType = rs.getString("seatType");
                    if (seatType.equalsIgnoreCase("Standard")) {
                        price = "99";
                    } else if (seatType.equalsIgnoreCase("VIP")) {
                        price = "199";
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error booking room with ID: " + seatID, ex);
        }
        return price;
    }

    public static List<BookingTicketDetail> getBookingTicketDetail() {
        List<BookingTicketDetail> List = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT bookingTicketID, seatID, price, status FROM Booking_Ticket_Detail";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BookingTicketDetail room = new BookingTicketDetail(rs.getString("bookingTicketID"),
                        rs.getString("seatID"),
                        rs.getString("price"),
                        rs.getString("status"));
                List.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return List;
    }

    public static void setPrice(String seatID, String price) {
        try (Connection con = getConnect()) {
            String updateQuery = "UPDATE Booking_Ticket_Detail SET price = ? WHERE seatID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, price);
                updateStmt.setString(2, seatID);
                updateStmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error updating price for room with ID: " + seatID, ex);
        }
    }

//---------------------------------------------------------------------------
}
