/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.io.Serializable;

public class Plane implements Serializable{
    String planeID;
    String planeName;
    String airline;
    String planeImg;
    String noSeat;

    public Plane() {
    }

    public Plane(String planeID, String planeName, String airline, String planeImg, String noSeat) {
        this.planeID = planeID;
        this.planeName = planeName;
        this.airline = airline;
        this.planeImg = planeImg;
        this.noSeat = noSeat;
    }

    public String getPlaneID() {
        return planeID;
    }

    public void setPlaneID(String planeID) {
        this.planeID = planeID;
    }

    public String getPlaneName() {
        return planeName;
    }

    public void setPlaneName(String planeName) {
        this.planeName = planeName;
    }

    public String getAirline() {
        return airline;
    }

    public void setAirline(String airline) {
        this.airline = airline;
    }

    public String getPlaneImg() {
        return planeImg;
    }

    public void setPlaneImg(String planeImg) {
        this.planeImg = planeImg;
    }

    public String getNoSeat() {
        return noSeat;
    }

    public void setNoSeat(String noSeat) {
        this.noSeat = noSeat;
    }
    
     public Plane(Plane s) {
        this(s.planeID, s.planeName, s.airline,
                s.planeImg, s.noSeat);
    }

//    public Plane(String id) {
//        this(PlaneDB.getPlane(id));
//    }
    
}
