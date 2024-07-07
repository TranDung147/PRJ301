
package Model;

import java.io.Serializable;

public class BookingTicketDetail implements Serializable {
    private String bookingTicketID;
    private String seatID;
    private String price;
    private String status;

    // Constructors
    public BookingTicketDetail() {
    }

    public BookingTicketDetail(String bookingTicketID, String seatID, String price, String status) {
        this.bookingTicketID = bookingTicketID;
        this.seatID = seatID;
        this.price = price;
        this.status = status;
    }

    // Getters and Setters
    public String getBookingTicketID() {
        return bookingTicketID;
    }

    public void setBookingTicketID(String bookingTicketID) {
        this.bookingTicketID = bookingTicketID;
    }

    public String getSeatID() {
        return seatID;
    }

    public void setSeatID(String seatID) {
        this.seatID = seatID;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "BookingTicketDetail{" + "bookingTicketID=" + bookingTicketID + ", seatID=" + seatID + ", price=" + price + ", status=" + status + '}';
    }
    
    
}

