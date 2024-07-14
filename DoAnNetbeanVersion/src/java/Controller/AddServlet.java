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
import Model.*;
import DAO.*;
import java.sql.Date;

/**
 *
 * @author NOMNOM
 */
public class AddServlet extends HttpServlet {

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
        String objectType = request.getParameter("object");

        if ("hotel".equals(objectType)) {
            response.sendRedirect("add.jsp?object=hotel");
        } else if ("plane".equals(objectType)) {
            response.sendRedirect("add.jsp?object=plane");
        } else if ("flight".equals(objectType)) {
            response.sendRedirect("add.jsp?object=flight");
        } else if ("room".equals(objectType)) {
            response.sendRedirect("add.jsp?object=room");
        } else if ("seat".equals(objectType)) {
            response.sendRedirect("add.jsp?object=seat");
        } else {
            response.sendRedirect("errorPage.jsp");
        }
    }

    // Method to add a hotel
    private void addHotel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String hotelID = request.getParameter("hotelID");
        String hotelName = request.getParameter("hotelName");
        String hotelAddress = request.getParameter("hotelAddress");
        String hotelDescription = request.getParameter("hotelDescription");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String productImg = request.getParameter("productImg");

        if (hotelID == null || hotelName == null || hotelAddress == null || hotelDescription == null || city == null || country == null || productImg == null) {
            // Xử lý trường hợp có tham số bị null
            response.sendRedirect("errorPage.jsp");
            return;
        }

        Hotel hotel = new Hotel(hotelID, hotelName, hotelAddress, hotelDescription, city, country, productImg);
        HotelDB.insert(hotel);
        response.sendRedirect("adminDetails?detailType=Hotel");
    }

    // Method to add a plane
    private void addPlane(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String planeID = request.getParameter("planeID");
        String planeName = request.getParameter("planeName");
        String airline = request.getParameter("airline");
        String planeImg = request.getParameter("planeImg");
        int noSeat = Integer.parseInt(request.getParameter("noSeat"));

        if (planeID == null || planeName == null || airline == null || planeImg == null || noSeat <= 0) {
            // Xử lý trường hợp có tham số bị null
            response.sendRedirect("errorPage.jsp");
            return;
        }

        Plane plane = new Plane(planeID, planeName, airline, planeImg, Integer.toString(noSeat));
        // Insert the plane into the database
        PlaneDB.insert(plane);

        // Redirect to the success page
        response.sendRedirect("adminDetails?detailType=Plane");
    }

    // Method to add a flight
    private void addFlight(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String flightID = request.getParameter("flightID");
        String planeID = request.getParameter("planeID");
        String dateStartStr = request.getParameter("dateStart");
        String dateEndStr = request.getParameter("dateEnd");
        String departureCity = request.getParameter("departureCity");
        String arrivalCity = request.getParameter("arrivalCity");
        String noSeatLeftStr = request.getParameter("noSeatLeft");

        // Kiểm tra các tham số đầu vào
        if (flightID == null || planeID == null || dateStartStr == null || dateEndStr == null || departureCity == null || arrivalCity == null || noSeatLeftStr == null) {
            response.sendRedirect("errorPage.jsp");
            return;
        }

        try {
            // Chuyển đổi các giá trị từ String sang đúng kiểu dữ liệu
            Date dateStart = Date.valueOf(dateStartStr);
            Date dateEnd = Date.valueOf(dateEndStr);

            // Tạo một đối tượng Flight mới
            Flight flight = new Flight(flightID, planeID, departureCity, arrivalCity, noSeatLeftStr);

            // Chèn flight vào cơ sở dữ liệu
            FlightDB.insert(flight, dateStart, dateEnd);

            // Redirect đến trang chi tiết thành công
            response.sendRedirect("adminDetails?detailType=Flight");
        } catch (Exception e) {
            response.sendRedirect("errorPage.jsp");
        }
    }

    // Method to add a room
    private void addRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String roomID = request.getParameter("roomID");
        String hotelID = request.getParameter("hotelID");
        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        String roomType = request.getParameter("roomType");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        int isAvailable = Integer.parseInt(request.getParameter("isAvailable"));

        // Tạo một đối tượng Room mới
        Room room = new Room(roomID, hotelID, roomNumber, roomType, capacity, isAvailable);

        // Chèn room vào cơ sở dữ liệu
        RoomDB.insert(room);

        // Redirect đến trang chi tiết thành công
        response.sendRedirect("adminDetails?detailType=Room");
    }

    // Method to add a seat
    private void addSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String seatID = request.getParameter("seatID");
        String flightID = request.getParameter("flightID");
        int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
        String seatType = request.getParameter("seatType");
        int isAvailable = Integer.parseInt(request.getParameter("isAvailable"));

        // Tạo một đối tượng Seat mới
        Seat seat = new Seat(seatID, flightID, seatNumber, seatType, isAvailable);

        // Chèn seat vào cơ sở dữ liệu
        SeatDB.insert(seat);

        // Redirect đến trang chi tiết thành công
        response.sendRedirect("adminDetails?detailType=Seat");
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
        String objectType = request.getParameter("object");

        if ("hotel".equals(objectType)) {
            response.sendRedirect("add.jsp?object=hotel");
        } else if ("plane".equals(objectType)) {
            response.sendRedirect("add.jsp?object=plane");
        } else if ("flight".equals(objectType)) {
            response.sendRedirect("add.jsp?object=flight");
        } else if ("room".equals(objectType)) {
            response.sendRedirect("add.jsp?object=room");
        } else if ("seat".equals(objectType)) {
            response.sendRedirect("add.jsp?object=seat");
        } else {
            response.sendRedirect("errorPage.jsp");
        }
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
        String objectType = request.getParameter("object");

        if ("hotel".equals(objectType)) {
            addHotel(request, response);
        } else if ("plane".equals(objectType)) {
            addPlane(request, response);
        } else if ("flight".equals(objectType)) {
            addFlight(request, response);
        } else if ("room".equals(objectType)) {
            addRoom(request, response);
        } else if ("seat".equals(objectType)) {
            addSeat(request, response);
        } else {
            response.sendRedirect("errorPage.jsp");
        }
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
