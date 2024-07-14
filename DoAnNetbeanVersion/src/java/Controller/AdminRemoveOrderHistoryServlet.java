/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookingRoomDetailDB;
import DAO.BookingTicketDetailDB;
import DAO.TransactionDB;
import DAO.UserDashBoardDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author NOMNOM
 */
public class AdminRemoveOrderHistoryServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        String transactionId = request.getParameter("transactionId");
        String roomBookingId = request.getParameter("roomBookingId");
        String ticketBookingId = request.getParameter("ticketBookingId");

        if ("viewDetails".equals(action)) {
            if (roomBookingId != null && !roomBookingId.isEmpty() && ticketBookingId != null && !ticketBookingId.isEmpty()) {
                response.sendRedirect("viewBothDetailsFragment.jsp?transactionId=" + transactionId + "&roomBookingId=" + roomBookingId + "&ticketBookingId=" + ticketBookingId);
            } else if (roomBookingId != null && !roomBookingId.isEmpty()) {
                response.sendRedirect("viewRoomDetailsFragment.jsp?transactionId=" + transactionId + "&roomBookingId=" + roomBookingId);
            } else if (ticketBookingId != null && !ticketBookingId.isEmpty()) {
                response.sendRedirect("viewTicketDetailsFragment.jsp?transactionId=" + transactionId + "&ticketBookingId=" + ticketBookingId);
            }
        }
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
        String transactionId = request.getParameter("transactionId");
        String roomBookingId = request.getParameter("roomBookingId");
        String ticketBookingId = request.getParameter("ticketBookingId");

        // Gọi hàm removeTransaction từ TransactionDB
        TransactionDB transactionDB = new TransactionDB();
        transactionDB.removeTransaction(transactionId, roomBookingId, ticketBookingId);

        UserDashBoardDB a = new UserDashBoardDB();
        a.deleteRoomBookingDetailByID(roomBookingId);
        a.deleteRoomBookingByID(roomBookingId);

        UserDashBoardDB b = new UserDashBoardDB();
        b.updateSeatAvailabilityToTrue(ticketBookingId);
        b.deleteTicketBookingDetailByID(ticketBookingId);
        b.deleteTicketBookingByID(ticketBookingId);

        response.sendRedirect("adminOrderHistory.jsp");
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
