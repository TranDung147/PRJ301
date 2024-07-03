<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        height: 100vh;
    }

    .user-menu {
        display: inline-block;
        position: relative;
    }

    .user-icon {
        width: 50px;
        height: 50px;
        border-radius: 100%;
        overflow: hidden;
        cursor: pointer;
        border: 2px solid black; /* Black border */
        background-color: white;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .user-icon img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: white;
        width: 300px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        border-radius: 5px;
        overflow: hidden;
        top: 60px;
        right: 0;
    }

    .menu-header {
        padding: 15px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }

    .menu-header img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        margin-bottom: 10px;
    }

    .menu-header span {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .menu-header a {
        display: block;
        color: #008cba;
        text-decoration: none;
        font-size: 14px;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: flex;
        align-items: center;
    }

    .dropdown-content a img {
        width: 20px;
        height: 20px;
        margin-right: 10px;
    }

    .dropdown-content a:hover {
        background-color: #ddd;
    }

    .show {
        display: block;
    }

</style>
<!-- Header Section -->
<header class="header-content">
    <div class="container-header">
        <div class="upfloor row">
            <h3 class="col-md-2">QTALD</h3>

            <form class="search-bar col-md-6 row" action="hotelPage1.jsp">
                <input class="col-md-8" type="text" placeholder="Tìm kiếm" />
                <button class="col-md-3 submitbut" type="submit">Search</button>
            </form>

            <div class="log col-md-4">
                <!-- User Menu -->
                <div class="user-menu">
                    <div class="user-icon" onclick="toggleMenu()">
                        <img src="img/avtvodanh.png" alt="User Avatar">
                    </div>
                    <div id="dropdown" class="dropdown-content">
                        <div class="menu-header">
                            <img src="img/avtvodanh.png" alt="User Avatar">
                            <span>admin</span>
                            <a href="UserDashboard">Xem tất cả trang cá nhân</a>
                        </div>
                        <a href="#" id="settings-privacy">
                            <img src="img/settings_privacy.png" alt="Settings & Privacy"> Cài đặt & quyền riêng tư
                        </a>
                        <a href="#" id="help-support">
                            <img src="img/help_support.jpg" alt="Help & Support"> Trợ giúp & hỗ trợ
                        </a>
                        <a href="#" id="display-accessibility">
                            <img src="img/display-accessibility.jpg" alt="Display & Accessibility"> Màn hình & trợ năng
                        </a>
                        <a href="#" id="feedback">
                            <img src="img/feedback.png" alt="Feedback"> Đóng góp ý kiến
                        </a>
                        <form action="<%=response.encodeURL("UserServlet") %>" method="get">
                            <input type="submit" name="action" value="Log Out" class="logout">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="botfloor nav-links text-center custom-nav">
            <nav class="nav justify-content-center">
                <a class="nav-link active" href="index.jsp">Trang chủ</a>
                <a class="nav-link" href="FlightServlet">Chuyến bay</a>
                <a class="nav-link" href="hotel.jsp">Khách sạn</a>
                <a class="nav-link" href="PlaneServlet?page=1">Thuê xe</a>
                <a class="nav-link" href="#">Địa điểm tham quan</a>
                <a class="nav-link" href="#">Taxi sân bay</a>
            </nav>
        </div>
    </div>
</header>

<script>
    function toggleMenu() {
        document.getElementById("dropdown").classList.toggle("show");
    }

    // Close the dropdown menu if the user clicks outside of it
    window.onclick = function (event) {
        if (!event.target.matches('.user-icon') && !event.target.matches('.user-icon img')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown =
                        dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>

