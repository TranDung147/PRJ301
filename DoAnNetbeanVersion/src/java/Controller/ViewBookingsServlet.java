/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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
public class ViewBookingsServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewBookingsServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewBookingsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
//        BookingRoomDAO bookingRoomDAO = new BookingRoomDAO();
//        BookingRoomDetailDAO bookingRoomDetailDAO = new BookingRoomDetailDAO();
//        BookingTicketDAO bookingTicketDAO = new BookingTicketDAO();
//        BookingTicketDetailDAO bookingTicketDetailDAO = new BookingTicketDetailDAO();
//
//        List<BookingRoom> bookingRoomList = bookingRoomDAO.getAllBookings();
//        List<BookingRoomDetail> bookingRoomDetailList = bookingRoomDetailDAO.getAllBookingDetails();
//        List<BookingTicket> bookingTicketList = bookingTicketDAO.getAllBookings();
//        List<BookingTicketDetail> bookingTicketDetailList = bookingTicketDetailDAO.getAllBookingDetails();
//
//        request.setAttribute("bookingRoomList", bookingRoomList);
//        request.setAttribute("bookingRoomDetailList", bookingRoomDetailList);
//        request.setAttribute("bookingTicketList", bookingTicketList);
//        request.setAttribute("bookingTicketDetailList", bookingTicketDetailList);
//
//        request.getRequestDispatcher("viewBookings.jsp").forward(request, response);
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
