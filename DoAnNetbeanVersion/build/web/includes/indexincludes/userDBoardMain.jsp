<%-- 
    Document   : userDBoard
    Created on : Jun 16, 2024, 2:57:18 PM
    Author     : NOMNOM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    header {
        position: relative;
    }

    .containerus {
        display: flex;
        height: 100vh;
        width: 100%;
    }

    .sidebar {
        width: 250px;
        background-color: #2c3e50;
        color: white;
        padding: 20px;
    }

    .logo {
        text-align: center;
        margin-bottom: 30px;
    }

    .sidebar nav ul {
        list-style: none;
        padding: 0;
    }

    .sidebar nav ul li {
        margin: 20px 0;
    }

    .sidebar nav ul li a {
        color: white;
        text-decoration: none;
        display: block;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .sidebar nav ul li a:hover, .sidebar nav ul li.active a {
        background-color: #1abc9c;
        color: white;
    }

    .main-content {
        flex: 1;
        padding: 20px;
        background-color: white;
        overflow-y: auto;
    }

    .main-content header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .main-content header input {
        padding: 10px;
        width: 300px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .profile {
        display: flex;
        align-items: center;
    }

    .profile img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
    }

    .dashboard h2 {
        margin: 0 0 20px 0;
    }

    .cards {
        display: flex;
        justify-content: space-between;
    }

    .card {
        background-color: #ecf0f1;
        padding: 20px;
        border-radius: 5px;
        text-align: center;
        flex: 1;
        margin: 0 10px;
        transition: background-color 0.3s, transform 0.3s;
    }

    .card:hover {
        background-color: #bdc3c7;
        transform: scale(1.05);
    }

    .card h3 {
        margin: 0;
    }

    .tours {
        margin-top: 20px;
    }

    .tour {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        transition: background-color 0.3s;
    }

    .tour:hover {
        background-color: #ecf0f1;
    }

    .tour img {
        width: 60px;
        height: 60px;
        border-radius: 5px;
        margin-right: 20px;
    }

    .tour-info h4 {
        margin: 0 0 5px 0;
    }

    .tour-info p {
        margin: 0;
        color: #777;
    }

    .section {
        display: none;
    }

    .section.active {
        display: block;
    }

    .profile-details {
        width: 100%;
        max-width: 1500px;
        margin: 0 auto;
        text-align: left;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        align-items: center;

    }

    .profile-details img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        margin-bottom: 20px;
    }

    .profile-details h3 {
        margin: 10px 0;
    }

    .profile-details p {
        margin: 10px 0;
        color: #555;
        font-size: 16px;
        width: 100%;
    }

    .profile-details p strong {
        display: inline-block;
        width: 200px;
    }
    .eye-button {
        padding: 5px;
        font-size: 16px;
        background-color: transparent;
        border: none;
        cursor: pointer;
        outline: none;
    }

    .eye-button:hover {
        color: #333; /* Màu của con mắt khi di chuột qua */
    }

    .eye-button::selection {
        background-color: transparent; /* Ẩn hiệu ứng chọn văn bản khi click */
    }
    .password-container {
        display: flex;
        align-items: center; /* Canh chính mật khẩu và nút con mắt theo chiều dọc */
    }

    .password-container p {
        margin-right: 10px; /* Tạo khoảng cách giữa mật khẩu và nút con mắt */
    }

</style>
<div class="containerus">
    <aside class="sidebar">
        <div class="logo">
            <h2>Tour Booking</h2>
        </div>
        <nav>
            <ul>
                <li class="active"><a href="#" data-target="dashboard">Dashboard</a></li>
                <li><a href="#" data-target="available-tours">Available Tours</a></li>
                <li><a href="#" data-target="booked-tours">Booked Tours</a></li>
                <li><a href="#" data-target="profile">Profile</a></li>
                <li><a href="#" data-target="messages">Messages</a></li>
                <li><a href="#" data-target="help">Help</a></li>
            </ul>
        </nav>
    </aside>
    <main class="main-content">
        <section id="dashboard" class="section active">
            <h2>Dashboard</h2>
            <div class="cards">
                <div class="card">
                    <h3>Available Tours</h3>
                </div>
                <div class="card">
                    <h3>Booked Tours</h3>
                </div>
                <div class="card">
                    <h3>Profile</h3>
                </div>
            </div>
        </section>
        <section id="available-tours" class="section">
            <h2>Available Tours</h2>
            <div class="tours">
                <div class="tour">
                    <img src="tour1.jpg" alt="Tour Picture">
                    <div class="tour-info">
                        <h4>Beach Paradise</h4>
                        <p>7 days - $2000</p>
                    </div>
                </div>
                <div class="tour">
                    <img src="tour2.jpg" alt="Tour Picture">
                    <div class="tour-info">
                        <h4>Mountain Adventure</h4>
                        <p>5 days - $1500</p>
                    </div>
                </div>
            </div>
        </section>
        <section id="booked-tours" class="section">
            <h2>Booked Tours</h2>
            <!-- Booked tours content goes here -->
        </section>
        <section id="profile" class="section">
            <h2>Profile</h2>
            <div class="profile-details">
                <img src="profile.jpg" alt="Profile Picture">
                <%
                      // Retrieve the User object from the request scope
                      User user = (User) request.getAttribute("user");

                      // Check if the User object exists and is not null
                      if (user != null) {
                %>
                <!-- Display user information -->
                <h3><%= user.getUsername() %></h3>
                <p><strong>Username:</strong> <%= user.getUsername() %></p>
                <p><strong>Password:</strong> <%= user.getPassword() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <%
                    } else {
                        // User object doesn't exist or is null
                        out.println("<p>User not found</p>");
                    }
                %>


            </div>
        </section>
    </main>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const navLinks = document.querySelectorAll('.sidebar nav ul li a');
        const sections = document.querySelectorAll('.section');

        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();

                // Remove active class from all links
                navLinks.forEach(link => link.parentElement.classList.remove('active'));

                // Add active class to the clicked link
                link.parentElement.classList.add('active');

                // Hide all sections
                sections.forEach(section => section.classList.remove('active'));

                // Show the targeted section
                const target = link.getAttribute('data-target');
                document.getElementById(target).classList.add('active');
            });
        });

        const togglePasswordButton = document.getElementById('togglePassword');
        const passwordInput = document.querySelector('.password-container input');

        let passwordVisible = false;

        togglePasswordButton.addEventListener('click', () => {
            passwordVisible = !passwordVisible;
            if (passwordVisible) {
                passwordInput.type = 'text'; // Hiển thị mật khẩu
                togglePasswordButton.innerHTML = '&#x1F441;'; // Hiển thị mắt mở
            } else {
                passwordInput.type = 'password'; // Ẩn mật khẩu
                togglePasswordButton.innerHTML = '&#x1F440;'; // Hiển thị mắt đóng
            }
        });
    });
</script>
