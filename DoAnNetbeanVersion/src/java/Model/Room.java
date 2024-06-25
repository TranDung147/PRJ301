
package Model;

public class Room {
    private String roomID;
    private int roomNumber;
    private String roomType;
    private int isAvailable;

    public Room() {
    }

    public Room(String roomID, int roomNumber, String roomType, int isAvailable) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.isAvailable = isAvailable;
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
        return "Room{" + "roomID=" + roomID + ", roomNumber=" + roomNumber + ", roomType=" + roomType + ", isAvailable=" + isAvailable + '}';
    }
    
    
}
