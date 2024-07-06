
package Controller;

import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "Order"; // Default action
        }

        switch (action.toLowerCase()) {
            case "detail":
                handleDetail(request, response);
                break;
            case "order":
                handleOrder(request, response);
                break;
            case "action":
                handleAction(request, response);
                break;
            case "remove":
                handleRemove(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String detailType = request.getParameter("detailType");
        HotelDB h = new HotelDB();
        PlaneDB p = new PlaneDB();
        FlightDB f = new FlightDB();
        RoomDB r = new RoomDB();
        SeatDB s = new SeatDB();

        switch (detailType) {
            case "Hotel":
                ArrayList<Hotel> hotels = h.listAll();
                request.setAttribute("hotels", hotels);
                break;
            case "Plane":
                ArrayList<Plane> planes = (ArrayList<Plane>) p.getAllPlanes();
                request.setAttribute("planes", planes);
                break;
            case "Flight":
                ArrayList<Flight> flights = (ArrayList<Flight>) f.getAllFlights();
                request.setAttribute("flights", flights);
                break;
            case "Room":
                ArrayList<Room> rooms = r.getAllRooms();
                request.setAttribute("rooms", rooms);
                break;
            case "Seat":
                ArrayList<Seat> seats = (ArrayList<Seat>) s.getAllSeats();
                request.setAttribute("seats", seats);
                break;
            default:
                // Handle default case if necessary
                break;
        }

        request.getRequestDispatcher("includes/servlet/adminDetails.jsp").forward(request, response);
    }

    private void handleOrder(HttpServletRequest request, HttpServletResponse response)
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

    private void handleAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String type = request.getParameter("type");
        String action = request.getParameter("action"); // "approve" hoặc "decline"

        AllBookingDB db = new AllBookingDB();
        boolean success = false;
        try {
            String status = null;
            if ("approve".equals(action)) {
                status = "Approved";
            } else if ("decline".equals(action)) {
                status = "Declined";
            }

            if (status != null) {
                if ("room".equals(type)) {
                    success = db.updateRoomOrderStatus(orderId, status);
                } else if ("ticket".equals(type)) {
                    success = db.updateTicketOrderStatus(orderId, status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
        response.sendRedirect(request.getContextPath() + "/adminOrder.jsp");

    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String bookingType = request.getParameter("bookingType");

        AllBookingDB db = new AllBookingDB();

        // Determine the type of booking and perform the removal
        if ("room".equals(bookingType)) {
            db.removeBookingRoom(bookingId);
        } else if ("ticket".equals(bookingType)) {
            db.removeBookingTicket(bookingId);
        }

        // Redirect back to adminOrderHistory.jsp or any other appropriate page
        response.sendRedirect("adminOrderHistory.jsp");

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
    
    //--------------------------------------------------------------------------------------------

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
