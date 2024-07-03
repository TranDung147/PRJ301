/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.UserDB;
import Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.System.Logger;
import java.net.URLEncoder;

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
            case "change":
                handleChange(request, response);
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
                String encodedURL = response.encodeRedirectURL("index.jsp");
                response.sendRedirect(encodedURL);

            } else {
                // Invalid role, handle accordingly

            }
        } else {
            request.setAttribute("errorMessage", "Wrong username or password. Please try again");
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
        response.sendRedirect("index.jsp");
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
            response.sendRedirect("index.jsp");
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

    private void handleChange(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String sex = request.getParameter("sex");
        String dob = request.getParameter("dob");

// Split full name into first name and last name
        String[] nameParts = fullname.split("\\s+", 2); // Split by whitespace, limit to 2 parts
        String fname = nameParts[0]; // First part is first name
        String lname = (nameParts.length > 1) ? nameParts[1] : ""; // Second part is last name, or empty if not provided

// Create a User object with updated information
        User updatedUser = new User(username, password, email, fname, lname, address, phone, sex, dob);

        // Update user data in the database
        UserDB userDB = new UserDB();
        boolean success = userDB.updateUser(updatedUser);

        if (success) {
            // Redirect to a success page or dashboard
            response.sendRedirect("userDBoard.jsp"); // Example redirect to dashboard page
        } else {
            // Handle failure (e.g., display an error message)
            request.setAttribute("errorMessage", "Failed to update user information.");
            RequestDispatcher rd = request.getRequestDispatcher("updateinfo.jsp");
            rd.forward(request, response);
        }
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
