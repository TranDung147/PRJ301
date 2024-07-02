/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.AllBookingDB;
import Model.RoomDB;
import Model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class CheckBookedServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckBookedServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckBookedServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json;charset=UTF-8");
        
        // Lấy hotelID từ request hoặc từ cấu hình servlet
        String hotelID = request.getParameter("hotelID"); // Hoặc có thể lấy từ cấu hình servlet như getServletConfig().getInitParameter("hotelID");

        RoomDB roomDB = new RoomDB();
        AllBookingDB book = new AllBookingDB();
        List<JSONObject> bookings = new ArrayList<>();

        // Lấy danh sách các phòng theo hotelID
        List<Room> rooms = RoomDB.getRoomsByHotel(hotelID);
        for (Room room : rooms) {
            String roomID = room.getRoomID();
            List<String> roomBookingIDs = book.getRoomBookingIDsByRoomID(roomID);
            for (String roomBookingID : roomBookingIDs) {
                List<Date[]> bookedDates = book.getDateFromToDateByRoomBookingID(roomBookingID);
                for (Date[] dates : bookedDates) {
                    Date dateFrom = dates[0];
                    Date dateTo = dates[1];
                    
                    // Tạo JSON object cho mỗi đặt phòng
                    JSONObject booking = new JSONObject();
                    booking.put("roomID", roomID);
                    booking.put("checkInDate", dateFrom);
                    booking.put("checkOutDate", dateTo);
                    
                    bookings.add(booking);
                }
            }
        }

        // Tạo JSON response từ danh sách JSON object đã tạo
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("bookings", bookings);
        jsonResponse.put("success", true);

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
