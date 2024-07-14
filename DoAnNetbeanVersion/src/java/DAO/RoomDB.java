package DAO;

import Model.Room;
import Model.BookingRoomDetail;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
            String query = "SELECT * FROM Room WHERE RoomID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                room = new Room(rs.getString("RoomID"), rs.getString("HotelID"), rs.getInt("RoomNumber"), rs.getString("RoomType"), rs.getInt("Capacity"), rs.getInt("IsAvailable"));
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

    public static String calculatePrice(String roomType, int capacity) {
        String price = null;
        if (roomType.equalsIgnoreCase("Standard")) {
            if (capacity == 1) {
                price = "32.99";
            } else if (capacity == 2) {
                price = "49.9";
            } else if (capacity == 3) {
                price = "74.99";
            }
        } else if (roomType.equalsIgnoreCase("VIP")) {
            if (capacity == 1) {
                price = "199.99";
            } else if (capacity == 2) {
                price = "299.99";
            } else if (capacity == 3) {
                price = "599.99";
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

    public static void insert(Room r) {
        String sql = "INSERT INTO Room (roomID, hotelID, roomNumber, roomType, capacity, isAvailable) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, r.getRoomID());
            stmt.setString(2, r.getHotelID());
            stmt.setInt(3, r.getRoomNumber());
            stmt.setString(4, r.getRoomType());
            stmt.setInt(5, r.getCapacity());
            stmt.setInt(6, r.getIsAvailable());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "SQL Error: " + ex.getMessage(), ex);
        } catch (Exception ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error: " + ex.getMessage(), ex);
        }
    }

    public static boolean deleteRoom(String roomId) {
        boolean deleted = false;
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnect();
            String deleteBookingRoomDetailSql = "DELETE FROM Booking_Room_Detail WHERE RoomID = ?";
            stmt = conn.prepareStatement(deleteBookingRoomDetailSql);
            stmt.setString(1, roomId);
            stmt.executeUpdate();
            String sql = "DELETE FROM Room WHERE RoomID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomId);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                deleted = true;
            }
        } catch (SQLException e) {

        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }

        return deleted;
    }

    public static boolean updateRoom(String roomID, String hotelID, int roomNumber, String roomType, int capacity, int isAvailable) {
        boolean success = false;
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Room SET HotelID=?, RoomNumber=?, RoomType=?, Capacity=?, IsAvailable=? WHERE RoomID=?")) {

            stmt.setString(1, hotelID);
            stmt.setInt(2, roomNumber);
            stmt.setString(3, roomType);
            stmt.setInt(4, capacity);
            stmt.setInt(5, isAvailable);
            stmt.setString(6, roomID);
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);

        } catch (SQLException e) {
        }
        return success;
    }

    public static Room getRoomById(String id) {
        Room room = null;
        String query = "SELECT * FROM Room WHERE RoomID = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                room = new Room();
                room.setRoomID(rs.getString("RoomID"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setHotelID(rs.getString("HotelID"));
                room.setCapacity(rs.getInt("Capacity"));
                room.setIsAvailable(rs.getInt("IsAvailable"));
            }
        } catch (SQLException e) {
        }

        return room;
    }

    public Room getRoomByRoomBookingID(String roomBookingID) {
        Room room = null;
        String query = "SELECT r.RoomID, r.HotelID, r.RoomNumber, r.RoomType, r.Capacity, r.IsAvailable "
                + "FROM Room r "
                + "JOIN Booking_Room_Detail brd ON r.RoomID = brd.RoomID "
                + "WHERE brd.RoomBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, roomBookingID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                room = new Room();
                room.setRoomID(rs.getString("RoomID"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setHotelID(rs.getString("HotelID"));
                room.setCapacity(rs.getInt("Capacity"));
                room.setIsAvailable(rs.getInt("IsAvailable"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return room;
    }

    //----------------------------------------------------------------------
    public Map<String, Integer> countBookingRoomDetailsByRoomType(String year) {
    Map<String, Integer> counts = new HashMap<>();
    String query = "SELECT r.RoomType, COUNT(DISTINCT br.RoomBookingID) AS Count " +
                   "FROM Booking_Room_Detail brd " +
                   "JOIN Room r ON brd.RoomID = r.RoomID " +
                   "JOIN Booking_Room br ON brd.RoomBookingID = br.RoomBookingID " +
                   "WHERE YEAR(brd.DateFrom) = ? AND brd.Status = 'Confirmed' " +
                   "GROUP BY r.RoomType";

    try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
        stmt.setString(1, year);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            String roomType = rs.getString("RoomType");
            int count = rs.getInt("Count");
            counts.put(roomType, count);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return counts;
}

    public static Map<Integer, Map<String, Double>> getTotalPriceByRoomType(String year) {
    Map<Integer, Map<String, Double>> totalPriceByRoomTypeAndMonth = new HashMap<>();
    String query = "SELECT r.RoomType, MONTH(br.CreatedDate) AS Month, SUM(brd.Price) AS TotalPrice " +
                   "FROM Booking_Room_Detail brd " +
                   "JOIN Room r ON brd.RoomID = r.RoomID " +
                   "JOIN Booking_Room br ON brd.RoomBookingID = br.RoomBookingID " +
                   "WHERE YEAR(br.CreatedDate) = ? AND brd.Status = 'Confirmed' " +
                   "GROUP BY r.RoomType, MONTH(br.CreatedDate)";

    try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
        stmt.setString(1, year);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            String roomType = rs.getString("RoomType");
            int month = rs.getInt("Month");
            double totalPrice = rs.getDouble("TotalPrice");

            totalPriceByRoomTypeAndMonth
                .computeIfAbsent(month, k -> new HashMap<>())
                .put(roomType, totalPrice);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return totalPriceByRoomTypeAndMonth;
}
}
