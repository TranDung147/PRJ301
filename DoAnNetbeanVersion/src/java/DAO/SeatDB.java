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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
        System.out.println(seatID);
        String price = null;
        try (Connection con = getConnect()) {
            String updateQuery = "SELECT s.SeatType FROM Booking_Ticket_Detail btd "
                    + "INNER JOIN Seat s ON btd.SeatID = s.SeatID "
                    + "WHERE s.SeatID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, seatID);
                ResultSet rs = updateStmt.executeQuery();
                if (rs.next()) {
                    String seatType = rs.getString("SeatType"); // Đảm bảo phân biệt chữ hoa chữ thường ở đây
                    if (seatType.equalsIgnoreCase("Standard")) {
                        price = "99.99";
                    } else if (seatType.equalsIgnoreCase("VIP")) {
                        price = "199.99";
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, "Lỗi khi đặt vé với ID: " + seatID, ex);
        }
        System.out.println(price);
        return price;
    }

    public static String calculatePrice(String seatType) {
        String price = null;
        if (seatType.equalsIgnoreCase("Standard")) {
            price = "99.99";
        } else if (seatType.equalsIgnoreCase("VIP")) {
            price = "199.99";
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

    public static void insert(Seat s) {
        String sql = "INSERT INTO Seat (seatID, flightID, seatNumber, seatType, isAvailable) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, s.getSeatID());
            stmt.setString(2, s.getFlightID());
            stmt.setInt(3, s.getSeatNumber());
            stmt.setString(4, s.getSeatType());
            stmt.setInt(5, s.getIsAvailable());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, "SQL Error: " + ex.getMessage(), ex);
        } catch (Exception ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, "Error: " + ex.getMessage(), ex);
        }
    }

    public static boolean deleteSeat(String seatId) {
        boolean deleted = false;
        Connection conn = null;
        PreparedStatement deleteBookingStmt = null;
        PreparedStatement deleteSeatStmt = null;

        try {
            conn = getConnect();
            conn.setAutoCommit(false);

            String deleteBookingSQL = "DELETE FROM Booking_Ticket_Detail WHERE SeatID = ?";
            deleteBookingStmt = conn.prepareStatement(deleteBookingSQL);
            deleteBookingStmt.setString(1, seatId);
            deleteBookingStmt.executeUpdate();

            String deleteSeatSQL = "DELETE FROM Seat WHERE SeatID = ?";
            deleteSeatStmt = conn.prepareStatement(deleteSeatSQL);
            deleteSeatStmt.setString(1, seatId);
            int rowsDeleted = deleteSeatStmt.executeUpdate();

            if (rowsDeleted > 0) {
                deleted = true;
                conn.commit();
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                }
            }
        } finally {

            if (deleteBookingStmt != null) {
                try {
                    deleteBookingStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteSeatStmt != null) {
                try {
                    deleteSeatStmt.close();
                } catch (SQLException e) {
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
        return deleted;
    }

    public static boolean updateSeat(String seatID, String flightID, int seatNumber, String seatType, int isAvailable) {
        boolean success = false;
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Seat SET FlightID=?, SeatNumber=?, SeatType=?, IsAvailable=? WHERE SeatID=?")) {

            stmt.setString(1, flightID);
            stmt.setInt(2, seatNumber);
            stmt.setString(3, seatType);
            stmt.setInt(4, isAvailable);
            stmt.setString(5, seatID);

            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);

        } catch (SQLException e) {
        }
        return success;
    }

    public static Seat getSeatById(String id) {
        Seat seat = null;
        String query = "SELECT * FROM Seat WHERE SeatID = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                seat = new Seat();
                seat.setSeatID(rs.getString("SeatID"));
                seat.setFlightID(rs.getString("FlightID"));
                seat.setSeatNumber(rs.getInt("SeatNumber"));
                seat.setSeatType(rs.getString("seatType"));
                seat.setIsAvailable(rs.getInt("IsAvailable"));
            }
        } catch (SQLException e) {
        }

        return seat;
    }

    public Seat getSeatByBookingTicketID(String bookingTicketID) {
        Seat seat = null;
        String query = "SELECT s.SeatID, s.SeatNumber, s.IsAvailable "
                + "FROM Seat s "
                + "JOIN Booking_Ticket_Detail btd ON s.SeatID = btd.SeatID "
                + "WHERE btd.BookingTicketID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, bookingTicketID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                seat = new Seat();
                seat.setSeatID(rs.getString("SeatID"));
                seat.setFlightID(rs.getString("FlightID"));
                seat.setSeatNumber(rs.getInt("SeatNumber"));
                seat.setSeatType(rs.getString("seatType"));
                seat.setIsAvailable(rs.getInt("IsAvailable"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return seat;
    }

    //----------------------------------------------------------------------------
    public Map<String, Integer> countBookingTicketsBySeatType(String year) {
    Map<String, Integer> counts = new HashMap<>();
    String query = "SELECT s.SeatType, COUNT(DISTINCT bt.TicketBookingID) AS Count " +
                   "FROM Booking_Ticket_Detail btd " +
                   "JOIN Seat s ON btd.SeatID = s.SeatID " +
                   "JOIN Booking_Ticket bt ON btd.BookingTicketID = bt.TicketBookingID " +
                   "WHERE YEAR(bt.CreatedDate) = ? AND btd.Status = 'Confirmed' " +
                   "GROUP BY s.SeatType";

    try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
        stmt.setString(1, year);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            String seatType = rs.getString("SeatType");
            int count = rs.getInt("Count");
            counts.put(seatType, count);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return counts;
}

    public static Map<Integer, Map<String, Double>> getTotalPriceBySeatType(String year) {
    Map<Integer, Map<String, Double>> totalPriceBySeatTypeAndMonth = new HashMap<>();
    String query = "SELECT s.SeatType, MONTH(bt.CreatedDate) AS Month, SUM(btd.Price) AS TotalPrice " +
                   "FROM Booking_Ticket_Detail btd " +
                   "JOIN Seat s ON btd.SeatID = s.SeatID " +
                   "JOIN Booking_Ticket bt ON btd.BookingTicketID = bt.TicketBookingID " +
                   "WHERE YEAR(bt.CreatedDate) = ? AND btd.Status = 'Confirmed' " +
                   "GROUP BY s.SeatType, MONTH(bt.CreatedDate)";

    try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
        stmt.setString(1, year);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            String seatType = rs.getString("SeatType");
            int month = rs.getInt("Month");
            double totalPrice = rs.getDouble("TotalPrice");

            totalPriceBySeatTypeAndMonth
                .computeIfAbsent(month, k -> new HashMap<>())
                .put(seatType, totalPrice);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return totalPriceBySeatTypeAndMonth;
}

}
