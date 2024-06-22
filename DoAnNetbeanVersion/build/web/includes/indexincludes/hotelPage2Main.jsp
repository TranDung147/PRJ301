
<%@page import="java.sql.*, Model.DatabaseInfo, Model.Hotel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sessionObj = request.getSession(false); // Lấy session hiện tại, không tạo mới nếu chưa có

    // Kiểm tra nếu session không tồn tại hoặc không có thuộc tính username
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        // Nếu không có session hoặc không có thông tin đăng nhập, chuyển hướng về trang đăng nhập
        response.sendRedirect("index.jsp");
    }
%>
<main>  
    <div class="containerB ">
        <div class="row">
            <!-- Filter Section -->
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

            <!-- Product Section -->
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
                        <span class="text">2/</span>
                        <span class="text">2</span>
                        <button class="btn prev"><a href="hotelPage1.jsp">Prev</a></button>
                        <button class="btn next"><a href="hotelPage2.jsp">Next</a></button>
                    </div>
                </div>

                <!-- Your product list -->
                <div class="product-list">
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        
                        try {
                            Class.forName(DatabaseInfo.DRIVERNAME);
                            conn = DriverManager.getConnection(DatabaseInfo.DBURL, DatabaseInfo.USERDB, DatabaseInfo.PASSDB);
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM Hotel ORDER BY HotelID OFFSET 12 ROWS FETCH NEXT 12 ROWS ONLY";// Lấy 12 ks tiếp theo
                            rs = stmt.executeQuery(sql);

                            if (!rs.isBeforeFirst()) {
                                out.println("<p>No hotels found.</p>");
                            } else {
                                while (rs.next()) {
                                    String hotelId = rs.getString("HotelID");
                                    String hotelName = rs.getString("HotelName");
                                    String hotelAddress = rs.getString("HotelAddress");
                                    String hotelDescription = rs.getString("Description");
                                    String productImage = rs.getString("ProductImage");
                                    String city = rs.getString("City");
                                    String country = rs.getString("Country");

                                    Hotel hotel = new Hotel();
                                    hotel.setHotelId(hotelId);
                                    hotel.setHotelName(hotelName);
                                    hotel.setHotelAddress(hotelAddress);
                                    hotel.setHotelDescription(hotelDescription);
                                    hotel.setProductImage(productImage);
                                    hotel.setCity(city);
                                    hotel.setCountry(country);
                    %>
                    <div class="cols product location">
                        <img class="image images" src="img/<%= hotel.getProductImage() %>" alt="<%= hotel.getHotelName() %>">
                        <h4><%= hotel.getHotelName() %></h4>
                        <p><span>Địa chỉ:</span> <%= hotel.getHotelAddress() %></p>
                        <p><span>Mô tả:</span> <%= hotel.getHotelDescription() %></p>
                        <p><span>Thành phố:</span> <%= hotel.getCity() %></p>
                        <p><span>Quốc gia:</span> <%= hotel.getCountry() %></p>
                    </div>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>  
</main>

