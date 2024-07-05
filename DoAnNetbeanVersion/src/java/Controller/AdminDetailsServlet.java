/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class AdminDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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
