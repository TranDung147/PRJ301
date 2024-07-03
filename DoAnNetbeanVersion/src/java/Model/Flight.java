
package Model;

import java.io.Serializable;


public class Flight implements Serializable{
    private String flightID;
    private String planeID;
    private String dateStart;
    private String dateEnd;
    private String departureCity;
    private String arrivalCity;
    private String noSeatLeft;

    public Flight() {
    }

    public Flight(String flightID, String planeID, String dateStart, String dateEnd, String departureCity, String arrivalCity, String noSeatLeft) {
        this.flightID = flightID;
        this.planeID = planeID;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.departureCity = departureCity;
        this.arrivalCity = arrivalCity;
        this.noSeatLeft = noSeatLeft;
    }

    public Flight(String flightID, String planeID, String dateStart, String dateEnd, String departureCity, String arrivalCity) {
        this.flightID = flightID;
        this.planeID = planeID;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.departureCity = departureCity;
        this.arrivalCity = arrivalCity;
    }
    
    

    public String getNoSeatLeft() {
        return noSeatLeft;
    }

    public void setNoSeatLeft(String noSeatLeft) {
        this.noSeatLeft = noSeatLeft;
    }
    
    

    public String getFlightID() {
        return flightID;
    }

    public void setFlightID(String flightID) {
        this.flightID = flightID;
    }

    public String getPlaneID() {
        return planeID;
    }

    public void setPlaneID(String planeID) {
        this.planeID = planeID;
    }

    public String getDateStart() {
        return dateStart;
    }

    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }

    public String getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getDepartureCity() {
        return departureCity;
    }

    public void setDepartureCity(String departureCity) {
        this.departureCity = departureCity;
    }

    public String getArrivalCity() {
        return arrivalCity;
    }

    public void setArrivalCity(String arrivalCity) {
        this.arrivalCity = arrivalCity;
    }
    
}
