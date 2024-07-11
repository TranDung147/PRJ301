/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDashBoardDB;
import Model.HotelBooking;
import Model.PlaneBooking;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
            boolean successa = a.deleteTicketBookingDetailByID(ticketBookingID);
            boolean successb = a.deleteTicketBookingByID(ticketBookingID);

            if (successa && successb) {
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
        String userID = (String) request.getSession().getAttribute("userID");
        if (roomBookingID != null && !roomBookingID.trim().isEmpty()) {
            UserDashBoardDB a = new UserDashBoardDB();
            boolean successa = a.orderRoomBookingDetailByID(roomBookingID);
            boolean successb = a.orderRoomBookingByID(roomBookingID);

            if (successa && successb) {
                response.sendRedirect("UserServlet?action=booking");
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
        if (ticketBookingID != null && !ticketBookingID.trim().isEmpty()) {
            UserDashBoardDB a = new UserDashBoardDB();
            boolean successa = a.deleteTicketBookingDetailByID(ticketBookingID);
            boolean successb = a.deleteTicketBookingByID(ticketBookingID);

            if (successa && successb) {
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
