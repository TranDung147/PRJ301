package DAO;

import Model.User;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public User getUsers(String username, String password) {
        User user = null;
        String query = "select Username, Pass, FName , LName , UserID, Email, Phone, Address, Sex, DateOfBirth, MoneyLeft "
                + "from Users where Username =? and Pass=? ";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // String id = rs.getString("UserId");
                username = rs.getString(1);
                password = rs.getString(2);
                String fName = rs.getString(3);
                String lName = rs.getString(4);
                String id = rs.getString(5);
                String email = rs.getString(6);
                String phone = rs.getString(7);
                String address = rs.getString(8);
                String sex = rs.getString(9);
                String DOB = rs.getString(10);
                String money = rs.getString(11);
                String role = "User";
                user = new User(id, username, password, email, role, fName, lName, address, phone, sex, DOB, money);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

//--------------------------------------------------------------------------------------------
    // Phương thức để lấy ID lớn nhất hiện có
    public String getMaxUserId() {
        String maxId = null;
        String query = "SELECT MAX(CAST(SUBSTRING(UserId, 3, LEN(UserId) - 2) AS INT)) AS maxId FROM Users WHERE UserId LIKE 'US%'";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                maxId = rs.getString("maxId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return maxId;
    }

    // Phương thức để tìm các ID bị thiếu
    public TreeSet<Integer> findMissingIds() {
        TreeSet<Integer> missingIds = new TreeSet<>();
        String query = "SELECT CAST(SUBSTRING(UserId, 3, LEN(UserId) - 2) AS INT) AS numId FROM Users WHERE UserId LIKE 'US%' ORDER BY numId";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            int expectedId = 1;
            while (rs.next()) {
                int actualId = rs.getInt("numId");
                while (expectedId < actualId) {
                    missingIds.add(expectedId);
                    expectedId++;
                }
                expectedId++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return missingIds;
    }

    // Phương thức để tạo ID mới hoặc lấy lại ID bị thiếu
    public String generateNewUserId() {
        TreeSet<Integer> missingIds = findMissingIds();
        if (!missingIds.isEmpty()) {
            // Lấy ID nhỏ nhất bị thiếu
            int smallestMissingId = missingIds.first();
            return String.format("US%04d", smallestMissingId);
        }

        // Nếu không có ID nào bị thiếu, tạo ID mới dựa trên ID lớn nhất hiện có
        String maxId = getMaxUserId();
        if (maxId == null) {
            return "US0001"; // ID khởi tạo đầu tiên nếu không có bản ghi nào
        }

        // Tăng phần số của ID lên 1
        int numericId = Integer.parseInt(maxId) + 1;
        return String.format("US%04d", numericId);
    }

    // Phương thức để thêm người dùng mới
    public void insert(User user) {
        String newUserId = generateNewUserId();
        user.setUserID(newUserId);
        String sql = "INSERT INTO Users (UserId, Username, Pass, Role, Email) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, user.getUserID());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getEmail());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//-----------------------------------------------------------------------------------
    public User updateeUser(User user) {
        String query = "UPDATE Users SET username=?, password=? WHERE UserId=?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            int rc = stmt.executeUpdate();
            if (rc == 0) {
                throw new SQLException("Update failed, no rows affected.");
            }
            return user;

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Invalid data");
        }
    }

    public boolean updateUser(User user) {
        boolean result = false;
        String sql = "UPDATE Users SET pass=?, email=?, fName=?, lName=?, address=?, phone=?, sex=?, DateOfBirth=?, username =? WHERE userID=?";
        try (Connection conn = getConnect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getfName());
            stmt.setString(4, user.getlName());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getSex());
            stmt.setString(8, user.getDob());
            stmt.setString(9, user.getUsername());
            stmt.setString(10, user.getUserID());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public User getUserFromSession(HttpSession session, HttpServletRequest request) {
        String userName = (String) session.getAttribute("user");
        String pass = (String) session.getAttribute("pass");

        if (userName == null || pass == null) {
            // Check cookies only if session attributes are not present
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user")) userName = cookie.getValue();
                    if (cookie.getName().equals("pass")) pass = cookie.getValue();
                }
            }
        }

        if (userName != null && pass != null) {
            return getUsers(userName, pass); // Assuming this method fetches the User object
        }
        return null; // or throw an exception if user not found
    }

//--------------------------------------------------------------------------------
//    public static int deleteUser(String userId) {
//        String query = "DELETE FROM Users WHERE UserId=?";
//
//        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
//
//            stmt.setString(1, userId);
//            return stmt.executeUpdate();
//
//        } catch (Exception ex) {
//            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
////--------------------------------------------------------------------------------------------
//
//    public static ArrayList<Users> searchUsers(Predicate<Users> p) {
//        ArrayList<Users> list = listAllUsers();
//        ArrayList<Users> res = new ArrayList<>();
//
//        for (Users user : list) {
//            if (p.test(user)) {
//                res.add(user);
//            }
//        }
//        return res;
//    }
//    public static ArrayList<Users> listAllUsers() {
//        ArrayList<Users> list = new ArrayList<>();
//        String query = "SELECT UserId, username, password FROM Users";
//
//        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
//
//            while (rs.next()) {
//                list.add(new Users(
//                        //rs.getString("UserId"),
//                        rs.getString("username"),
//                        rs.getString("password")
//                ));
//            }
//
//        } catch (Exception ex) {
//            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return list;
//    }
////--------------------------------------------------------------------------------------------
//
//    public static void main(String[] args) {
//        ArrayList<Users> list = UserDB.listAllUsers();
//        for (Users user : list) {
//            System.out.println(user);
//        }
//    }
//---------------------------------------------------------------------------
}
