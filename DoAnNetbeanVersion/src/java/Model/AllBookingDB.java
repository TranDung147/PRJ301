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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AllBookingDB implements DatabaseInfo {

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
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
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

    public List<BookingTicket> getAllBookingTickets() {
        List<BookingTicket> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingTicket(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingTicketDetail> getAllBookingTicketDetails() {
        List<BookingTicketDetail> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Ticket_Detail");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingTicketDetail(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //------------------------------------------------------------------------------------------------------------------------
    public static String insertBookingRoom(String userID, String totalPrice, String status) {
        String roomBookingID = null;
        String insertBookingRoomSQL = "INSERT INTO Booking_Room (RoomBookingID, UserID, TotalPrice, Status, CreatedDate) VALUES (?, ?, ?, ?, GETDATE())";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomSQL)) {
            roomBookingID = generateUniqueBookingID();
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, userID);
            pstmt.setString(3, totalPrice);
            pstmt.setString(4, status);
            pstmt.executeUpdate();
        } catch (SQLException e) {

        }
        return roomBookingID;
    }

    public static boolean insertBookingRoomDetail(String roomBookingID, String roomID, String price, String dateFrom, String dateTo, String status) throws ParseException {
        String insertBookingRoomDetailSQL = "INSERT INTO Booking_Room_Detail (RoomBookingID, RoomID, Price, DateFrom, DateTo, Status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingRoomDetailSQL)) {
            pstmt.setString(1, roomBookingID);
            pstmt.setString(2, roomID);
            pstmt.setString(3, price);

            // Convert date strings to java.sql.Timestamp
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fromDate = sdf.parse(dateFrom);
            java.util.Date toDate = sdf.parse(dateTo);
            pstmt.setTimestamp(4, new java.sql.Timestamp(fromDate.getTime()));
            pstmt.setTimestamp(5, new java.sql.Timestamp(toDate.getTime()));

            pstmt.setString(6, status);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static String generateUniqueBookingID() {

        String uniqueID = UUID.randomUUID().toString().substring(0, 6);
        return uniqueID;
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

}
