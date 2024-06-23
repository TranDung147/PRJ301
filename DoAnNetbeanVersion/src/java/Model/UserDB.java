package Model;

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

    public User getUser(String username, String password) {
        User user = null;
        String query = "select Username, Pass, Role , UserID, Email from Users where Username =?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // String id = rs.getString("UserId");
                username = rs.getString(1);
                password = rs.getString(2);
                String role = rs.getString(3);
                String id = rs.getString(4);
                String email = rs.getString(5);
                user = new User(username, password, role, email, id);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public User getUsers(String username, String password) {
        User user = null;
        String query = "select Username, Pass, FName , LName , UserID, Email from Users where Username =?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // String id = rs.getString("UserId");
                username = rs.getString(1);
                password = rs.getString(2);
                String fName = rs.getString(3);
                String lName = rs.getString(4);
                String id = rs.getString(5);
                String email = rs.getString(6);
                user = new User(id, username, password, email, fName, lName);
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
    
    // Kiểm tra mật khẩu
    public boolean checkPassword(String username, String password) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean isValid = false;

        try {
            con = getConnect();
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu có kết quả từ cơ sở dữ liệu, tức là mật khẩu đúng
                isValid = true;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return isValid;
    }

    // Hàm đổi mật khẩu
    public boolean changePassword(String username, String newPassword) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean success = false;

        try {
            con = getConnect(); // DBConnection là lớp để lấy kết nối tới cơ sở dữ liệu
            String query = "UPDATE users SET password = ? WHERE username = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, username);

            int result = ps.executeUpdate();
            if (result > 0) {
                // Nếu có ít nhất một dòng bị ảnh hưởng, tức là cập nhật thành công
                success = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return success;
    }

    
//-----------------------------------------------------------------------------------
//
//    public static Users updateUser(Users user) {
//        String query = "UPDATE Users SET username=?, password=? WHERE UserId=?";
//
//        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
//
//            stmt.setString(1, user.getUsername());
//            stmt.setString(2, user.getPassword());
//            stmt.setString(3, user.getUserId());
//
//            int rc = stmt.executeUpdate();
//            if (rc == 0) {
//                throw new SQLException("Update failed, no rows affected.");
//            }
//            return user;
//
//        } catch (Exception ex) {
//            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
//            throw new RuntimeException("Invalid data");
//        }
//    }
//
////--------------------------------------------------------------------------------
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
