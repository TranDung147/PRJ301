/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookingRoomDB;
import DAO.BookingTicketDB;
import DAO.RoomDB;
import DAO.UserDashBoardDB;
import Model.BookingRoom;
import Model.BookingRoomDetail;
import Model.BookingTicket;
import Model.BookingTicketDetail;
import Model.HotelBooking;
import Model.PlaneBooking;
import Model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            showRoomBookingDetail(request, response);
        } else if ("viewTicket".equals(action)) {
            showTicketBookingDetail(request, response);
        } else if ("delete".equals(action)) {
            deleteRoomBooking(request, response);
        } else if ("deleteTicket".equals(action)) {
            deleteTicketBooking(request, response);
        } else if ("order".equals(action)) {
            orderRoomBooking(request, response);
        } else if ("orderTicket".equals(action)) {
            orderTicketBooking(request, response);
        } else if ("deleteDetail".equals(action)) {
            deleteDetail(request, response);
        } else {
            response.sendRedirect("error.jsp"); // Thay thế bằng URL của trang lỗi của bạn
        }
    }

    protected void showRoomBookingDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomBookingID = request.getParameter("roomBookingID");
        if (roomBookingID != null && !roomBookingID.trim().isEmpty()) {
            UserDashBoardDB a = new UserDashBoardDB();
            List<HotelBooking> hotelBookings = a.getAllHotelBookings(roomBookingID);

            request.setAttribute("bookingDetails", hotelBookings);
            request.setAttribute("roomBookingID", roomBookingID);

            // Chuyển tiếp đến trang JSP hiển thị chi tiết của booking
            request.getRequestDispatcher("includes/servlet/userdb/CartDetail.jsp").forward(request, response);
        } else {
            // Xử lý nếu roomBookingID không hợp lệ
            response.sendRedirect("UserServlet?action=booking");
        }
    }

    protected void showTicketBookingDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketBookingID = request.getParameter("ticketBookingID");
        if (ticketBookingID != null && !ticketBookingID.trim().isEmpty()) {
            UserDashBoardDB b = new UserDashBoardDB();
            List<PlaneBooking> planeBookings = b.getAllPlaneBookings(ticketBookingID);

            request.setAttribute("ticketDetails", planeBookings);
            request.setAttribute("ticketBookingID", ticketBookingID);

            request.getRequestDispatcher("includes/servlet/userdb/CartDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("UserServlet?action=booking");
        }
    }

    protected void deleteRoomBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomBookingID = request.getParameter("roomBookingID");
        if (roomBookingID != null && !roomBookingID.trim().isEmpty()) {
            UserDashBoardDB a = new UserDashBoardDB();
            boolean successa = a.deleteRoomBookingDetailByID(roomBookingID);
            boolean successb = a.deleteRoomBookingByID(roomBookingID);

            if (successa && successb) {
                response.sendRedirect("UserServlet?action=booking");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    protected void deleteTicketBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketBookingID = request.getParameter("ticketBookingID");
        if (ticketBookingID != null && !ticketBookingID.trim().isEmpty()) {
            UserDashBoardDB a = new UserDashBoardDB();
            boolean successc = a.deleteTicketBookingByID(ticketBookingID);
            boolean successa = a.deleteTicketBookingDetailByID(ticketBookingID);
            boolean successb = a.deleteTicketBookingByID(ticketBookingID);

            if (successa && successb && successc) {
                response.sendRedirect("UserServlet?action=booking");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    protected void orderRoomBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomBookingID = request.getParameter("roomBookingID");
        String userID = (String) request.getSession().getAttribute("id");
        if (roomBookingID != null && !roomBookingID.trim().isEmpty()) {
            UserDashBoardDB a = new UserDashBoardDB();
            boolean successa = a.updateBookingRoomStatus(roomBookingID);
            boolean successb = a.updateBookingRoomDetailStatus(roomBookingID);

            BookingRoomDB brdb = new BookingRoomDB();
            BookingRoom br = brdb.getBookingRoomByRoomBookingID(roomBookingID);
            boolean c = a.insertTranRoom(userID, roomBookingID, br.getTotalPrice());

            if (successa && successb && c) {
                response.sendRedirect("thanhtoan");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    protected void orderTicketBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketBookingID = request.getParameter("ticketBookingID");
        String userID = (String) request.getSession().getAttribute("id");
        if (ticketBookingID != null && !ticketBookingID.trim().isEmpty()) {
            UserDashBoardDB db = new UserDashBoardDB();
            boolean a = db.updateBookingTicketStatus(ticketBookingID);
            boolean b = db.updateBookingTicketDetailStatus(ticketBookingID);
            boolean c = db.updateSeatAvailability(ticketBookingID);

            BookingTicketDB btdb = new BookingTicketDB();
            BookingTicket bt = btdb.getBookingTicketByBookingTicketID(ticketBookingID);
            boolean d = db.insertTranTicket(userID, ticketBookingID, bt.getTotalPrice());

            if (a && b && c && d) {
                response.sendRedirect("thanhtoan");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    protected void deleteDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomNumber = request.getParameter("roomNumber");
        String seatNumber = request.getParameter("seatNumber");
        String userID = (String) request.getSession().getAttribute("id");

        if (roomNumber != null && !roomNumber.trim().isEmpty()) {

            UserDashBoardDB a = new UserDashBoardDB();
            BookingRoomDetail brd = a.deleteRoomDetailByNumber(roomNumber, userID);
            BookingRoom br = a.getBookingRoomById(brd.getRoomBookingID());

            // Chuyển đổi chuỗi thành BigDecimal rồi trừ rồi chuyển lại String
            BigDecimal totalPrice = new BigDecimal(br.getTotalPrice());
            BigDecimal price = new BigDecimal(brd.getPrice());
            BigDecimal result = totalPrice.subtract(price);
            String resultStr = result.toString();

            boolean success = a.updatePriceBRoomAfterDeleteBRoomDetail(brd.getRoomBookingID(), resultStr);

            if (success) {
                response.sendRedirect("UserServlet?action=booking");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else if (seatNumber != null && !seatNumber.trim().isEmpty()) {

            UserDashBoardDB a = new UserDashBoardDB();
            BookingTicketDetail btd = a.deleteTicketDetailByNumber(seatNumber, userID);
            BookingTicket bt = a.getBookingTicketById(btd.getBookingTicketID());

            // Chuyển đổi chuỗi thành BigDecimal rồi trừ rồi chuyển lại String
            BigDecimal totalPrice = new BigDecimal(bt.getTotalPrice());
            BigDecimal price = new BigDecimal(btd.getPrice());
            BigDecimal result = totalPrice.subtract(price);
            String resultStr = result.toString();

            boolean success = a.updatePriceBTicketAfterDeleteBTicketDetail(btd.getBookingTicketID(), resultStr);

            if (success) {
                response.sendRedirect("UserServlet?action=booking");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
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
