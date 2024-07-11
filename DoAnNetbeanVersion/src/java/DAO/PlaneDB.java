/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Model.Hotel;
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

public class PlaneDB implements DatabaseInfo{

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
    
    public static Hotel getPlane(String id) {
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
    
}
