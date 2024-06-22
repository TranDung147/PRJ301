<%@page contentType="text/html" pageEncoding="UTF-8"%>
<body>
    <!-- Header Section -->
    <header class="header-content">
        <div class="container-header">
            <div class="upfloor row">
                <h3 class="col-md-2">QTALD</h3>

                <form class="search-bar col-md-6 row" action="hotelPage1.jsp">
                    <input class="col-md-8 headsearch" type="text" placeholder="Tìm kiếm" />
                    <button class="col-md-3 submitbut" type="submit">Search</button>
                </form>

                <div class="log col-md-4">

                    <!-- The Modal login -->

                    <button class="loginout col-md-5" onclick="document.getElementById('id01').style.display = 'block'" style="width:auto;">Log In</button>

                    <div id="id01" class="logmodal">

                        <form class="modal-content animate" action="UserServlet" method="post">
                            <div class="topmodal">
                                <h1>Log In</h1>
                                <span onclick="document.getElementById('id01').style.display = 'none'" class="close"
                                      title="Close Modal">&times;</span>
                            </div>
                            <hr>
                            <div class="logcontainer">                                
                                <label for="uname"><b>Username</b></label>
                                <input type="text" placeholder="Enter Username" name="uname" required>

                                <label for="psw"><b>Password</b></label>
                                <input type="password" placeholder="Enter Password" name="psw" required>

                                <button type="submit" name="action" value="login">Login</button>

                            </div>

                            <div class="logcontainer">
                                <span class="psw"><a href="#">Forgot password?</a></span>
                            </div>
                        </form>
                    </div>

                    <!-- The Modal signup -->
                    <button class="loginout col-md-5" onclick="document.getElementById('id02').style.display = 'block'" style="width:auto;">Sign Up</button>

                    <div id="id02" class="logmodal">
                        <form class="modal-content animate" name="input" action="UserServlet" method="post">
                            <div class="topmodal">
                                <h1>Sign Up</h1>
                                <span onclick="document.getElementById('id02').style.display = 'none'" class="close"
                                      title="Close Modal">&times;</span>
                            </div>
                            <hr>
                            <div class="logcontainer">
                                <label for="uname"><b>Username</b></label>
                                <input type="text" placeholder="Enter Username" name="uname" required>

                                <label for="email"><b>Email</b></label>
                                <input type="text" placeholder="Enter Email" name="email" required>

                                <label for="psw"><b>Password</b></label>
                                <input type="password" placeholder="Enter Password" name="psw" required>

                                <button type="submit" name="action" value="signup">Sign Up</button>

                            </div>
                        </form>
                    </div>
                    <div class="menu-container">
                        <button class="buthidden" id="menu-button">Menu</button>
                    </div>
                </div>
            </div>

            <div class="botfloor nav-links text-center custom-nav">

                <nav class="nav justify-content-center" id="hidden-buttons">
                    <a class="nav-link active" href="index.jsp">Trang chủ</a>
                    <a class="nav-link" href="flight.jsp">Chuyến bay</a>
                    <a class="nav-link" href="hotel.jsp">Khách sạn</a>
                    <a class="nav-link" href="planePage1.jsp">Thuê xe</a>
                    <a class="nav-link" href="#">Tham quan</a>
                    <a class="nav-link" href="#">Taxi sân bay</a>
                </nav>
            </div>
    </header>

    <script>
        document.getElementById('menu-button').addEventListener('click', function () {
            var hiddenButtons = document.getElementById('hidden-buttons');
            if (hiddenButtons.style.display === 'none' || hiddenButtons.style.display === '') {
                hiddenButtons.style.display = 'flex';
            } else {
                hiddenButtons.style.display = 'none';
            }
        });
    </script>