/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Transaction;
import DAO.TransactionDB;
import Model.User;
import DAO.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "TransactionServlet", urlPatterns = {"/thanhtoan"})
public class TransactionServlet extends HttpServlet {

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

        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user");
        String pass = (String) session.getAttribute("pass");

        UserDB userDB = new UserDB();
        User user = userDB.getUsers(userName, pass);

        if (user != null) {
            String id = user.getUserID();

            TransactionDB tran = new TransactionDB();
            List<Transaction> t = tran.getAllUserTransactions(user.getUserID());

            // Kiểm tra xem danh sách giao dịch có dữ liệu không
            if (t == null || t.isEmpty()) {
                System.out.println("No transactions found for user ID: " + id);
            } else {
                // In ra danh sách giao dịch để kiểm tra
                for (Transaction transaction : t) {
                    System.out.println(transaction);
                }
            }

            // Đặt thuộc tính cho JSP
            request.setAttribute("user", user);
            request.setAttribute("transactions", t);

            // Chuyển tiếp yêu cầu tới JSP
            request.getRequestDispatcher("includes/servlet/userdb/transactionUser.jsp").forward(request, response);
        } else {
            // Nếu người dùng không tồn tại, chuyển hướng về trang đăng nhập hoặc báo lỗi
            response.sendRedirect("index.jsp");
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
        return "Short description";
    }// </editor-fold>

}
