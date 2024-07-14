package DAO;

import Model.Hotel;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class HotelDB implements DatabaseInfo {

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

    public static Hotel getHotel(String id) {
        Hotel s = null;
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("Select HotelName, HotelAddress, Description, City, Country from Hotel where HotelID=?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String name = rs.getString(1);
                String address = rs.getString(2);
                String description = rs.getString(3);
                String city = rs.getString(4);
                String country = rs.getString(5);
                s = new Hotel(id, name, address, description, city, country);
            }
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;
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
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
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
        ArrayList<Hotel> list = new ArrayList<>();//vì cái trả về là một danh sách nên lưu và truyền nó ở dạng arraylist

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("Select HotelID, HotelName, HotelAddress, Description, productImage, City, Country from Hotel");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Hotel(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7)));
            }
            con.close();
            System.out.println(list);
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void insert(Hotel c) {
        String sql = "INSERT INTO Hotel (HotelID, HotelName, HotelAddress, Description, productImage, City, Country) VALUES(?,?,?,?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, c.getHotelId());
            stmt.setString(2, c.getHotelName());
            stmt.setString(3, c.getHotelAddress());
            stmt.setString(4, c.getHotelDescription());
            stmt.setString(5, c.getProductImage());
            stmt.setString(6, c.getCity());
            stmt.setString(7, c.getCountry());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, "SQL Error: " + ex.getMessage(), ex);
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, "Error: " + ex.getMessage(), ex);
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
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, "Error fetching hotel by ID", ex);
        }
        return null;
    }

    public static List<Hotel> getAvailableRooms(String roomType) {
        List<Hotel> hotelList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT h.HotelID, HotelName, HotelAddress, Description, productImage, City, Country "
                    + "FROM Hotel h "
                    + "INNER JOIN Room r ON r.HotelID = h.HotelID "
                    + "WHERE r.IsAvailable = 1 AND r.RoomType = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomType);  // Set the room type parameter
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Hotel hotel = new Hotel(
                        rs.getString("HotelID"),
                        rs.getString("HotelName"),
                        rs.getString("HotelAddress"),
                        rs.getString("Description"),
                        rs.getString("productImage"),
                        rs.getString("City"),
                        rs.getString("Country"));
                hotelList.add(hotel);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return hotelList;
    }

    public static List<Hotel> searchHotel(String roomType, String city) {
        List<Hotel> hotelList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT h.HotelID, h.HotelName, h.HotelAddress, h.Description, h.productImage, h.City, h.Country\n"
                    + "                   FROM Hotel h\n"
                    + "                   INNER JOIN (\n"
                    + "                   SELECT DISTINCT h.HotelID\n"
                    + "                   FROM Hotel h\n"
                    + "                   INNER JOIN Room r ON r.HotelID = h.HotelID\n"
                    + "                   WHERE r.IsAvailable = 1 AND r.RoomType = ? and h.City = ?\n"
                    + "                   ) distinct_hotels ON h.HotelID = distinct_hotels.HotelID";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomType);  // Set the room type parameter
            stmt.setString(2, city);  // Set the room type parameter
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Hotel hotel = new Hotel(
                        rs.getString("HotelID"),
                        rs.getString("HotelName"),
                        rs.getString("HotelAddress"),
                        rs.getString("Description"),
                        rs.getString("productImage"),
                        rs.getString("City"),
                        rs.getString("Country"));
                hotelList.add(hotel);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return hotelList;
    }

    public static boolean deleteHotel(String hotelId) {
        boolean deleted = false;
        Connection conn = null;
        PreparedStatement deleteBookingRoomsStmt = null;
        PreparedStatement deleteRoomsStmt = null;
        PreparedStatement deleteHotelStmt = null;

        try {
            conn = getConnect();
            conn.setAutoCommit(false);

            String deleteBookingRoomsSQL = "DELETE FROM Booking_Room_Detail WHERE RoomID IN (SELECT RoomID FROM Room WHERE HotelID = ?)";
            deleteBookingRoomsStmt = conn.prepareStatement(deleteBookingRoomsSQL);
            deleteBookingRoomsStmt.setString(1, hotelId);
            deleteBookingRoomsStmt.executeUpdate();
            String deleteRoomsSQL = "DELETE FROM Room WHERE HotelID = ?";
            deleteRoomsStmt = conn.prepareStatement(deleteRoomsSQL);
            deleteRoomsStmt.setString(1, hotelId);
            deleteRoomsStmt.executeUpdate();
            String deleteHotelSQL = "DELETE FROM Hotel WHERE HotelID = ?";
            deleteHotelStmt = conn.prepareStatement(deleteHotelSQL);
            deleteHotelStmt.setString(1, hotelId);
            int rowsDeleted = deleteHotelStmt.executeUpdate();

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
            if (deleteBookingRoomsStmt != null) {
                try {
                    deleteBookingRoomsStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteRoomsStmt != null) {
                try {
                    deleteRoomsStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteHotelStmt != null) {
                try {
                    deleteHotelStmt.close();
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
    
    public static boolean updateHotel(String id, String name, String address, String description, String city, String country, String ProductImage) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean success = false;

        try {
            conn = getConnect();
            String query = "UPDATE Hotel SET HotelName = ?, HotelAddress = ?, Description = ?, City = ?, Country = ?, ProductImage = ? WHERE hotelid = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, description);
            ps.setString(4, city);
            ps.setString(5, country);
            ps.setString(6, ProductImage);
            ps.setString(7, id);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }
        } catch (SQLException ex) {
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
            }
        }       
        return success;
    }
 public static Hotel getHotelByIds(String id) {
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
                        rs.getString("Country"),
                        rs.getString("ProductImage")
                );
                return c;
            }
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, "Error fetching hotel by ID", ex);
        }
        return null;
    }
}
