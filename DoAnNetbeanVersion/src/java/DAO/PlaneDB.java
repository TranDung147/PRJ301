package DAO;

import Model.Plane;
import static DAO.DatabaseInfo.DBURL;
import static DAO.DatabaseInfo.DRIVERNAME;
import static DAO.DatabaseInfo.PASSDB;
import static DAO.DatabaseInfo.USERDB;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PlaneDB implements DatabaseInfo {

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

    public static Plane getPlane(String id) {
        Plane p = null;
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT planeID, planeName, airline, planeImg, noSeat FROM Plane WHERE planeID = ?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String planeID = rs.getString(1);
                String planeName = rs.getString(2);
                String airline = rs.getString(3);
                String planeImg = rs.getString(4);
                String noSeat = rs.getString(5);
                p = new Plane(planeID, planeName, airline, planeImg, noSeat);
            }
        } catch (Exception ex) {
            Logger.getLogger(PlaneDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }

    // Method to insert a new plane
    public static void insert(Plane p) {
        String sql = "INSERT INTO Plane (PlaneID, PlaneName, Airline, ImageFileName, NoSeat) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, p.getPlaneID());
            stmt.setString(2, p.getPlaneName());
            stmt.setString(3, p.getAirline());
            stmt.setString(4, p.getPlaneImg());
            stmt.setInt(5, Integer.parseInt(p.getNoSeat()));
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PlaneDB.class.getName()).log(Level.SEVERE, "SQL Error: " + ex.getMessage(), ex);
        } catch (Exception ex) {
            Logger.getLogger(PlaneDB.class.getName()).log(Level.SEVERE, "Error: " + ex.getMessage(), ex);
        }
    }

    // Method to update a plane
    public static void update(Plane p) {
        String sql = "UPDATE Plane SET planeName = ?, airline = ?, planeImg = ?, noSeat = ? WHERE planeID = ?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, p.getPlaneName());
            stmt.setString(2, p.getAirline());
            stmt.setString(3, p.getPlaneImg());
            stmt.setString(4, p.getNoSeat());
            stmt.setString(5, p.getPlaneID());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(PlaneDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Method to delete a plane
    public static void delete(String planeID) {
        String sql = "DELETE FROM Plane WHERE planeID = ?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, planeID);
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(PlaneDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static List<Plane> getAllPlanes() {

        List<Plane> pList = new ArrayList<>();
        try {
            String query = "select * from Plane";
            Connection con = getConnect();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pList.add(new Plane(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
            con.close();
            ps.close();
            rs.close();

        } catch (Exception e) {
        }
        return pList;
    }

    public static boolean deletePlane(String planeId) {
        boolean deleted = false;
        Connection conn = null;
        PreparedStatement deleteBookingStmt = null;
        PreparedStatement deleteSeatStmt = null;
        PreparedStatement deleteFlightsStmt = null;
        PreparedStatement deletePlaneStmt = null;

        try {
            conn = getConnect();
            conn.setAutoCommit(false);

            String deleteBookingSQL = "DELETE FROM Booking_Ticket_Detail WHERE SeatID IN (SELECT SeatID FROM Seat WHERE FlightID IN (SELECT FlightID FROM Flight WHERE PlaneID = ?))";
            deleteBookingStmt = conn.prepareStatement(deleteBookingSQL);
            deleteBookingStmt.setString(1, planeId);
            deleteBookingStmt.executeUpdate();

            String deleteSeatSQL = "DELETE FROM Seat WHERE FlightID IN (SELECT FlightID FROM Flight WHERE PlaneID = ?)";
            deleteSeatStmt = conn.prepareStatement(deleteSeatSQL);
            deleteSeatStmt.setString(1, planeId);
            deleteSeatStmt.executeUpdate();

            String deleteFlightsSQL = "DELETE FROM Flight WHERE PlaneID = ?";
            deleteFlightsStmt = conn.prepareStatement(deleteFlightsSQL);
            deleteFlightsStmt.setString(1, planeId);
            deleteFlightsStmt.executeUpdate();

            String deletePlaneSQL = "DELETE FROM Plane WHERE PlaneID = ?";
            deletePlaneStmt = conn.prepareStatement(deletePlaneSQL);
            deletePlaneStmt.setString(1, planeId);
            int rowsDeleted = deletePlaneStmt.executeUpdate();

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
            if (deleteBookingStmt != null) {
                try {
                    deleteBookingStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteSeatStmt != null) {
                try {
                    deleteSeatStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deleteFlightsStmt != null) {
                try {
                    deleteFlightsStmt.close();
                } catch (SQLException e) {
                }
            }
            if (deletePlaneStmt != null) {
                try {
                    deletePlaneStmt.close();
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

    public static boolean updatePlane(String planeID, String planeName, String airline, String planeImg, String noSeat) {
        boolean success = false;
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Plane SET PlaneName=?, Airline=?, ImageFileName=?, NoSeat=? WHERE PlaneID=?")) {

            stmt.setString(1, planeName);
            stmt.setString(2, airline);
            stmt.setString(3, planeImg);
            stmt.setString(4, noSeat);
            stmt.setString(5, planeID);

            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);

        } catch (SQLException e) {
        }
        return success;
    }

    public static Plane getPlaneById(String id) {
        Plane plane = null;
        String query = "SELECT * FROM Plane WHERE PlaneID = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                plane = new Plane();
                plane.setPlaneID(rs.getString("PlaneID")); // Đảm bảo tên cột đúng
                plane.setPlaneName(rs.getString("PlaneName")); // Đảm bảo tên cột đúng
                plane.setAirline(rs.getString("Airline")); // Đảm bảo tên cột đúng
                plane.setPlaneImg(rs.getString("ImageFileName")); // Đảm bảo tên cột đúng
                plane.setNoSeat(rs.getString("NoSeat")); // Đảm bảo tên cột đúng
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi ra để kiểm tra
        }

        return plane;
    }

}
