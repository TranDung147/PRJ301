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
import DAO.*;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author NOMNOM
 */
public class CRUD extends HttpServlet {

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
            out.println("<title>Servlet CRUD</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CRUD at " + request.getContextPath() + "</h1>");
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
        String detailType = request.getParameter("detailType");
        String id = request.getParameter("id");
        Object detail = null;
        HttpSession session = request.getSession();
        boolean success = false;
        request.getSession().setAttribute("detailType", detailType);
        if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
            switch (detailType) {
                case "Hotel":
                    success = HotelDB.deleteHotel(id);
                    break;
                case "Plane":
                    success = PlaneDB.deletePlane(id);
                    break;
                case "Flight":
                    success = FlightDB.deleteFlight(id);
                    break;
                case "Room":
                    success = RoomDB.deleteRoom(id);
                    break;
                case "Seat":
                    success = SeatDB.deleteSeat(id);
                    break;
                default:
                    break;
            }
            if (success) {
                response.sendRedirect("adminDetails?detailType=" + detailType);
            } else {
                response.getWriter().println("Delete operation failed!");
            }
        } else {
            switch (detailType) {
                case "Hotel":
                    detail = HotelDB.getHotelByIds(id);
                    break;
                case "Plane":
                    detail = PlaneDB.getPlaneById(id);
                    break;
                case "Flight":
                    detail = FlightDB.getFlightById(id);
                    break;
                case "Room":
                    detail = RoomDB.getRoomById(id);
                    break;
                case "Seat":
                    detail = SeatDB.getSeatById(id);
                    break;
                default:
                    break;
            }

            if (detail != null) {
                session.setAttribute("detail", detail);
                session.setAttribute("type", detailType);
                System.out.println("Detail: " + detail);
                request.getRequestDispatcher("Update.jsp").forward(request, response);

            } else {
                response.getWriter().println("Detail not found!");
            }
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
        String type = request.getParameter("type");

        switch (type) {
            case "Hotel":
                updateHotel(request, response);
                break;
            case "Plane":
                updatePlane(request, response);
                break;
            case "Flight":
                updateFlight(request, response);
                break;
            case "Room":
                updateRoom(request, response);
                break;
            case "Seat":
                updateSeat(request, response);
                break;
            default:
                response.getWriter().println("Unsupported operation type");
                break;
        }
    }

    private void updateHotel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String description = request.getParameter("description");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String imageURL = request.getParameter("imageURL");

        boolean success = HotelDB.updateHotel(id, name, address, description, city, country, imageURL);

        if (success) {
            response.sendRedirect("adminDetails?detailType=Hotel");
        } else {
            response.getWriter().println("Update operation failed!");
        }
    }

    private void updatePlane(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String airline = request.getParameter("airline");
        String planeImg = request.getParameter("planeImg");
        String noSeat = request.getParameter("noSeat");

        boolean success = PlaneDB.updatePlane(id, name, airline, planeImg, noSeat);

        if (success) {
            response.sendRedirect("adminDetails?detailType=Plane");
        } else {
            response.getWriter().println("Update operation failed!");
        }
    }

    private void updateFlight(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String planeId = request.getParameter("planeId");
        String departureDate = request.getParameter("departureDate");
        String dateEnd = request.getParameter("dateEnd");
        String departureCity = request.getParameter("departureCity");
        String arrivalCity = request.getParameter("arrivalCity");
        String noSeatLeft = request.getParameter("noSeatLeft");
        boolean success = FlightDB.updateFlight(id, planeId, departureDate, dateEnd, departureCity, arrivalCity, noSeatLeft);
        if (success) {
            response.sendRedirect("adminDetails?detailType=Flight");
        } else {
            response.getWriter().println("Update operation failed!");
        }
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String roomNumberStr = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        String hotelID = request.getParameter("hotelID");
        int roomNumber = Integer.parseInt(roomNumberStr);
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        int isAvailable = Integer.parseInt(request.getParameter("isAvailable"));

        boolean success = RoomDB.updateRoom(id, hotelID, roomNumber, roomType, capacity, isAvailable);

        if (success) {
            response.sendRedirect("adminDetails?detailType=Room");
        } else {
            response.getWriter().println("Update operation failed!");
        }
    }

    private void updateSeat(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String seatID = request.getParameter("id");
        String flightID = request.getParameter("flightID");
        int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
        String seatType = request.getParameter("seatType");
        int isAvailable = Integer.parseInt(request.getParameter("isAvailable"));

        boolean success = SeatDB.updateSeat(seatID, flightID, seatNumber, seatType, isAvailable);

        if (success) {
            response.sendRedirect("adminDetails?detailType=Seat");
        } else {
            response.getWriter().println("Update operation failed!");
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
