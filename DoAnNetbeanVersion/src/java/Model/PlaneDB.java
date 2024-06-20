/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.HotelDB.getConnect;
import java.sql.*;

import java.util.ArrayList;
import java.util.function.Predicate;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PlaneDB implements DatabaseInfo{

    public static Connection getConnect(){
        try{
            Class.forName(DRIVERNAME);
        }catch(ClassNotFoundException e){
            System.out.println("Error loading driver" + e);
        }
        try{
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
        }catch(SQLException e){
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
    
}
