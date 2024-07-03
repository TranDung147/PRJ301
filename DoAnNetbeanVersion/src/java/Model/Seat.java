
package Model;

import java.io.Serializable;

public class Seat implements Serializable {
    private String seatID;
    private String flightID;
    private int seatNumber;
    private String seatType;
    private int isAvailable;

    public Seat() {
    }

    public Seat(String seatID, String flightID, int seatNumber, String seatType, int isAvailable) {
        this.seatID = seatID;
        this.flightID = flightID;
        this.seatNumber = seatNumber;
        this.seatType = seatType;
        this.isAvailable = isAvailable;
    }

    public String getSeatID() {
        return seatID;
    }

    public void setSeatID(String seatID) {
        this.seatID = seatID;
    }

    public String getFlightID() {
        return flightID;
    }

    public void setFlightID(String flightID) {
        this.flightID = flightID;
    }

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public int getIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(int isAvailable) {
        this.isAvailable = isAvailable;
    }
    
}
