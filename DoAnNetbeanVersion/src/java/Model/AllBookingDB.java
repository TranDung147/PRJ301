
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
import java.util.ArrayList;
import java.util.List;
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
    public static List<BookingRoom> getAllBookings() {
        List<BookingRoom> list = new ArrayList<>();

        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Booking_Room");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BookingRoom(rs.getString(1), rs.getString(2), rs.getString(3),rs.getString(4),rs.getString(5)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(HotelDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void main(String[] args) {

//         // Retrieve all booking rooms
//        List<BookingRoom> bookingRooms = getAllBookings();
//
//        // Display booking room details
//        if (bookingRooms != null) {
//            for (BookingRoom bookingRoom : bookingRooms) {
//                System.out.println("Room Booking ID: " + bookingRoom.getRoomBookingID());
//                System.out.println("User ID: " + bookingRoom.getUserID());
//                System.out.println("Total Price: " + bookingRoom.getTotalPrice());
//                System.out.println("Status: " + bookingRoom.getStatus());
//                System.out.println("Created Date: " + bookingRoom.getCreatedDate());
//                System.out.println("-----------------------------");
//            }
//        } else {
//            System.out.println("Failed to retrieve booking rooms.");
//        }
        
        List<BookingRoom> list = AllBookingDB.getAllBookings();
        for (BookingRoom item : list) {
            System.out.println(item);
        }
    }
}
