//package Controller;
//
//import Model.UserDB;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//
//@WebServlet("/ChangePasswordServlet")
//public class ChangePasswordServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Lấy dữ liệu từ form
//        String currentPassword = request.getParameter("currentPassword");
//        String newPassword = request.getParameter("newPassword");
//        String confirmPassword = request.getParameter("confirmPassword");
//        
//        // Kiểm tra mật khẩu mới và xác nhận mật khẩu mới có khớp nhau hay không
//        if (!newPassword.equals(confirmPassword)) {
//            // Nếu không khớp, đặt thông báo lỗi và chuyển hướng lại trang thay đổi mật khẩu
//            request.setAttribute("errorMessage", "New passwords do not match.");
//            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
//        } else {
//            // Lấy thông tin người dùng từ session (hoặc cơ sở dữ liệu)
//            HttpSession session = request.getSession();
//            String userName = (String) session.getAttribute("user"); // Thay vì session, bạn có thể lấy từ cơ sở dữ liệu
//
//            // Kiểm tra mật khẩu hiện tại có đúng hay không
//            UserDB userDB = new UserDB();
//            if (userDB.checkPassword(userName, currentPassword)) {
//                // Nếu mật khẩu hiện tại đúng, thay đổi mật khẩu mới
//                if (userDB.changePassword(userName, newPassword)) {
//                    // Thay đổi thành công
//                    response.sendRedirect("userDBoard.jsp"); // Chuyển hướng đến trang dashboard hoặc trang thông báo thành công
//                } else {
//                    // Thay đổi không thành công, đặt thông báo lỗi và chuyển hướng lại trang thay đổi mật khẩu
//                    request.setAttribute("errorMessage", "Failed to change password. Please try again.");
//                    request.getRequestDispatcher("changePassword.jsp").forward(request, response);
//                }
//            } else {
//                // Nếu mật khẩu hiện tại không đúng, đặt thông báo lỗi và chuyển hướng lại trang thay đổi mật khẩu
//                request.setAttribute("errorMessage", "Current password is incorrect.");
//                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
//            }
//        }
//    }
//}
