
package Model;

import java.io.Serializable;

public class BookingRoomDetail implements Serializable {
    private String roomBookingID;
    private String roomID;
    private String price;
    private String dateFrom;
    private String dateTo;
    private String status;

    // Constructors
    public BookingRoomDetail() {
    }

    public BookingRoomDetail(String roomBookingID, String roomID, String price, String dateFrom, String dateTo, String status) {
        this.roomBookingID = roomBookingID;
        this.roomID = roomID;
        this.price = price;
        this.dateFrom = dateFrom;
        this.dateTo = dateTo;
        this.status = status;
    }

    public String getRoomBookingID() {
        return roomBookingID;
    }

    public void setRoomBookingID(String roomBookingID) {
        this.roomBookingID = roomBookingID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(String dateFrom) {
        this.dateFrom = dateFrom;
    }

    public String getDateTo() {
        return dateTo;
    }

    public void setDateTo(String dateTo) {
        this.dateTo = dateTo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    

}
   