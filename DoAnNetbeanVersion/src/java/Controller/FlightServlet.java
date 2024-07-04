/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Flight;
import Model.FlightDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class FlightServlet extends HttpServlet {

    static List<Flight> flightList = new ArrayList<>();

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
        String action = request.getParameter("action");
        switch (action) {
            case "loadAllDB":
                flightList = FlightDB.getAllFlights();
                loadPage(request, response);
                break;
            case "search":
                flightList = new ArrayList<>();
                List<Flight> allFlight = FlightDB.getAllFlights();
                String start = request.getParameter("start");
                String end = request.getParameter("end");
                String date = request.getParameter("date");

//                PrintWriter out = response.getWriter();
//                out.print(date);
                for (Flight flight : allFlight) {
                    if (flight.getDepartureCity().equals(start) && flight.getArrivalCity().equals(end)
                            && flight.getDateStart().equals(date)) {
                        flightList.add(flight);
                    }
                }
                loadPage(request, response);
                break;
            case "loadPage":
                loadPage(request, response);
                break;
            default:
                throw new AssertionError();
        }

    }

    private void loadPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Flight> fList = new ArrayList<>();
        int page = Integer.parseInt(request.getParameter("page"));
        int maxLength = 12 * page;
        if (maxLength > flightList.size()) {
            maxLength = flightList.size();
        }
        for (int i = 12 * page - 12; i < maxLength; i++) {
            fList.add(flightList.get(i));
        }
        int totalPage = (int) Math.ceil((double) flightList.size() / 12);
        System.out.println("Total planes: " + flightList.size());
        for (Flight flight : flightList) {
            System.out.println(flight.toString());
        }
        List<Integer> pageList = new ArrayList<>();
        for (int i = 0; i < totalPage; i++) {
            pageList.add(i + 1);
        }
        request.setAttribute("pageList", pageList);
        request.setAttribute("curPage", page);
        request.setAttribute("flightList", fList);
        request.getRequestDispatcher("flight.jsp").forward(request, response);
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
        return "Short description";
    }// </editor-fold>

}
