
package Controller;

import Model.Hotel;
import Model.HotelDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        HttpSession session = request.getSession();
//        ArrayList<Hotel> cart = (ArrayList<Hotel>) session.getAttribute("cart");
//        if (cart == null) {
//            cart = new ArrayList<>();
//            session.setAttribute("cart", cart);
//        }
//
//        String id =request.getParameter("HotelId");
//        String name = request.getParameter("HotelName");
//        String descrip = request.getParameter("HotelDescription");
//
//        System.out.println("Adding to cart: ID=" + id + ", Name=" + name + ", Price=" + price + ", Quantity=" + quantity);
//
//        HotelDB hotelDB = new HotelDB();
//        Hotel fruit = fruitDB.getHotelById(id);
//
//        if (fruit == null) {
//            Hotel c1 = new Hotel(id, name, null, price, quantity);
//            if (c1.getQuantity() >= quantity) {
//                c1.setQuantity(c1.getQuantity() - quantity);
//                //fruitDB.updateHotelQuantity(id, c1.getQuantity());
//
//                boolean itemExists = false;
//                for (Hotel item : cart) {
//                    if (item.getProductId() == id) {
//                        item.setQuantity(item.getQuantity() + quantity);
//                        itemExists = true;
//                        break;
//                    }
//                }
//
//                if (!itemExists) {
//                    Hotel newItem = new Hotel(id, name, null, price, quantity);
//                    cart.add(newItem);
//                }
//                session.setAttribute("cart", cart);
//                response.sendRedirect("AddToCart.jsp");
//            } else {
//                response.sendRedirect("table_product.jsp?error=out_of_stock");
//            }
//        } else {
//            System.out.println("Hotel with ID " + id + " was not found.");
//            response.sendRedirect("table_product.jsp?error=fruit_not_found");
//        }
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
