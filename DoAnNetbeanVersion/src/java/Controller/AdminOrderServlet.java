/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.AllBookingDB;
import Model.BookingRoomDetail;
import Model.BookingTicketDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class AdminOrderServlet extends HttpServlet {

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
        List<BookingRoomDetail> roomOrders = new ArrayList<>();
        List<BookingTicketDetail> ticketOrders = new ArrayList<>();
        AllBookingDB a = new AllBookingDB();
        AllBookingDB b = new AllBookingDB();

        try {
            roomOrders = a.getAllBookingRoomDetails();
            ticketOrders = b.getAllBookingTicketDetails();

            request.setAttribute("roomOrders", roomOrders);
            request.setAttribute("ticketOrders", ticketOrders);
            request.getRequestDispatcher("adminOrder.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void acceptOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomBookingIDStr = request.getParameter("roomBookingID");
        int roomBookingID = Integer.parseInt(roomBookingIDStr);

        // Update database logic here
        // Example: Update the order status to "Confirmed" using your DAO methods
        // Redirect back to adminOrder.jsp after processing
        response.sendRedirect(request.getContextPath() + "/adminOrder.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("approve")) {
            acceptOrder(request, response);
        } else {
            processRequest(request, response);
        }
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
