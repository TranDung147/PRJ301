/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.TransactionDB;
import DAO.UserDashBoardDB;
import Model.HotelBooking;
import Model.PlaneBooking;
import Model.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class TransactionActionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String transactionId = request.getParameter("transactionId");

        switch (action) {
            case "delete":
                deleteTransaction(request, response, transactionId);
                break;
            case "view":
                viewTransaction(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void deleteTransaction(HttpServletRequest request, HttpServletResponse response, String transactionId) throws IOException {
        String roomBookingID = request.getParameter("roomBookingID");
        String ticketBookingID = request.getParameter("ticketBookingID");
        if ((roomBookingID != null && !roomBookingID.trim().isEmpty()) || (ticketBookingID != null && !ticketBookingID.trim().isEmpty())) {
            
            TransactionDB c = new TransactionDB();
            boolean successe = c.deleteTransactionByID(transactionId);
            
            UserDashBoardDB a = new UserDashBoardDB();
            boolean successa = a.deleteRoomBookingDetailByID(roomBookingID);
            boolean successb = a.deleteRoomBookingByID(roomBookingID);

            UserDashBoardDB b = new UserDashBoardDB();
            boolean successf = b.updateSeatAvailabilityToTrue(ticketBookingID);
            boolean successc = b.deleteTicketBookingDetailByID(ticketBookingID);
            boolean successd = b.deleteTicketBookingByID(ticketBookingID);

            if ((successa && successb && successe) || (successc && successd && successe && successf)) {
                response.sendRedirect("thanhtoan");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }

    }

    private void viewTransaction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomBookingID = request.getParameter("roomBookingID");
        String ticketBookingID = request.getParameter("ticketBookingID");
        if ((roomBookingID != null && !roomBookingID.trim().isEmpty()) || (ticketBookingID != null && !ticketBookingID.trim().isEmpty())) {
            UserDashBoardDB a = new UserDashBoardDB();
            List<HotelBooking> hotelBookings = a.getAllHotelBookings(roomBookingID);

            UserDashBoardDB b = new UserDashBoardDB();
            List<PlaneBooking> planeBookings = b.getAllPlaneBookings(ticketBookingID);

            request.setAttribute("bookingDetails", hotelBookings);
            request.setAttribute("roomBookingID", roomBookingID);
            request.setAttribute("ticketDetails", planeBookings);
            request.setAttribute("ticketBookingID", ticketBookingID);
            

            // Chuyển tiếp đến trang JSP hiển thị chi tiết của booking
            request.getRequestDispatcher("includes/servlet/userdb/CartDetail.jsp").forward(request, response);
        } else {
            // Xử lý nếu roomBookingID không hợp lệ
            response.sendRedirect("UserServlet?action=booking");
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
