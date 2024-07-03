<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*, Model.DatabaseInfo, Model.Plane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách máy bay 1</title>

        <!-- Bootstrap JS and dependencies -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/headerfooter.css" rel="stylesheet" />
        <link href="assets/css/sort.css" rel="stylesheet" />
    </head>

    <% 
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
    <%@include file="includes/header.jsp" %>
    <% } else { %>
    <%@include file="includes/header_user.jsp" %>
    <% } %>

    <main class="mainH">  
        <div class="containerB">
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
                            <span class="text">${curPage}/${totalPage}</span>
                            <c:if test="${curPage > 1}">
                            <a href="PlaneServlet?page=${curPage - 1}"><button class="btn prev">Prev</button></a>
                            </c:if>
                            <c:if test="${curPage < totalPage}">
                            <a href="PlaneServlet?page=${curPage + 1}"><button class="btn next">Next</button></a>
                            </c:if>
                        </div>
                    </div>

                    <!-- Your product list -->
                    <div class="product-list" id="content">
                        <c:forEach var="p" items="${pList}">
                            <div class="cols product location">
                                <img class="image images" src="img/${p.planeImg}" alt="${p.planeImg}">
                                <h4>${p.planeName}</h4>
                                <p><span>Hãng:</span>${p.airline}</p>
                                <p><span>Còn trống:</span> ${p.noSeat}</p>
                            </div>
                        </c:forEach> 
                    </div>
                </div>
            </div>
        </div>  
    </main>
    <%@include file="includes/footer.jsp" %>
