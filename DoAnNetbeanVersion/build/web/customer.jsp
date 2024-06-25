<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.User"%>
<%@page import="Model.UserDB"%>
<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Profile Details</title>

        <!-- Bootstrap JS and dependencies 
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/index.css" rel="stylesheet" />
        <link href="assets/css/sort.css" rel="stylesheet" />
        <link href="assets/css/responsive" rel="stylesheet"/> -->
    </head>
    <style>
        /* Nhớ thay đổi khi ghép code */
        /* =============== Globals ============== */
        * {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --blue: #1b3661;
            --white: #fff;
            --gray: #f5f5f5;
            --black1: #222;
            --black2: #999;
        }

        body {
            min-height: 100vh;
            overflow-x: hidden;
            background-color: var(--gray);
        }

        .container {
            position: relative;
            width: 100%;
        }

        /* =============== Navigation ================ */
        .navigation-admin {
            position: fixed;
            width: 300px;
            height: 100%;
            background: var(--blue);
            border-left: 10px solid var(--blue);
            transition: 0.5s;
            overflow: hidden;
        }
        .navigation-admin.active {
            width: 80px;
        }

        .navigation-admin ul {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            padding-top: 70px;
        }

        .navigation-admin ul li {
            position: relative;
            width: 100%;
            list-style: none;
            border-top-left-radius: 30px;
            border-bottom-left-radius: 30px;
        }

        .navigation-admin ul li:hover,
        .navigation-admin ul li.hovered,
        .navigation-admin ul li.active {
            background-color: var(--white);
        }

        .navigation-admin ul li a {
            position: relative;
            display: block;
            width: 100%;
            display: flex;
            text-decoration: none;
            color: var(--white);
        }
        .navigation-admin ul li:hover a,
        .navigation-admin ul li.hovered a,
        .navigation-admin ul li.active a {
            color: var(--blue);
        }

        .navigation-admin ul li a .icon {
            position: relative;
            display: block;
            min-width: 60px;
            height: 60px;
            line-height: 75px;
            text-align: center;
        }
        .navigation-admin ul li a .ion-icon .icon {
            font-size: 1.75rem;
        }

        .navigation-admin ul li a .title {
            position: relative;
            display: block;
            padding: 0 10px;
            height: 60px;
            line-height: 60px;
            text-align: start;
            white-space: nowrap;
        }

        /* --------- curve outside ---------- */
        .navigation-admin ul li:hover a::before,
        .navigation-admin ul li.hovered a::before,
        .navigation-admin ul li.active a::before {
            content: "";
            position: absolute;
            right: 0;
            top: -50px;
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;
            box-shadow: 35px 35px 0 10px var(--white);
            pointer-events: none;
        }
        .navigation-admin ul li:hover a::after,
        .navigation-admin ul li.hovered a::after,
        .navigation-admin ul li.active a::after {
            content: "";
            position: absolute;
            right: 0;
            bottom: -50px;
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;
            box-shadow: 35px -35px 0 10px var(--white);
            pointer-events: none;
        }

        /* =============== Header ================ */
        .header {
            margin-left: 300px;
            padding: 20px;
            background-color: lightseagreen;
            color: var(--white);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 2rem;
        }

        .header .logout {
            font-size: 1rem;
            color: var(--white);
            text-decoration: none;
            padding: 10px 20px;
            border: 2px solid var(--white);
            border-radius: 5px;
            transition: background 0.3s, color 0.3s;
        }

        .header .logout:hover {
            background-color: var(--white);
            color: var(--blue);
        }

        /* =============== Information Section ================ */
        .information {
            margin-left: 300px;
            padding: 20px;
            background-color: var(--gray);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .information h2 {
            margin-bottom: 20px;
            color: var(--blue);
        }

        .profile-card {
            background-color: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            width: 90%;
            max-width: 800px;
            margin: 40px 0;
        }

        .profile-section {
            margin-bottom: 20px;
        }

        .profile-section h2 {
            color: #1b3661;
            font-size: 1.5rem;
            margin-bottom: 10px;
            border-bottom: 2px solid #1b3661;
            padding-bottom: 5px;
        }

        .profile-info {
            margin-bottom: 15px;
        }

        .profile-info label {
            display: block;
            font-weight: bold;
            color: lightseagreen;
            margin-bottom: 5px;
        }

        .profile-info p {
            font-size: 1.1rem;
        }

        .profile-info p span {
            font-weight: bold;
        }

        button {
            background-color: lightseagreen;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }

        button:hover {
            background-color: #1b3661;
        }


    </style>

    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li>
                        <a href="userDBoard.jsp">
                            <span class="icon">
                                <ion-icon name="home-outline"></ion-icon>
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>

                    <li class="active">
                        <a href="customer.jsp">
                            <span class="icon">
                                <ion-icon name="people-outline"></ion-icon>
                            </span>
                            <span class="title">Customers</span> 
                        </a>
                    </li>

                    <li>
                        <a href="order.jsp">
                            <span class="icon">
                                <ion-icon name="chatbubble-outline"></ion-icon>
                            </span>
                            <span class="title">Orders</span>
                        </a>
                    </li>

                    <li>
                        <a href="#">
                            <span class="icon">
                                <ion-icon name="help-outline"></ion-icon>
                            </span>
                            <span class="title">Messages</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- =============== Header ================ -->
            <div class="header">
                <h1>Admin Dashboard</h1>
                <form id="logoutForm" method="post" action="UserServlet">
                    <input type="hidden" name="action" value="log out">
                    <a class="logout" href="#" onclick="document.getElementById('logoutForm').submit();">Log Out</a>
                </form>

            </div>

            <div class="information">
                <%
                    // Allow access only if session exists
                    String user = null;
                    String pass = null;
                    if (session.getAttribute("user") == null || session.getAttribute("pass") == null) {
                        response.sendRedirect("index.jsp");
                    } else {
                        user = (String) session.getAttribute("user");
                        pass = (String) session.getAttribute("pass");
                    }

                    String userName = null;
                    String sessionID = null;
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if (cookie.getName().equals("user")) userName = cookie.getValue();
                            if (cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
                            if (cookie.getName().equals("pass")) pass = cookie.getValue();
                        }
                    } else {
                        sessionID = session.getId();
                    }

                    if (session != null) {
                        String sessionUser = (String) session.getAttribute("user");
                        String sessionPass = (String) session.getAttribute("pass");
                        if (sessionUser != null && sessionPass != null) {
                            userName = sessionUser;
                            pass = sessionPass;
                        }
                    }
                    
                    UserDB userDB = new UserDB();
                    User users = userDB.getUsers(userName, pass);
                    
                    if (users != null) {
                %>
                <div class="profile-card">
                    <!-- Hiển thị session ID, username, và các thông tin khác -->
                    <div>
                        <h1>Thông tin tài khoản:</h1>
                        <div class="profile-info">
                            <label>Username:</label>
                            <p><span><%= userName %></span></p>
                        </div>
                        <div class="profile-info">
                            <label>Password:</label>
                            <p>
                                <span id="passwordDisplay">********</span>
                                <button onclick="togglePassword()">Show</button>
                                <button id="changePasswordLink" onclick="changePassword()">Change Password</button>
                            </p>
                        </div>

                        <div class="profile-info">
                            <label>Email:</label>
                            <p><span><%= users.getEmail() %></span></p>
                        </div>
                    </div>

                    <div>
                        <h1>THông tin cá nhân:</h1>
                        <div class="profile-info">
                            <label>Họ:</label>
                            <p><span><%= users.getlName() %></span></p>
                        </div>
                        <div class="profile-info">
                            <label>Tên:</label>
                            <p><span><%= users.getfName() %></span></p>
                        </div>
                    </div>


                </div>
                <% } else { %>
                <!-- Trường hợp không tìm thấy người dùng -->
                <div class="information">
                    <h2>Hello <%= userName %>, Login successful.</h2>
                    <p>User information not found.</p>
                </div>
                <% } %>
            </div>

            <script>
                function togglePassword() {
                    var passwordField = document.getElementById('passwordDisplay');
                    var button = event.target;
                    var changePasswordLink = document.getElementById('changePasswordLink');

                    if (passwordField.innerHTML === "********") {
                        passwordField.innerHTML = "<%= pass %>";
                        button.textContent = "Hide";
                        changePasswordLink.style.display = 'inline'; // Hiển thị link
                    } else {
                        passwordField.innerHTML = "********";
                        button.textContent = "Show";
                        changePasswordLink.style.display = 'none'; // Ẩn link
                    }
                }

                // Hàm chuyển hướng đến trang thay đổi mật khẩu
                document.getElementById('changePasswordLink').onclick = function () {
                    window.location.href = 'changePassword.jsp'; // Thay thế đường dẫn này bằng đường dẫn tới trang thay đổi mật khẩu của bạn
                };
            </script>


    </body>
</html>