package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
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

//--------------------------------------------------------------------------------------------
//
//    public static int newHotel(Hotel s) {
//        int id = -1;
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement("Insert into Hotel(ProductID, ProductName, Description, Category, Price, StockQuantity, ProductImage, UnitOfMeasurement) output inserted.id values(?,?,?)");
//            stmt.setString(1, s.getProductName());
//            stmt.setString(2, s.getProductName());
//
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                id = rs.getInt(1);
//            }
//            con.close();
//        } catch (Exception ex) {
//            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return id;
//    }
//-----------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------------------
//
//    public static void main(String[] a) {
////        ArrayList<Hotel> list = HotelDB.listAll();
////        for (Hotel item : list) {
////            System.out.println(item);
////        }
////---------------------------------------------------------------------------
//    }
}
