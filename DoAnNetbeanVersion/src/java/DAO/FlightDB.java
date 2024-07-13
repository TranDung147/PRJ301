package DAO;

import Model.Flight;
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

public class FlightDB implements DatabaseInfo {

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

    public static Flight getFlight(String id) {
        Flight f = null;
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT flightID, planeID, dateStart, dateEnd, departureCity, arrivalCity, noSeatLeft FROM Flight WHERE flightID = ?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String flightID = rs.getString(1);
                String planeID = rs.getString(2);
                String dateStart = rs.getString(3);
                String dateEnd = rs.getString(4);
                String departureCity = rs.getString(5);
                String arrivalCity = rs.getString(6);
                String noSeatLeft = rs.getString(7);
                f = new Flight(flightID, planeID, dateStart, dateEnd, departureCity, arrivalCity, noSeatLeft);
            }
        } catch (Exception ex) {
            Logger.getLogger(FlightDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return f;
    }

    // Method to insert a new flight
    public static void insert(Flight f) {
        String sql = "INSERT INTO Flight (FlightID, PlaneID, DateStart, DateEnd, DepartureCity, ArrivalCity, NoSeatLeft) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, f.getFlightID());
            stmt.setString(2, f.getPlaneID());
            stmt.setString(3, f.getDateStart());
            stmt.setString(4, f.getDateEnd());
            stmt.setString(5, f.getDepartureCity());
            stmt.setString(6, f.getArrivalCity());
            stmt.setString(7, f.getNoSeatLeft());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FlightDB.class.getName()).log(Level.SEVERE, "SQL Error: " + ex.getMessage(), ex);
        } catch (Exception ex) {
            Logger.getLogger(FlightDB.class.getName()).log(Level.SEVERE, "Error: " + ex.getMessage(), ex);
        }
    }

    // Method to update a flight
    public static void update(Flight f) {
        String sql = "UPDATE Flight SET planeID = ?, dateStart = ?, dateEnd = ?, departureCity = ?, arrivalCity = ?, noSeatLeft = ? WHERE flightID = ?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, f.getPlaneID());
            stmt.setString(2, f.getDateStart());
            stmt.setString(3, f.getDateEnd());
            stmt.setString(4, f.getDepartureCity());
            stmt.setString(5, f.getArrivalCity());
            stmt.setString(6, f.getNoSeatLeft());
            stmt.setString(7, f.getFlightID());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(FlightDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Method to delete a flight
    public static void delete(String flightID) {
        String sql = "DELETE FROM Flight WHERE flightID = ?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, flightID);
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(FlightDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static boolean deleteFlight(String flightId) {
        boolean deleted = false;
        Connection conn = null;
        PreparedStatement deleteBookingStmt = null;
        PreparedStatement deleteSeatsStmt = null;
        PreparedStatement deleteFlightStmt = null;

        try {
            conn = getConnect();
            conn.setAutoCommit(false);

            String deleteBookingSQL = "DELETE FROM Booking_Ticket_Detail WHERE SeatID IN (SELECT SeatID FROM Seat WHERE FlightID = ?)";
            deleteBookingStmt = conn.prepareStatement(deleteBookingSQL);
            deleteBookingStmt.setString(1, flightId);
            deleteBookingStmt.executeUpdate();

            String deleteSeatsSQL = "DELETE FROM Seat WHERE FlightID = ?";
            deleteSeatsStmt = conn.prepareStatement(deleteSeatsSQL);
            deleteSeatsStmt.setString(1, flightId);
            deleteSeatsStmt.executeUpdate();

            String deleteFlightSQL = "DELETE FROM Flight WHERE FlightID = ?";
            deleteFlightStmt = conn.prepareStatement(deleteFlightSQL);
            deleteFlightStmt.setString(1, flightId);
            int rowsDeleted = deleteFlightStmt.executeUpdate();

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
            // Đóng các statement và kết nối
            if (deleteBookingStmt != null) {
                try {
                    deleteBookingStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteSeatsStmt != null) {
                try {
                    deleteSeatsStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteFlightStmt != null) {
                try {
                    deleteFlightStmt.close();
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

    public static boolean updateFlight(String id, String planeId, String departureDate, String dateEnd, String departureCity, String arrivalCity, String noSeatLeft) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;

        try {
            conn = getConnect();
            String sql = "UPDATE Flight SET planeID = ?, dateStart = ?, dateEnd = ?, departureCity = ?, arrivalCity = ?, noSeatLeft = ? WHERE flightID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, planeId);
            stmt.setString(2, departureDate);
            stmt.setString(3, dateEnd);
            stmt.setString(4, departureCity);
            stmt.setString(5, arrivalCity);
            stmt.setString(6, noSeatLeft);
            stmt.setString(7, id);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                result = true;
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
        return result;
    }

    public static Flight getFlightById(String id) {
        Flight flight = null;
        String query = "SELECT * FROM Flight WHERE FlightID = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                flight = new Flight();
                flight.setFlightID(rs.getString("FlightID"));
                flight.setPlaneID(rs.getString("PlaneID"));
                flight.setDateStart(rs.getString("DateStart"));
                flight.setDateEnd(rs.getString("DateEnd"));
                flight.setDepartureCity(rs.getString("DepartureCity"));
                flight.setArrivalCity(rs.getString("ArrivalCity"));
                flight.setNoSeatLeft(rs.getString("NoSeatLeft"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return flight;
    }
}
