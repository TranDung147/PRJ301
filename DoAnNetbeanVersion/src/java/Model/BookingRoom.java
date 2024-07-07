
package Model;

import java.io.Serializable;

public class BookingRoom implements Serializable{
    private String roomBookingID;
    private String userID;
    private String totalPrice;
    private String createdDate;
    private String status;

    // Constructors
    public BookingRoom() {
    }

    public BookingRoom(String roomBookingID, String userID, String totalPrice, String createdDate, String status) {
        this.roomBookingID = roomBookingID;
        this.userID = userID;
        this.totalPrice = totalPrice;
        this.createdDate = createdDate;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
    
    // Getters and Setters
    public String getRoomBookingID() {
        return roomBookingID;
    }

    public void setRoomBookingID(String roomBookingID) {
        this.roomBookingID = roomBookingID;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }
}

