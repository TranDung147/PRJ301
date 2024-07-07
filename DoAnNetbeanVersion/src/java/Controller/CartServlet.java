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
        String price = "50.00"; // Giá cố định
        // Hàm để gắn giá trị cho id

        //Room bookedRoom = RoomDB.bookRoom(roomID);
        Room bookedRoom = RoomDB.getRoom(roomID);
        

        if (bookedRoom != null) {
            // Kiểm tra nếu đã có bookingRoomID cho ngày hôm nay
            String roomBookingID = AllBookingDB.getTodayBookingRoomID(userID);

            if (roomBookingID == null) {
                // Nếu không có, tạo mới với giá cố định
                roomBookingID = AllBookingDB.insertBookingRoom(userID, price);
            } else {
                // Nếu có, cập nhật tổng giá với giá cố định
                AllBookingDB.updateTotalPrice(roomBookingID, price);
            }

            // Thêm chi tiết booking cho roomBookingID hiện có hoặc mới tạo với giá cố định
            boolean isBookingDetailInserted = AllBookingDB.insertBookingRoomDetail(roomBookingID, roomID, price, checkInDate, checkOutDate, "Pending");
            sendBookingResponse(request, response, isBookingDetailInserted, bookedRoom, null, "Room booked successfully.", "Failed to insert booking detail.");
        } else {
            sendErrorResponse(response, "Room not found or already booked.");
        }
    }

    private void handleSeatBooking(HttpServletRequest request, HttpServletResponse response, String userID, String seatID) throws IOException {
        //Seat bookedSeat = SeatDB.bookSeat(seatID);
        Seat bookedSeat = SeatDB.getSeat(seatID);
        String price = "50.00";
        if (bookedSeat != null) {
            try {
                // Kiểm tra nếu đã có seatBookingID cho ngày hôm nay
                String seatBookingID = AllBookingDB.getTodayBookingSeatID(userID);

                if (seatBookingID == null) {
                    // Nếu không có, tạo mới
                    seatBookingID = AllBookingDB.insertBookingSeat(userID, price);
                } else {
                    // Nếu có, cập nhật tổng giá
                    AllBookingDB.updateSeatTotalPrice(seatBookingID, price);
                }

                // Thêm chi tiết booking cho seatBookingID hiện có hoặc mới tạo
                boolean isBookingDetailInserted = AllBookingDB.insertBookingTicketDetail(seatBookingID, seatID, price, "Pending");
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
