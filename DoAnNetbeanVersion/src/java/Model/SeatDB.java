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
    
    

}
