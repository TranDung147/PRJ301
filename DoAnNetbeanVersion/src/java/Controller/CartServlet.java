package Controller;

import Model.AllBookingDB;
import Model.BookingTicketDetail;
import Model.Room;
import Model.Seat;
import Model.RoomDB;
import Model.SeatDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        HttpSession session = request.getSession();
//        ArrayList<Hotel> cart = (ArrayList<Hotel>) session.getAttribute("cart");
//        if (cart == null) {
//            cart = new ArrayList<>();
//            session.setAttribute("cart", cart);
//        }
//
//        String id =request.getParameter("HotelId");
//        String name = request.getParameter("HotelName");
//        String descrip = request.getParameter("HotelDescription");
//
//        System.out.println("Adding to cart: ID=" + id + ", Name=" + name + ", Price=" + price + ", Quantity=" + quantity);
//
//        HotelDB hotelDB = new HotelDB();
//        Hotel fruit = fruitDB.getHotelById(id);
//
//        if (fruit == null) {
//            Hotel c1 = new Hotel(id, name, null, price, quantity);
//            if (c1.getQuantity() >= quantity) {
//                c1.setQuantity(c1.getQuantity() - quantity);
//                //fruitDB.updateHotelQuantity(id, c1.getQuantity());
//
//                boolean itemExists = false;
//                for (Hotel item : cart) {
//                    if (item.getProductId() == id) {
//                        item.setQuantity(item.getQuantity() + quantity);
//                        itemExists = true;
//                        break;
//                    }
//                }
//
//                if (!itemExists) {
//                    Hotel newItem = new Hotel(id, name, null, price, quantity);
//                    cart.add(newItem);
//                }
//                session.setAttribute("cart", cart);
//                response.sendRedirect("AddToCart.jsp");
//            } else {
//                response.sendRedirect("table_product.jsp?error=out_of_stock");
//            }
//        } else {
//            System.out.println("Hotel with ID " + id + " was not found.");
//            response.sendRedirect("table_product.jsp?error=fruit_not_found");
//        }
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
//        String roomID = request.getParameter("roomID");
//
//        // Assume RoomDB.bookRoom(roomID) returns the booked room
//        Room bookedRoom = RoomDB.bookRoom(roomID);
//        JSONObject jsonResponse = new JSONObject();
//
//        if (bookedRoom != null) {
//            jsonResponse.put("success", true);
//            jsonResponse.put("message", "Room booked successfully.");
//            // Put bookedRoom into session
//            HttpSession session = request.getSession();
//            session.setAttribute("bookedRoom", bookedRoom);
//        } else {
//            jsonResponse.put("success", false);
//            jsonResponse.put("message", "Booking failed. Please try again.");
//        }
//
//        // Send JSON response
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//
//        PrintWriter out = response.getWriter();
//        out.print(jsonResponse.toString());
//        out.flush();

