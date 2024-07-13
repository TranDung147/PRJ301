/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Transaction;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import Model.HotelBooking;
import Model.PlaneBooking;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author NOMNOM
 */
public class TransactionDB implements DatabaseInfo{
    
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
    
    public List<Transaction> getAllUserTransactions(String id) {
        List<Transaction> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Transactions WHERE UserID = ?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Transaction(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                rs.getString(6),rs.getString(7)));
            }
            con.close();
            return list;
            
        } catch (Exception ex) {
            
        }
        return null;
    }
    
    public boolean insertTransaction(String transactionID, String userID, String roomBookingID, String amount, String status) {
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
            java.util.logging.Logger.getLogger(TransactionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean deleteTransactionByID(String tranID) {
        boolean success = false;

        try (Connection con = getConnect(); PreparedStatement stmt
                = con.prepareStatement("DELETE FROM Transactions WHERE TransactionID = ?")) {

            stmt.setString(1, tranID);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDashBoardDB.class.getName()).log(Level.SEVERE, "Error deleting room booking with ID: " + tranID, ex);
        }

        return success;
    }
    
    //---------------
    // In ra tất cả các Transactions ở status Pending trong adminOders.jsp - nauQ
    public List<Transaction> getAllTransactions() {
        List<Transaction> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Transactions WHERE status = 'Pending'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Transaction(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Cập nhật status Transaction (Pending -> Confirmed) trong adminDetails.jsp - nauQ
    public void updateTransactionStatus(String transactionId, String status) {
        try (Connection con = getConnect()) {
            String sql = "UPDATE Transactions SET Status = ? WHERE TransactionID = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setString(2, transactionId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // In ra tất cả các Transaction đã được duyệt trong adminOrder.jsp vào adminOrderHistory.jsp - nauQ
    public List<Transaction> getApprovedTransactions() {
        List<Transaction> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Transactions WHERE status = 'Approved'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Transaction(rs.getString("TransactionID"), rs.getString("UserID"), rs.getString("RoomBookingID"), rs.getString("TicketBookingID"), rs.getString("TransactionDate"), rs.getString("Amount"), rs.getString("Status")));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Xóa Transaction trong adminOrderHistory.jsp - nauQ
    public void removeTransaction(String transactionId, String roomBookingId, String ticketBookingID) {
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Transactions WHERE transactionId = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, transactionId);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(TransactionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Lấy đặt phòng khách sạn theo TransactionID - nauQ
    public List<HotelBooking> getHotelBookingsByTransactionId(String transactionId) {
        List<HotelBooking> bookings = new ArrayList<>();
        String query = "SELECT h.HotelName, h.HotelAddress, r.RoomNumber, r.RoomType, brd.Price, brd.DateFrom, brd.DateTo, brd.Status\n"
                + "FROM Transactions t LEFT JOIN Booking_Room br ON t.RoomBookingID = br.RoomBookingID "
                + "LEFT JOIN Booking_Room_Detail brd ON br.RoomBookingID = brd.RoomBookingID "
                + "LEFT JOIN Room r ON brd.RoomID = r.RoomID "
                + "LEFT JOIN Hotel h ON r.HotelID = h.HotelID\n"
                + "WHERE t.TransactionID = ?;";

        try (Connection connection = getConnect(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, transactionId);
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

    // Lấy đặt vé máy bay theo TransactionID - nauQ
    public List<PlaneBooking> getPlaneBookingsByTransactionId(String transactionId) {
        List<PlaneBooking> bookings = new ArrayList<>();
        String query = "SELECT\n"
                + "    p.planeName,\n"
                + "    f.dateStart,\n"
                + "    f.departureCity,\n"
                + "    f.arrivalCity,\n"
                + "    s.seatNumber,\n"
                + "    s.seatType,\n"
                + "    bt.totalPrice,\n"
                + "    t.status\n"
                + "FROM Transactions t\n"
                + "JOIN Booking_Ticket bt ON t.TicketBookingID = bt.TicketBookingID\n"
                + "JOIN Booking_Ticket_Detail btd ON bt.TicketBookingID = btd.BookingTicketID\n"
                + "JOIN Seat s ON btd.SeatID = s.SeatID\n"
                + "JOIN Flight f ON s.FlightID = f.FlightID\n"
                + "JOIN Plane p ON f.planeID = p.planeID\n"
                + "WHERE t.TransactionID = ?;";

        try (Connection connection = getConnect(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, transactionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PlaneBooking booking = new PlaneBooking();
                    booking.setPlaneName(rs.getString("PlaneName"));
                    booking.setStartTime(rs.getString("DateStart"));
                    booking.setLocationFrom(rs.getString("DepartureCity"));
                    booking.setLocationTo(rs.getString("ArrivalCity"));
                    booking.setSeatNumber(rs.getString("SeatNumber"));
                    booking.setSeatType(rs.getString("SeatType"));
                    booking.setPrice(rs.getDouble("totalPrice"));
                    booking.setStatus(rs.getString("Status"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Main method to test getPlaneBookingsByTransactionId() and getPlaneBookingsByTransactionId() - nauQ
    public static void main(String[] args) {
        TransactionDB a = new TransactionDB();

        String transactionId = "TR0003";
        
        List<HotelBooking> hotelBookingsByTransaction = a.getHotelBookingsByTransactionId(transactionId);
        System.out.println("Hotel Bookings by Transaction ID:");
        for (HotelBooking booking : hotelBookingsByTransaction) {
            System.out.println("Hotel Name: " + booking.getHotelName());
            System.out.println("Hotel Address: " + booking.getHotelAddress());
            System.out.println("Room Number: " + booking.getRoomNumber());
            System.out.println("Room Type: " + booking.getRoomType());
            System.out.println("Price: " + booking.getPrice());
            System.out.println("Date From: " + booking.getDateFrom());
            System.out.println("Date To: " + booking.getDateTo());
            System.out.println("Status: " + booking.getStatus());
            System.out.println();
        }

        // Test getPlaneBookingsByTransactionId method
        List<PlaneBooking> planeBookingsByTransaction = a.getPlaneBookingsByTransactionId(transactionId);
        System.out.println("Plane Bookings by Transaction ID:");
        for (PlaneBooking booking : planeBookingsByTransaction) {
            System.out.println("Plane Name: " + booking.getPlaneName());
            System.out.println("Start Time: " + booking.getStartTime());
            System.out.println("Location From: " + booking.getLocationFrom());
            System.out.println("Location To: " + booking.getLocationTo());
            System.out.println("Seat Number: " + booking.getSeatNumber());
            System.out.println("Seat Type: " + booking.getSeatType());
            System.out.println("Price: " + booking.getPrice());
            System.out.println("Status: " + booking.getStatus());
            System.out.println();
        }
    }
    
}
