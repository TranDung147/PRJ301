package Model;

import java.io.Serializable;

public class User implements Serializable {

    public String userID;
    public String username;
    public String password;
    public String email;
    public String role;
    public String fName;
    public String lName;

    public User() {
    }

    public User(String username, String password, String role, String email, String userID) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
        this.userID = userID;
    }

    public User(String userID, String username, String password, String email, String fName, String lName) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fName = fName;
        this.lName = lName;
    }
    
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }
}
