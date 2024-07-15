package DAO;

import Model.BookingRoom;
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

public class BookingRoomDB implements DatabaseInfo {

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

    // Phương thức lấy tất cả các booking room từ CSDL
    public List<BookingRoom> getAllBookingRooms() {
        List<BookingRoom> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingRoom> getAllUserBookingRooms(String id) {
        List<BookingRoom> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room WHERE UserID = ? and status = ?");
            stmt.setString(1, id);
            stmt.setString(2, "None");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public BookingRoom getBookingRoomByRoomBookingID(String roomBookingID) {
        BookingRoom bookingRoom = null;
        String query = "SELECT RoomBookingID, UserID, TotalPrice, CreatedDate, Status "
                + "FROM Booking_Room "
                + "WHERE RoomBookingID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, roomBookingID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bookingRoom = new BookingRoom();
                bookingRoom.setRoomBookingID(rs.getString("RoomBookingID"));
                bookingRoom.setUserID(rs.getString("UserID"));
                bookingRoom.setTotalPrice(rs.getString("TotalPrice"));
                bookingRoom.setCreatedDate(rs.getString("CreatedDate"));
                bookingRoom.setStatus(rs.getString("Status"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return bookingRoom;
    }

    public BookingRoom getTodayAvailableBookingRoom(String id) {
        BookingRoom br = new BookingRoom();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT TOP 1 * FROM Booking_Room WHERE status != 'None' and UserID = ? order by RoomBookingID DESC");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                br = new BookingRoom(
                        rs.getString("RoomBookingID"), // or rs.getString(1)
                        rs.getString("UserID"), // or rs.getString(2)
                        rs.getString("TotalPrice"), // or rs.getString(3)
                        rs.getString("CreatedDate"), // or rs.getString(4)
                        rs.getString("Status") // or rs.getString(5)
                );
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingRoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return br;
    }

    public static String getTodayBookingRoomID(String userID) {
        String bookingRoomID = null;
        String getBookingRoomIDSQL = "SELECT RoomBookingID FROM Booking_Room WHERE UserID = ? AND Status = 'None' AND CreatedDate = CAST(GETDATE() AS DATE)";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(getBookingRoomIDSQL)) {
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                bookingRoomID = rs.getString("RoomBookingID");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return bookingRoomID;
    }

    public static boolean updateTotalPrice(String bookingRoomID, String additionalPrice) {
        String updateTotalPriceSQL = "UPDATE Booking_Room SET TotalPrice = ISNULL(TotalPrice, 0) + ? WHERE RoomBookingID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(updateTotalPriceSQL)) {
            pstmt.setString(1, additionalPrice);
            pstmt.setString(2, bookingRoomID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
            return false;
        }
    }

    //------------------------------------------------------------------------------------------------------------------------
    // Lấy tất cả các roomBookingID hiện có từ cơ sở dữ liệu
    private static List<Integer> getExistingBookingIDs() {
        List<Integer> existingIDs = new ArrayList<>();
        String querySQL = "SELECT CAST(SUBSTRING(RoomBookingID, 3, LEN(RoomBookingID) - 2) AS INT) AS NumericID FROM Booking_Room ORDER BY NumericID";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(querySQL); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                existingIDs.add(rs.getInt("NumericID"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return existingIDs;
    }

    // Tìm ID nhỏ nhất chưa được sử dụng
    private static int findSmallestUnusedID(List<Integer> existingIDs) {
        if (existingIDs.isEmpty()) {
            return 1; // Nếu không có ID nào, bắt đầu từ 1
        }

        int expectedID = 1;
        for (int id : existingIDs) {
            if (id != expectedID) {
                return expectedID; // Trả về ID nhỏ nhất bị thiếu
            }
            expectedID++;
        }
        return expectedID; // Nếu không thiếu ID nào, trả về ID tiếp theo lớn nhất
    }

    // Tạo roomBookingID mới hoặc sử dụng ID nhỏ nhất chưa được sử dụng
    private static String generateNextAvailableBookingID() {
        List<Integer> existingIDs = getExistingBookingIDs(); // Lấy tất cả các ID hiện có
        int nextUnusedID = findSmallestUnusedID(existingIDs); // Tìm ID nhỏ nhất chưa được sử dụng
        int largestID = existingIDs.isEmpty() ? 0 : existingIDs.get(existingIDs.size() - 1); // Tìm ID lớn nhất hiện tại

        // Chọn ID nhỏ nhất chưa được sử dụng hoặc ID lớn nhất hiện tại + 1
        int newID = Math.max(nextUnusedID, largestID + 1);

        return String.format("BR%04d", newID); // Định dạng thành RBxxxx
    }

    // Phương thức để chèn một booking mới vào cơ sở dữ liệu
    public static String insertBookingRoom(String userID, String totalPrice) {
        String roomBookingID = null;
        String insertBookingRoomSQL = "INSERT INTO Booking_Room (RoomBookingID, UserID, TotalPrice, CreatedDate, Status) VALUES (?, ?, ?, GETDATE(), ?)";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomSQL)) {
            // Tạo roomBookingID mới dựa trên ID hiện tại hoặc ID nhỏ nhất bị thiếu
            roomBookingID = generateNextAvailableBookingID();
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, userID);
            pstmt.setString(3, totalPrice);
            pstmt.setString(4, "None");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ SQL
        }
        return roomBookingID;
    }
    
    public static boolean isRoomAvailable(String roomID, String checkInDate, String checkOutDate) {
    boolean isAvailable = true;
    String query = "SELECT * FROM Booking_Room_Detail WHERE RoomID = ? " +
                   "AND (DateFrom <= ? AND DateTo >= ?)";

    try (Connection conn = getConnect();
         PreparedStatement stmt = conn.prepareStatement(query)) {

        stmt.setString(1, roomID);
        stmt.setString(2, checkInDate); 
        stmt.setString(3, checkOutDate); 

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            isAvailable = false; 
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Xử lý lỗi
    }

    return isAvailable;
}

  public static boolean isRoomIDExists(String roomBookingID, String userID, String roomID) {
        boolean exists = false;
        String query = "SELECT COUNT(*) FROM Booking_Room_Detail brd " +
                       "JOIN Booking_Room br ON br.RoomBookingID = brd.RoomBookingID " +
                       "WHERE br.UserID = ? AND brd.RoomID = ?";

        try (Connection conn = getConnect();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, userID);
            stmt.setString(2, roomID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    exists = count > 0;  // Nếu count > 0, RoomID đã tồn tại
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return exists;
    }

}
