
package Model;

public class Room {
    private String roomID;
    private String hotelID;
    private int roomNumber;
    private String roomType;
    private int capacity;
    private int isAvailable;

    public Room() {
    }

    public Room(String roomID, int roomNumber, String roomType, int isAvailable) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.isAvailable = isAvailable;
    }

    public Room(String roomID, String hotelID, int roomNumber, String roomType, int capacity, int isAvailable) {
        this.roomID = roomID;
        this.hotelID = hotelID;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.capacity = capacity;
        this.isAvailable = isAvailable;
    }
    
    

    public String getHotelID() {
        return hotelID;
    }

    public void setHotelID(String hotelID) {
        this.hotelID = hotelID;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
    
    

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(int isAvailable) {
        this.isAvailable = isAvailable;
    }

    @Override
    public String toString() {
        return "Room{" + "roomID=" + roomID + ", hotelID=" + hotelID + ", roomNumber=" + roomNumber + ", roomType=" + roomType + ", capacity=" + capacity + ", isAvailable=" + isAvailable + '}';
    }
  
    
}
