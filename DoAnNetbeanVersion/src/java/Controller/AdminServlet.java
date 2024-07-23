/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.*;
import Model.*;
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
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "viewDetails":
                handleViewDetails(request, response);
                break;
            case "approveOrder":
                handleApproveOrder(request, response);
                break;
            case "removeOrderHistory":
                handleRemoveOrderHistory(request, response);
                break;
            case "fetchDetails":
                handleFetchDetails(request, response);
                break;
            case "orderAction":
                orderAction(request, response);
                break;
            case "display":
                displayOrders(request, response);
                break;
        }
    }

    private void handleViewDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String transactionId = request.getParameter("transactionId");
        String roomBookingId = request.getParameter("roomBookingId");
        String ticketBookingId = request.getParameter("ticketBookingId");

        if (roomBookingId != null && !roomBookingId.isEmpty() && ticketBookingId != null && !ticketBookingId.isEmpty()) {
            response.sendRedirect("adminViewDetails.jsp?transactionId=" + transactionId + "&roomBookingId=" + roomBookingId + "&ticketBookingId=" + ticketBookingId);
        } else if (roomBookingId != null && !roomBookingId.isEmpty()) {
            response.sendRedirect("adminViewDetails.jsp?transactionId=" + transactionId + "&roomBookingId=" + roomBookingId);
        } else if (ticketBookingId != null && !ticketBookingId.isEmpty()) {
            response.sendRedirect("adminViewDetails.jsp?transactionId=" + transactionId + "&ticketBookingId=" + ticketBookingId);
        }
    }

    private void handleApproveOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String transactionId = request.getParameter("transactionId");
        String ticketBookingID = request.getParameter("ticketBookingId");
        UserDashBoardDB udbdb = new UserDashBoardDB();

        TransactionDB trandb = new TransactionDB();
        trandb.updateTransactionStatus(transactionId, "Approved");
        udbdb.updateBookingTicketStatus(ticketBookingID, "Confirmed");
        response.sendRedirect("adminOrder.jsp");
    }

    private void handleRemoveOrderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String transactionId = request.getParameter("transactionId");
        String roomBookingId = request.getParameter("roomBookingId");
        String ticketBookingId = request.getParameter("ticketBookingId");

        TransactionDB transactionDB = new TransactionDB();
        transactionDB.removeTransaction(transactionId, roomBookingId, ticketBookingId);

        UserDashBoardDB dashboardDB = new UserDashBoardDB();
        dashboardDB.deleteRoomBookingDetailByID(roomBookingId);
        dashboardDB.deleteRoomBookingByID(roomBookingId);
        dashboardDB.updateSeatAvailabilityToTrue(ticketBookingId);
        dashboardDB.deleteTicketBookingDetailByID(ticketBookingId);
        dashboardDB.deleteTicketBookingByID(ticketBookingId);

        response.sendRedirect("adminOrderHistory.jsp");
    }

    private void handleFetchDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String detailType = request.getParameter("detailType");
        switch (detailType) {
            case "Hotel":
                HotelDB h = new HotelDB();
                ArrayList<Hotel> hotels = h.listAll();
                request.setAttribute("hotels", hotels);
                break;
            case "Plane":
                PlaneDB p = new PlaneDB();
                ArrayList<Plane> planes = (ArrayList<Plane>) p.getAllPlanes();
                request.setAttribute("planes", planes);
                break;
            case "Flight":
                FlightDB f = new FlightDB();
                ArrayList<Flight> flights = (ArrayList<Flight>) f.getAllFlights();
                request.setAttribute("flights", flights);
                break;
            case "Room":
                RoomDB r = new RoomDB();
                ArrayList<Room> rooms = r.getAllRooms();
                request.setAttribute("rooms", rooms);
                break;
            case "Seat":
                SeatDB s = new SeatDB();
                ArrayList<Seat> seats = (ArrayList<Seat>) s.getAllSeats();
                request.setAttribute("seats", seats);
                break;
            default:
                // Handle default case if necessary
                break;
        }
        request.getRequestDispatcher("includes/servlet/adminDetails.jsp").forward(request, response);
    }

    private void displayOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BookingRoomDetail> roomOrders = new ArrayList<>();
        List<BookingTicketDetail> ticketOrders = new ArrayList<>();
        BookingRoomDetailDB brd = new BookingRoomDetailDB();
        BookingTicketDetailDB btd = new BookingTicketDetailDB();

        try {
            roomOrders = brd.getAllBookingRoomDetails();
            ticketOrders = btd.getAllBookingTicketDetails();

            request.setAttribute("roomOrders", roomOrders);
            request.setAttribute("ticketOrders", ticketOrders);
            request.getRequestDispatcher("adminOrder.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void orderAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("subAction");
        String transactionId = request.getParameter("transactionId");
        String roomBookingId = request.getParameter("roomBookingId");
        String ticketBookingId = request.getParameter("ticketBookingId");

        if ("viewDetails".equals(action)) {
            handleViewDetails(request, response);
        } else if ("approve".equals(action)) {
            handleApproveOrder(request, response);
        } else if ("removeOrderHistory".equals(action)) {
            handleRemoveOrderHistory(request, response);
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
