package DAO;

import Model.Room;
import Model.BookingRoomDetail;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;

import java.util.logging.Level;
import java.util.logging.Logger;

public class RoomDB implements DatabaseInfo {

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

    // Method to get room details by RoomID
    public static Room getRoom(String roomID) {
        Room room = null;
        try (Connection con = getConnect()) {
            String query = "SELECT RoomID, RoomNumber, RoomType, IsAvailable FROM Room WHERE RoomID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                room = new Room(rs.getString("RoomID"), rs.getInt("RoomNumber"), rs.getString("RoomType"), rs.getInt("IsAvailable"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }

    // Method to get room details by RoomID
    public ArrayList<Room> getAllRooms() {
        ArrayList<Room> list = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT * FROM Room";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getString("RoomID"), rs.getString("HotelID"), rs.getInt("RoomNumber"), rs.getString("RoomType"), rs.getInt("capacity"), rs.getInt("IsAvailable")));
            }
            con.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static Room bookRoom(String roomID) {
        Room bookedRoom = null;
        try (Connection con = getConnect()) {
            String updateQuery = "UPDATE Room SET IsAvailable = 0 WHERE RoomID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, roomID);
                int rowsUpdated = updateStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    Logger.getLogger(RoomDB.class.getName()).log(Level.INFO, "Room updated successfully for Room ID: " + roomID);
                    bookedRoom = getRoom(roomID); // Lấy thông tin phòng sau khi đã book thành công
                } else {
                    Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "No rows updated for Room ID: " + roomID);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error booking room with ID: " + roomID, ex);
        }
        return bookedRoom;
    }

//    public static List<Room> getAvailableRooms(String roomType) {
//        List<Room> roomList = new ArrayList<>();
//        try (Connection con = getConnect()) {
//            String query = "SELECT RoomID, RoomNumber, RoomType, IsAvailable FROM Room WHERE IsAvailable = 1 AND RoomType = ?";
//            PreparedStatement stmt = con.prepareStatement(query);
//            stmt.setString(1, roomType);  // Set the room type parameter
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Room room = new Room(rs.getString("RoomID"),
//                        rs.getInt("RoomNumber"),
//                        rs.getString("RoomType"),
//                        rs.getInt("IsAvailable"));
//                roomList.add(room);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return roomList;
//    }
    // Method to get all rooms by HotelID
    public static List<Room> getRoomsByHotel(String hotelID) {
        List<Room> roomList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT RoomID, RoomNumber, RoomType, IsAvailable FROM Room WHERE HotelID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, hotelID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room(rs.getString("RoomID"),
                        rs.getInt("RoomNumber"),
                        rs.getString("RoomType"),
                        rs.getInt("IsAvailable"));
                roomList.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roomList;
    }

    public static String BookingRoomDetail(String roomID) {
        String price = null;
        try (Connection con = getConnect()) {
            String updateQuery = "select r.RoomType, r.Capacity from Booking_Room_Detail brd\n"
                    + "inner join Room r on brd.RoomID = r.RoomID\n"
                    + "where r.RoomID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, roomID);
                ResultSet rs = updateStmt.executeQuery();
                if (rs.next()) {
                    String roomType = rs.getString("RoomType");
                    int capacity = rs.getInt("Capacity");
                    price = calculatePrice(roomType, capacity);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error booking room with ID: " + roomID, ex);
        }
        return price;
    }

    private static String calculatePrice(String roomType, int capacity) {
        String price = null;
        if (roomType.equalsIgnoreCase("Standard")) {
            if (capacity == 1) {
                price = "32";
            } else if (capacity == 2) {
                price = "49";
            } else if (capacity == 3) {
                price = "74";
            }
        } else if (roomType.equalsIgnoreCase("VIP")) {
            if (capacity == 1) {
                price = "199";
            } else if (capacity == 2) {
                price = "299";
            } else if (capacity == 3) {
                price = "599";
            }
        }
        return price;
    }

    public static List<BookingRoomDetail> getBookingRoomDetail() {
        List<BookingRoomDetail> roomList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT roomBookingID, roomID, price, dateFrom, dateTo, status FROM Booking_Room_Detail";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BookingRoomDetail room = new BookingRoomDetail(rs.getString("roomBookingID"),
                        rs.getString("roomID"),
                        rs.getString("price"),
                        rs.getString("dateFrom"),
                        rs.getString("dateTo"),
                        rs.getString("status"));
                roomList.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roomList;
    }

    public static void setPrice(String roomID, String price) {
        try (Connection con = getConnect()) {
            String updateQuery = "UPDATE Booking_Room_Detail SET price = ? WHERE roomID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, price);
                updateStmt.setString(2, roomID);
                updateStmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error updating price for room with ID: " + roomID, ex);
        }
    }


}
