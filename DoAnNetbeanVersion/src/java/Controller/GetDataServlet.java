/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.RoomDB;
import DAO.SeatDB;
import DAO.TransactionDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author NOMNOM
 */
public class GetDataServlet extends HttpServlet {

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
            out.println("<title>Servlet GetDataServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetDataServlet at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();

        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        JSONObject jsonRequest = new JSONObject(sb.toString());
        String yearParam = jsonRequest.optString("year", null);

        try {
            RoomDB room = new RoomDB();
            SeatDB seat = new SeatDB();
            TransactionDB tran = new TransactionDB();
            String year = (yearParam != null && !yearParam.trim().isEmpty()) ? yearParam : "defaultYear";

            // Lấy dữ liệu từ các phương thức
            Map<String, Integer> roomCounts = room.countBookingRoomDetailsByRoomType(year);
            Map<String, Integer> ticketCounts = seat.countBookingTicketsBySeatType(year);
            Map<String, Integer> totalCounts = countTotalBookingsByType(year);
            Map<Integer, Map<String, Double>> roomPrices = room.getTotalPriceByRoomType(year);
            Map<Integer, Map<String, Double>> ticketPrices = seat.getTotalPriceBySeatType(year);
            double totalPrices = getTotalPriceByType(year);
            int totalOrders = tran.getTotalOrdersForYear(year);
            // Tạo JSON phản hồi
            JSONObject jsonResponse = new JSONObject();

            // Room booking counts
            JSONObject roomBookingCounts = new JSONObject();
            for (String type : new String[]{"VIP", "Standard"}) {
                roomBookingCounts.put(type, roomCounts.getOrDefault(type, 0));
            }
            jsonResponse.put("roomBookingCounts", roomBookingCounts);

            // Ticket booking counts
            JSONObject ticketBookingCounts = new JSONObject();
            for (String type : new String[]{"VIP", "Standard"}) {
                ticketBookingCounts.put(type, ticketCounts.getOrDefault(type, 0));
            }
            jsonResponse.put("ticketBookingCounts", ticketBookingCounts);

            // Total counts
            JSONObject totalCountsJSON = new JSONObject();
            totalCountsJSON.put("total", totalCounts.getOrDefault("total", 0));
            jsonResponse.put("totalCounts", totalCountsJSON);

            // Room prices
            JSONArray roomPricesArray = new JSONArray();
            for (String type : new String[]{"VIP", "Standard"}) {
                JSONArray monthlyPrices = new JSONArray();
                for (int month = 1; month <= 12; month++) {
                    double price = roomPrices.getOrDefault(month, new HashMap<>()).getOrDefault(type, 0.0);
                    monthlyPrices.put(price);
                }
                roomPricesArray.put(monthlyPrices);
            }
            jsonResponse.put("roomPrices", roomPricesArray);

            // Ticket prices
            JSONArray ticketPricesArray = new JSONArray();
            for (String type : new String[]{"VIP", "Standard"}) {
                JSONArray monthlyPrices = new JSONArray();
                for (int month = 1; month <= 12; month++) {
                    double price = ticketPrices.getOrDefault(month, new HashMap<>()).getOrDefault(type, 0.0);
                    monthlyPrices.put(price);
                }
                ticketPricesArray.put(monthlyPrices);
            }
            jsonResponse.put("ticketPrices", ticketPricesArray);

            jsonResponse.put("totalPrices", totalPrices);
            jsonResponse.put("totalOrders", totalOrders);
            out.print(jsonResponse.toString());
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid year format\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    public Map<String, Integer> countTotalBookingsByType(String year) {
        Map<String, Integer> totalCounts = new HashMap<>();
        RoomDB room = new RoomDB();
        SeatDB seat = new SeatDB();

        Map<String, Integer> roomCounts = room.countBookingRoomDetailsByRoomType(year);
        Map<String, Integer> ticketCounts = seat.countBookingTicketsBySeatType(year);

        for (Map.Entry<String, Integer> entry : roomCounts.entrySet()) {
            String type = entry.getKey();
            int count = entry.getValue();
            totalCounts.put(type, totalCounts.getOrDefault(type, 0) + count);
        }

        for (Map.Entry<String, Integer> entry : ticketCounts.entrySet()) {
            String type = entry.getKey();
            int count = entry.getValue();
            totalCounts.put(type, totalCounts.getOrDefault(type, 0) + count);
        }

        return totalCounts;
    }

    public static double getTotalPriceByType(String year) {
        double totalPriceForYear = 0.0;
        RoomDB room = new RoomDB();
        SeatDB seat = new SeatDB();
        Map<Integer, Map<String, Double>> roomPrices = room.getTotalPriceByRoomType(year);
        Map<Integer, Map<String, Double>> seatPrices = seat.getTotalPriceBySeatType(year);

        for (Map.Entry<Integer, Map<String, Double>> entry : roomPrices.entrySet()) {
            Map<String, Double> monthPrices = entry.getValue();
            for (double price : monthPrices.values()) {
                totalPriceForYear += price;
            }
        }

        // Tính tổng giá từ dữ liệu ghế
        for (Map.Entry<Integer, Map<String, Double>> entry : seatPrices.entrySet()) {
            Map<String, Double> monthPrices = entry.getValue();
            for (double price : monthPrices.values()) {
                totalPriceForYear += price;
            }
        }

        return totalPriceForYear;
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
