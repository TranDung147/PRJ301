<%@page import="java.util.List"%>
<%@page import="Model.Hotel"%>
<%@page import="DAO.HotelDB"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách khách sạn</title>
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link href="assets/css/headerfooter.css" rel="stylesheet" />
        <link href="assets/css/sort.css" rel="stylesheet" />
    </head>

    <body>
        <%
            String user = (String) session.getAttribute("user");
            if (user == null) {
        %>
        <%@include file="includes/header.jsp" %>
        <% } else {
        %>
        <%@include file="includes/header_user.jsp" %>
        <% }
        %>

        <%
            HttpSession sessionObj = request.getSession(false);
            if (sessionObj == null || sessionObj.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            }
        %>

        <style>
            .cc {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
            }
            .btn {
                padding: 10px 20px;
                border-radius: 5px;
            }
        </style>

        <main class="mainH">  
            <div class="containerB">
                <div class="row">
                    <div class="col-md-2">
                        <h2 class="boloc">Bộ lọc</h2>
                        <div class="filter-group">
                            <h3>Vị trí</h3>
                            <div>
                                <input type="checkbox" id="location1" value="location1" class="filter-checkbox">
                                <label for="location1">Vị trí 1</label>
                            </div>
                            <div>
                                <input type="checkbox" id="location2" value="location2" class="filter-checkbox">
                                <label for="location2">Vị trí 2</label>
                            </div>
                            <div>
                                <input type="checkbox" id="location3" value="location3" class="filter-checkbox">
                                <label for="location3">Vị trí 3</label>
                            </div>
                        </div>
                        <div class="filter-group">
                            <h3>Giá</h3>
                            <div>
                                <input type="checkbox" id="price1" value="0-50" class="filter-checkbox">
                                <label for="price1">$0 - $50</label>
                            </div>
                            <div>
                                <input type="checkbox" id="price2" value="51-100" class="filter-checkbox">
                                <label for="price2">$51 - $100</label>
                            </div>
                            <div>
                                <input type="checkbox" id="price3" value="101-200" class="filter-checkbox">
                                <label for="price3">$101 - $200</label>
                            </div>
                        </div>
                        <div class="filter-group">
                            <h3>Số phòng ngủ</h3>
                            <div>
                                <input type="checkbox" id="bedrooms1" value="1" class="filter-checkbox">
                                <label for="bedrooms1">1 phòng ngủ</label>
                            </div>
                            <div>
                                <input type="checkbox" id="bedrooms2" value="2" class="filter-checkbox">
                                <label for="bedrooms2">2 phòng ngủ</label>
                            </div>
                            <div>
                                <input type="checkbox" id="bedrooms3" value="3" class="filter-checkbox">
                                <label for="bedrooms3">3 phòng ngủ</label>
                            </div>
                        </div>
                        <div class="filter-group">
                            <h3>Loại nhà</h3>
                            <div>
                                <input type="checkbox" id="houseType1" value="apartment" class="filter-checkbox">
                                <label for="houseType1">Căn hộ</label>
                            </div>
                            <div>
                                <input type="checkbox" id="houseType2" value="villa" class="filter-checkbox">
                                <label for="houseType2">Biệt thự</label>
                            </div>
                            <div>
                                <input type="checkbox" id="houseType3" value="townhouse" class="filter-checkbox">
                                <label for="houseType3">Nhà phố</label>
                            </div>
                        </div>
                        <div class="filter-group">
                            <h3>Tiện ích</h3>
                            <div>
                                <input type="checkbox" id="amenity1" value="wifi" class="filter-checkbox">
                                <label for="amenity1">Wi-Fi</label>
                            </div>
                            <div>
                                <input type="checkbox" id="amenity2" value="parking" class="filter-checkbox">
                                <label for="amenity2">Bãi đỗ xe</label>
                            </div>
                            <div>
                                <input type="checkbox" id="amenity3" value="pool" class="filter-checkbox">
                                <label for="amenity3">Hồ bơi</label>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-10">
                        <div class="sort">
                            <h5 class="text">Sắp xếp theo</h5>
                            <button class="btn bg-primary text-white"><a href="flightH.html">Liên quan</a></button>
                            <button class="btn bg-primary text-white"><a href="flightH.html">Mới nhất</a></button>
                            <button class="btn bg-primary text-white"><a href="flightH.html">Đánh giá cao</a></button>
                            <form action="">
                                <select class="price bg-primary btn" name="" id="">
                                    <option class="bg-white text-primary" value="0" selected>Giá:</option>
                                    <option class="bg-white text-primary" value="1">Giá: Từ thấp đến cao</option>
                                    <option class="bg-white text-primary" value="2">Giá: Từ cao đến thấp</option>
                                </select>
                            </form>
                            <div class="pagination">
                                <span class="text">1/</span>
                                <span class="text">2</span>
                                <button class="btn prev"><a href="hotelPage1.jsp">Prev</a></button>
                                <button class="btn next"><a href="hotelPage2.jsp">Next</a></button>
                            </div>
                        </div>

                        <div class="product-list">
                        <%
                            String roomType = (String) request.getAttribute("roomType");
                            List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");

                            if (hotels == null || hotels.isEmpty()) {
                                out.println("<p>No hotels found.</p>");
                            } else {
                                for (Hotel hotel : hotels) {
                        %>
                        <div class="cols product location">
                            <form action="roomServlet" method="get">
                                <input type="hidden" name="hotelID" value="<%= hotel.getHotelId() %>">
                                <img class="image images" src="img/<%= hotel.getProductImage() %>" alt="<%= hotel.getProductImage() %>">
                                <h4><%= hotel.getHotelName() %></h4>
                                <p><span>Địa chỉ:</span> <%= hotel.getHotelAddress() %>, <%= hotel.getCountry() %></p>
                                <div class="cc">
                                    <button class="btn bg-primary text-white mx-auto xemphongbut" type="submit">Xem phòng</button>
                                </div>
                            </form>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>


                    </div>
                </div>
            </div>  
        </main>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
