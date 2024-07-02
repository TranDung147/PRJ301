package Model;

import java.io.Serializable;

public class BookingTicket implements Serializable {

    private String ticketBookingID;
    private String userID;
    private String totalPrice;
    private String createdDate;

    // Constructors
    public BookingTicket() {
    }

    public BookingTicket(String ticketBookingID, String userID, String totalPrice, String createdDate) {
        this.ticketBookingID = ticketBookingID;
        this.userID = userID;
        this.totalPrice = totalPrice;
        this.createdDate = createdDate;
    }

    // Getters and Setters
    public String getTicketBookingID() {
        return ticketBookingID;
    }

    public void setTicketBookingID(String ticketBookingID) {
        this.ticketBookingID = ticketBookingID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
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
