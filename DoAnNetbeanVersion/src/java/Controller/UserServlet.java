
package Controller;

import DAO.BookingRoomDB;
import DAO.BookingTicketDB;
import DAO.UserDB;
import Model.User;
import Model.BookingRoom;
import Model.BookingTicket;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "login"; // Default action
        }

        switch (action.toLowerCase()) {
            case "login":
                handleLogin(request, response);
                break;
            case "log out":
                handleLogout(request, response);
                break;
            case "signup":
                handleSignUp(request, response);
                break;
            case "db":
                handleDashBoard(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            case "booking":
                handleBooking(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("uname");
        String pass = request.getParameter("psw");

        UserDB db = new UserDB();
        User a = db.getUsers(user, pass);

        if (a != null && a.getPassword().equals(pass)) {
            if (a.getRole().equals("Admin")) {
                // Admin login
                HttpSession session = request.getSession();
                session.setAttribute("user", a.getUsername());
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("role", "admin");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("adminDBoard.jsp");
                response.sendRedirect(encodedURL);

            } else if (a.getRole().equals("User")) {
                // User login
                HttpSession session = request.getSession();
                session.setAttribute("user", a.getUsername());
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id", a.getUserID()); //added
                session.setAttribute("role", "user");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("Home");
                response.sendRedirect(encodedURL);

            } else {
                // Invalid role, handle accordingly

            }
        } else {
            request.setAttribute("errorMessage", "Wrong username or password. Please try again");
            request.getRequestDispatcher("Home").forward(request, response);
        }

    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Clear cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }

        // Invalidate the session if it exists
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Redirect to index page
        response.sendRedirect("Home");
    }

    private void handleSignUp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("uname");
            String email = request.getParameter("email");
            String password = request.getParameter("psw");
            String role = "User";
            String id = "1";

            UserDB db = new UserDB();
            User newUser = new User(username, password, role, email, id);
            db.insert(newUser);
            response.sendRedirect("Home");
        } catch (Exception e) {
            request.setAttribute("error", "Error adding user: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleDashBoard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("user");
        String password = (String) session.getAttribute("pass");

        UserDB userDB = new UserDB();
        User user = userDB.getUsers(username, password);

        request.setAttribute("user", user);

        RequestDispatcher dispatcher = request.getRequestDispatcher("userDBoard.jsp");
        dispatcher.forward(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String userID = request.getParameter("userID");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fName = request.getParameter("fName");
        String lName = request.getParameter("lName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String sex = request.getParameter("sex");
        String dob = request.getParameter("dob");

        // Tạo một đối tượng User
        User user = new User(userID, username, password, email, "User", fName, lName, address, phone, sex, dob);

        // Cập nhật thông tin người dùng trong cơ sở dữ liệu
        UserDB userDB = new UserDB();
        boolean isUpdated = userDB.updateUser(user);

        if (isUpdated) {
            // Nếu cập nhật thành công, lưu thông tin mới vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            session.setAttribute("pass", password);
            session.setAttribute("userDetails", user);

            // Chuyển hướng trở lại trang thông tin người dùng
            response.sendRedirect("customer.jsp");
        } else {
            // Xử lý nếu cập nhật thất bại
            response.sendRedirect("updateinfo.jsp?error=UpdateFailed");
        }
    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user");
        String pass = (String) session.getAttribute("pass");

        if (userName == null || pass == null) {
            response.sendRedirect("Home");
            return;
        }

        UserDB userDB = new UserDB();
        User user = userDB.getUsers(userName, pass);

        String id = user.getUserID();

        BookingRoomDB br = new BookingRoomDB();
        BookingTicketDB bt = new BookingTicketDB();
        
        List<BookingRoom> r = br.getAllUserBookingRooms(user.getUserID());
        List<BookingTicket> t = bt.getAllUserBookingTickets(user.getUserID());

        // Đặt thuộc tính cho JSP
        request.setAttribute("user", user);
        request.setAttribute("roombookings", r);
        request.setAttribute("ticketbooking", t);

        // Chuyển tiếp yêu cầu tới JSP
        request.getRequestDispatcher("bookingCart.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
