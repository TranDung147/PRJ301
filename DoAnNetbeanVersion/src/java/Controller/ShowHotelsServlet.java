package Controller;

import Model.Hotel;
import Model.HotelDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ShowHotelsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ShowHotelsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowHotelsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        showHotels(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    public void showHotels(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID khách sạn từ request
        String hotelId = request.getParameter("id");

        // Gọi phương thức getHotel từ HotelDB để lấy thông tin khách sạn
        Hotel hotel = HotelDB.getHotelById(hotelId);

        // Kiểm tra xem hotel có null hay không
        if (hotel != null) {
            // Đặt thông tin khách sạn vào request attribute
            request.setAttribute("hotel", hotel);

            // Chuyển tiếp yêu cầu đến trang JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("showHotel.jsp");
            dispatcher.forward(request, response);
        } else {
            // Xử lý trường hợp không tìm thấy khách sạn
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hotel not found");
        }
    }

}
