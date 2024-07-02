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

//    public static Room getRoom(String id) {
//        Room s = null;
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement("Select RoomID, RoomNumber, RoomType, IsAvailable from Room where HotelID=?");
//            stmt.setString(1, id);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                String rid = rs.getString(1);
//                int number = rs.getInt(2);
//                String type = rs.getString(3);
//                int avai = rs.getInt(4);
//                s = new Room(id, number,type,avai);
//            }
//            con.close();
//        } catch (Exception ex) {
//            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return s;
//    }
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
    public static Hotel update(Hotel hotel) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("UPDATE Hotel SET HotelName=?, Description=?, HotelAddress=?, City=?, Country=? WHERE HotelID=?");
            stmt.setString(1, hotel.getHotelName());
            stmt.setString(2, hotel.getHotelDescription());
            stmt.setString(3, hotel.getHotelAddress());
            stmt.setString(4, hotel.getCity());
            stmt.setString(5, hotel.getCountry());
            stmt.setString(6, hotel.getHotelId());

            int rowCount = stmt.executeUpdate();
            if (rowCount > 0) {
                return hotel; // Return the updated hotel object
            } else {
                throw new RuntimeException("Failed to update hotel with ID: " + hotel.getHotelId());
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Database error occurred while updating hotel");
        }
    }

//--------------------------------------------------------------------------------
//    
//        public void updateHotelQuantity(int id, int quantity) {
//        String sql = "UPDATE Products SET StockQuantity = ? WHERE id = ?";
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement(sql);
//            stmt.setInt(1, quantity);
//            stmt.setInt(2, id);
//            stmt.executeUpdate();
//        } catch (Exception ex) {
//            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    //--------------------------------------------------------------------------------------------
    public static int delete(String id) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("Delete Hotel where HotelID =?");
            stmt.setString(1, id);
            int rc = stmt.executeUpdate();
            con.close();
            return rc;
        } catch (Exception ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
////--------------------------------------------------------------------------------------------
//
//    public static ArrayList<Hotel> search(Predicate<Hotel> p) {
//        ArrayList<Hotel> list = listAll();
//        ArrayList<Hotel> res = new ArrayList<Hotel>();
//        for (Hotel s : list) {
//            if (p.test(s)) {
//                res.add(s);
//            }
//        }
//        return res;
//    }
//--------------------------------------------------------------------------------------------

    public static ArrayList<Hotel> listAll() {
        ArrayList<Hotel> list = new ArrayList<Hotel>();//vì cái trả về là một danh sách nên lưu và truyền nó ở dạng arraylist

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("Select HotelID, HotelName, HotelAddress, Description, City, Country from Hotel");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Hotel(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insert(Hotel c) {
        String sql = "INSERT INTO Hotel (HotelID, HotelName, HotelAddress, Description, City, Country)\n"
                + "VALUES(?,?,?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, c.getHotelId());
            stmt.setString(2, c.getHotelName());
            stmt.setString(3, c.getHotelAddress());
            stmt.setString(4, c.getHotelDescription());
            stmt.setString(5, c.getCity());
            stmt.setString(6, c.getCountry());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Hotel getHotelById(String id) {
        String sql = "select * from Hotel where HotelID = ?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Assuming Hotel constructor can take these parameters
                Hotel c = new Hotel(
                        rs.getString("HotelID"),
                        rs.getString("HotelName"),
                        rs.getString("HotelAddress"),
                        rs.getString("Description"),
                        rs.getString("City"),
                        rs.getString("Country")
                );
                return c;
            }
        } catch (Exception ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching hotel by ID", ex);
        }
        return null;
    }
    //--------------------------------------------------------------------------------------------

//    public static void main(String[] a) {
//        ArrayList<Hotel> list = HotelDB.listAll();
//        for (Hotel item : list) {
//            System.out.println(item);
//        }
//    }
//---------------------------------------------------------------------------
}
