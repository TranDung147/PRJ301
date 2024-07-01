/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Hotel;
import Model.Hotel;
import Model.HotelDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author NOMNOM
 */
public class HotelServlet extends HttpServlet {

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

        // Determine the action from the request parameter
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            response.getWriter().write("No action specified.");
            return;
        }

        switch (action.toLowerCase()) {
            case "add":
                handleAdd(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                response.getWriter().write("Invalid action specified.");
                break;
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String des = request.getParameter("des");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String country = request.getParameter("country");

            HotelDB fb = new HotelDB();
            Hotel existingHotel = fb.getHotelById(id);
            if (existingHotel == null) {
                Hotel newHotel = new Hotel(id, name, des, address, city, country);
                fb.insert(newHotel);
                response.sendRedirect("table_product.jsp");
            } else {
                request.setAttribute("error", "Hotel with ID " + id + " already exists!");
                request.getRequestDispatcher("Add.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error adding hotel: " + e.getMessage());
            request.getRequestDispatcher("Add.jsp").forward(request, response);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String id = request.getParameter("id");
            HotelDB fb = new HotelDB();
            fb.delete(id);
            response.sendRedirect("table_product.jsp");
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid ID for deletion.");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String hotelId = request.getParameter("hotelId");
            String hotelName = request.getParameter("hotelName");
            String hotelDescription = request.getParameter("hotelDescription");
            String hotelAddress = request.getParameter("hotelAddress");
            String city = request.getParameter("city");
            String country = request.getParameter("country");

            Hotel updatedHotel = new Hotel(hotelId, hotelName, hotelDescription, hotelAddress, city, country);
            HotelDB hotelDB = new HotelDB();
            hotelDB.update(updatedHotel);

            response.sendRedirect("table_product.jsp");
        } catch (Exception e) {
            String errorMessage = "Error updating hotel: " + e.getMessage();
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("Update.jsp").forward(request, response);
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
        return "HotelServlet for managing fruits";
    }// </editor-fold>

}