//        String roomID = request.getParameter("roomID");
//        String checkInDate = request.getParameter("checkInDate");
//        String checkOutDate = request.getParameter("checkOutDate");
//        String user = (String) request.getSession().getAttribute("user");
//        String userID = (String) request.getSession().getAttribute("id");
//        if (user == null) {
//            JSONObject jsonResponse = new JSONObject();
//            jsonResponse.put("success", false);
//            jsonResponse.put("message", "User not logged in.");
//            response.setContentType("application/json");
//            PrintWriter out = response.getWriter();
//            out.print(jsonResponse.toString());
//            out.flush();
//            return;
//        }
//
//        Room bookedRoom = RoomDB.bookRoom(roomID);
//        if (bookedRoom != null) {
//            String roomBookingID = AllBookingDB.insertBookingRoom(userID, null);
//            boolean isBookingDetailInserted = AllBookingDB.insertBookingRoomDetail(roomBookingID, roomID, null, checkInDate, checkOutDate, "Pending");
//            if (isBookingDetailInserted) {
//                HttpSession session = request.getSession();
//                session.setAttribute("bookedRoom", bookedRoom);
//                JSONObject jsonResponse = new JSONObject();
//                jsonResponse.put("success", true);
//                jsonResponse.put("message", "Room booked successfully.");
//                response.setContentType("application/json");
//                PrintWriter out = response.getWriter();
//                out.print(jsonResponse.toString());
//                out.flush();
//            } else {
//                JSONObject jsonResponse = new JSONObject();
//                jsonResponse.put("success", false);
//                jsonResponse.put("message", "Failed to insert booking detail.");
//                
//                response.setContentType("application/json");
//                PrintWriter out = response.getWriter();
//                out.print(jsonResponse.toString());
//                out.flush();
//            }
//        } else {
//            JSONObject jsonResponse = new JSONObject();
//            jsonResponse.put("success", false);
//            jsonResponse.put("message", "Room not found or already booked.");
//
//            response.setContentType("application/json");
//            PrintWriter out = response.getWriter();
//            out.print(jsonResponse.toString());
//            out.flush();
//        }
        String user = (String) request.getSession().getAttribute("user");
        String userID = (String) request.getSession().getAttribute("id");
        String roomID = request.getParameter("roomID");
        String seatID = request.getParameter("seatID");

        if (user == null) {
            sendErrorResponse(response, "User not logged in.");
            return;
        }

        if (seatID != null) {
            handleSeatBooking(request, response, userID, seatID);
        } else if (roomID != null) {
            handleRoomBooking(request, response, userID, roomID);
        } else {
            sendErrorResponse(response, "Invalid booking request.");
        }
    }

    private void handleRoomBooking(HttpServletRequest request, HttpServletResponse response, String userID, String roomID) throws IOException {
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");

        Room bookedRoom = RoomDB.bookRoom(roomID);
        if (bookedRoom != null) {
            String roomBookingID = AllBookingDB.insertBookingRoom(userID, null);
            boolean isBookingDetailInserted = AllBookingDB.insertBookingRoomDetail(roomBookingID, roomID, null, checkInDate, checkOutDate, "Booked");
            sendBookingResponse(request, response, isBookingDetailInserted, bookedRoom, null, "Room booked successfully.", "Failed to insert booking detail.");
        } else {
            sendErrorResponse(response, "Room not found or already booked.");
        }
    }

    private void handleSeatBooking(HttpServletRequest request, HttpServletResponse response, String userID, String seatID) throws IOException {
        Seat bookedSeat = SeatDB.bookSeat(seatID);
        if (bookedSeat != null) {
            try {
                String seatBookingID = SeatDB.insertBookingSeat(userID, null, "1");
                boolean isBookingDetailInserted = SeatDB.insertBookingTicketDetail(seatBookingID, seatID, null, "Booked");
                List<BookingTicketDetail> bookingTicketDetails = AllBookingDB.getBookingTicketDetailsBySeatID(seatID);
                sendBookingResponse(request, response, isBookingDetailInserted, bookedSeat, bookingTicketDetails, "Seat booked successfully.", "Failed to insert booking detail.");
            } catch (ParseException ex) {
                Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
                sendErrorResponse(response, "Error processing booking.");
            }
        } else {
            sendErrorResponse(response, "Seat not found or already booked.");
        }
    }

    private void sendBookingResponse(HttpServletRequest request, HttpServletResponse response, boolean success, Object bookedItem, List<BookingTicketDetail> bookingTicketDetails, String successMessage, String failureMessage) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("bookedItem", bookedItem);

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", success);
        jsonResponse.put("message", success ? successMessage : failureMessage);

        if (bookedItem instanceof Seat && bookingTicketDetails != null && !bookingTicketDetails.isEmpty()) {
            session.setAttribute("bookingTicketDetails", bookingTicketDetails);
        } else if (bookedItem instanceof Room) {
            Room bookedRoom = (Room) bookedItem;
            request.setAttribute("rooms", bookedRoom);
        }
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    private void sendErrorResponse(HttpServletResponse response, String errorMessage) throws IOException {
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", false);
        jsonResponse.put("message", errorMessage);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
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
