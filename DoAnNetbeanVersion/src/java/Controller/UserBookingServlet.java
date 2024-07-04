/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.AllBookingDB;
import Model.HotelBooking;
import Model.PlaneBooking;
import Model.User;
import Model.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class UserBookingServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user");
        String pass = (String) session.getAttribute("pass");

        if (userName == null || pass == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        UserDB userDB = new UserDB();
        User user = userDB.getUsers(userName, pass);

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        AllBookingDB bookingDB = new AllBookingDB();
        List<HotelBooking> hotelBookings = bookingDB.getAllHotelBookings(user.getUserID());
        List<PlaneBooking> planeBookings = bookingDB.getAllPlaneBookings(user.getUserID());

        // Đặt thuộc tính cho JSP
        request.setAttribute("user", user);
        request.setAttribute("hotelBookings", hotelBookings);
        request.setAttribute("planeBookings", planeBookings);

        // Chuyển tiếp yêu cầu tới JSP
        request.getRequestDispatcher("bookingCart.jsp").forward(request, response);
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
