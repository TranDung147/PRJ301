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

public class FlightDB implements DatabaseInfo{

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

    public static List<Flight> getAllFlights() {
        List<Flight> flights = new ArrayList<>();
        try {
            Connection con = getConnect();
            if (con != null) {
                String sql = "SELECT * FROM Flight";
                PreparedStatement statement = con.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String flightID = resultSet.getString("FlightID");
                    String planeID = resultSet.getString("PlaneID");
                    String dateStart = resultSet.getString("DateStart");
                    String dateEnd = resultSet.getString("DateEnd");
                    String departureCity = resultSet.getString("DepartureCity");
                    String arrivalCity = resultSet.getString("ArrivalCity");
                    String noSeatLeft = resultSet.getString("NoSeatLeft");
                    Flight flight = new Flight(flightID, planeID, dateStart, dateEnd, departureCity, arrivalCity, noSeatLeft);

                    flights.add(flight);
                }
                resultSet.close();
                statement.close();
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }
//    public static void main(String[] args) {
//        List<Flight> flights = FlightDB.getAllFlights();
//        
//        // In ra thông tin của từng chuyến bay
//        for (Flight flight : flights) {
//            System.out.println("Flight ID: " + flight.getFlightID());
//            System.out.println("Plane ID: " + flight.getPlaneID());
//            System.out.println("Date Start: " + flight.getDateStart());
//            System.out.println("Date End: " + flight.getDateEnd());
//            System.out.println("Departure City: " + flight.getDepartureCity());
//            System.out.println("Arrival City: " + flight.getArrivalCity());
//            System.out.println("------------------------");
//        }
//    }
}
