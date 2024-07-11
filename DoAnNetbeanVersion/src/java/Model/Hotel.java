package Model;

import DAO.HotelDB;
import java.io.Serializable;

public class Hotel implements Serializable {

    private String hotelId;
    private String hotelName;
    private String hotelAddress;
    private String hotelDescription;
    private String productImage;
    private String city;
    private String country;

    public Hotel() {
    }

    public Hotel(String hotelId, String hotelName, String hotelAddress, String hotelDescription, String city, String country) {
        this.hotelId = hotelId;
        this.hotelName = hotelName;
        this.hotelAddress = hotelAddress;
        this.hotelDescription = hotelDescription;
        this.city = city;
        this.country = country;
    }

    public Hotel(String hotelId, String hotelName, String hotelAddress, String hotelDescription, String productImage, String city, String country) {
        this.hotelId = hotelId;
        this.hotelName = hotelName;
        this.hotelAddress = hotelAddress;
        this.hotelDescription = hotelDescription;
        this.productImage = productImage;
        this.city = city;
        this.country = country;
    }

    public String getHotelId() {
        return hotelId;
    }

    public void setHotelId(String hotelId) {
        this.hotelId = hotelId;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getHotelAddress() {
        return hotelAddress;
    }

    public void setHotelAddress(String hotelAddress) {
        this.hotelAddress = hotelAddress;
    }

    public String getHotelDescription() {
        return hotelDescription;
    }

    public void setHotelDescription(String hotelDescription) {
        this.hotelDescription = hotelDescription;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Hotel(Hotel s) {
        this(s.hotelId, s.hotelName, s.hotelAddress,
                s.hotelDescription, s.city, s.country);
    }

    public Hotel(String id) {
        this(HotelDB.getHotel(id));
    }

//    public int addNew() {
//        return HotelDB.newHotel(this);
//    }
//
//    public Hotel update() {
//        return HotelDB.update(this);
//    }
//
//    public int delete() {
//        return HotelDB.delete(this.hotelId);
//    }

    @Override
    public String toString() {
        return "Hotel{" + "hotelId=" + hotelId + ", hotelName=" + hotelName + ", hotelAddress=" + hotelAddress + ", hotelDescription=" + hotelDescription + ", productImage=" + productImage + ", city=" + city + ", country=" + country + '}';
    }
    
}
