
package Model;

import java.io.Serializable;

public class Transaction implements Serializable{
    String transactionId;
    String userId;
    String roomBookingId;
    String ticketBookingId;
    String transactionDate;
    String amount;
    String status;

    public Transaction() {
    }

    public Transaction(String transactionId, String userId, String roomBookingId, String ticketBookingId, String transactionDate, String amount, String status) {
        this.transactionId = transactionId;
        this.userId = userId;
        this.roomBookingId = roomBookingId;
        this.ticketBookingId = ticketBookingId;
        this.transactionDate = transactionDate;
        this.amount = amount;
        this.status = status;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRoomBookingId() {
        return roomBookingId;
    }

    public void setRoomBookingId(String roomBookingId) {
        this.roomBookingId = roomBookingId;
    }

    public String getTicketBookingId() {
        return ticketBookingId;
    }

    public void setTicketBookingId(String ticketBookingId) {
        this.ticketBookingId = ticketBookingId;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
