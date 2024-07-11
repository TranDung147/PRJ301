package DAO;

import Model.BookingRoomDetail;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookingRoomDetailDB implements DatabaseInfo {

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

    public List<BookingRoomDetail> getAllBookingRoomDetails() {
        List<BookingRoomDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room_Detail");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoomDetail(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //---------------------------------------------------------------------------------------------------
    public static boolean insertBookingRoomDetail(String roomBookingID, String roomID, String price, String dateFrom, String dateTo, String status) {
        String insertBookingRoomDetailSQL = "INSERT INTO Booking_Room_Detail (RoomBookingID, RoomID, Price, DateFrom, DateTo, Status) VALUES (?, ?, ?, ?, ?, ?)";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomDetailSQL)) {
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, roomID);
            pstmt.setString(3, price);
            pstmt.setString(4, dateFrom);
            pstmt.setString(5, dateTo);

//            // Chuyển đổi chuỗi ngày thành java.sql.Timestamp
//            java.sql.Timestamp fromTimestamp = new java.sql.Timestamp(sdf.parse(dateFrom).getTime());
//            java.sql.Timestamp toTimestamp = new java.sql.Timestamp(sdf.parse(dateTo).getTime());
//            pstmt.setTimestamp(4, fromTimestamp);
//            pstmt.setTimestamp(5, toTimestamp);
            pstmt.setString(6, status);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace(); // In ra stack trace khi xảy ra lỗi SQL
            return false;
        }
    }

    public List<java.sql.Date[]> getDateFromToDateByRoomBookingID(String roomBookingID) {
        List<java.sql.Date[]> dateRanges = new ArrayList<>();
        String query = "SELECT DateFrom, DateTo FROM Booking_Room_Detail WHERE RoomBookingID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, roomBookingID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    java.sql.Date dateFrom = resultSet.getDate("DateFrom");
                    java.sql.Date dateTo = resultSet.getDate("DateTo");
                    java.sql.Date[] dates = {dateFrom, dateTo};
                    dateRanges.add(dates);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching date ranges by RoomBookingID: " + roomBookingID, e);
        }
        return dateRanges;
    }

    public List<String> getRoomBookingIDsByRoomID(String roomID) {
        List<String> roomBookingIDs = new ArrayList<>();
        String query = "SELECT RoomBookingID FROM Booking_Room_Detail WHERE RoomID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, roomID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    roomBookingIDs.add(resultSet.getString("RoomBookingID"));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching RoomBookingIDs by RoomID: " + roomID, e);
        }
        return roomBookingIDs;
    }

    //-------------------------------------------------------------------------------------------------
    // In ra tất cả các Orders ở status Pending trong adminOders.jsp - nauQ
    public List<BookingRoomDetail> getAllOrderBRD() {
        List<BookingRoomDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room_Detail WHERE status = 'Pending'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoomDetail(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Cập nhật status Order (Pending -> Confirmed/Declined) trong adminDetails.jsp - nauQ
    public boolean updateRoomOrderStatus(String orderId, String status) {
        String sql = "UPDATE Booking_Room_Detail SET Status = ? WHERE RoomBookingID = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, orderId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // In ra tất cả các Order đã được duyệt trong adminOrder.jsp vào adminOrderHistory.jsp - nauQ
    public List<BookingRoomDetail> getAllProcessedBookingRoomDetails() {
        List<BookingRoomDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room_Detail where status = 'Approved' OR status = 'Declined'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoomDetail(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Xóa Order trong adminOrderHistory.jsp
    public void removeBookingRoom(String bookingId) {
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Booking_Room_Detail WHERE RoomBookingID = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, bookingId);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingRoomDetailDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
