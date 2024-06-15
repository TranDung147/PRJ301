<%-- 
    Document   : hotelPage2Main
    Created on : Jun 14, 2024, 6:56:33 PM
    Author     : NOMNOM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

                <div id="myModal" class="modal">
                    <div class="modal-content">
                        <h1>Hotel<span class="close" onclick="closeModal()">&times;</span></h1>
                        <div id="modalInfo" class="modal-info"></div>
                    </div>
                </div>

                <!-- Your product list -->
                <div class="product-list">
                    <!-- Nhà 13 -->
                    <div class="cols product location13" onclick="showModal(this)" data-price="70" data-bedrooms="2" data-houseType="apartment" data-amenities="wifi,parking" data-img="img/hotel13.jpg" data-star="★★★☆☆">
                        <div class="">
                            <img class="image" src="img/hotel13.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 13</h4>
                            <p>Giá: $70</p>
                            <p>Đánh giá: <span>★★★☆☆</span></p>
                        </div>
                    </div>

                    <!-- Nhà 14 -->
                    <div class="cols product location14" onclick="showModal(this)" data-price="90" data-bedrooms="3" data-houseType="villa" data-amenities="wifi,pool" data-img="img/hotel14.jpg" data-star="★★★★☆">
                        <div class="">
                            <img class="image" src="img/hotel14.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 14</h4>
                            <p>Giá: $90</p>
                            <p>Đánh giá: <span>★★★★☆</span></p>
                        </div>
                    </div>

                    <!-- Nhà 15 -->
                    <div class="cols product location15" onclick="showModal(this)" data-price="110" data-bedrooms="4" data-houseType="townhouse" data-amenities="parking,pool" data-img="img/hotel15.jpg" data-star="★★★★★">
                        <div class="">
                            <img class="image" src="img/hotel15.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 15</h4>
                            <p>Giá: $110</p>
                            <p>Đánh giá: <span>★★★★★</span></p>
                        </div>
                    </div>
                    
                    <!-- Nhà 16 -->
                    <div class="cols product location16" onclick="showModal(this)" data-price="130" data-bedrooms="2" data-houseType="apartment" data-amenities="wifi,parking" data-img="img/hotel16.jpg" data-star="★★★☆☆">
                        <div class="">
                            <img class="image" src="img/hotel16.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 16</h4>
                            <p>Giá: $130</p>
                            <p>Đánh giá: <span>★★★☆☆</span></p>
                        </div>
                    </div>
                </div>

                <div class="product-list row">
                    

                    <!-- Nhà 17 -->
                    <div class="cols product location17" onclick="showModal(this)" data-price="150" data-bedrooms="3" data-houseType="villa" data-amenities="wifi,pool" data-img="img/hotel17.jpg" data-star="★★★★☆">
                        <div class="">
                            <img class="image" src="img/hotel17.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 17</h4>
                            <p>Giá: $150</p>
                            <p>Đánh giá: <span>★★★★☆</span></p>
                        </div>
                    </div>

                    <!-- Nhà 18 -->
                    <div class="cols product location18" onclick="showModal(this)" data-price="170" data-bedrooms="4" data-houseType="townhouse" data-amenities="parking,pool" data-img="img/hotel18.jpg" data-star="★★★★★">
                        <div class="">
                            <img class="image" src="img/hotel18.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 18</h4>
                            <p>Giá: $170</p>
                            <p>Đánh giá: <span>★★★★★</span></p>
                        </div>
                    </div>
                    
                    <!-- Nhà 19 -->
                    <div class="cols product location19" onclick="showModal(this)" data-price="190" data-bedrooms="2" data-houseType="apartment" data-amenities="wifi,parking" data-img="img/hotel19.jpg" data-star="★★★☆☆">
                        <div class="">
                            <img class="image" src="img/hotel19.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 19</h4>
                            <p>Giá: $190</p>
                            <p>Đánh giá: <span>★★★☆☆</span></p>
                        </div>
                    </div>

                    <!-- Nhà 20 -->
                    <div class="cols product location20" onclick="showModal(this)" data-price="210" data-bedrooms="3" data-houseType="villa" data-amenities="wifi,pool" data-img="img/hotel20.jpg" data-star="★★★★☆">
                        <div class="">
                            <img class="image" src="img/hotel20.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 20</h4>
                            <p>Giá: $210</p>
                            <p>Đánh giá: <span>★★★★☆</span></p>
                        </div>
                    </div>
                </div>

                <div class="product-list row">
                    

                    <!-- Nhà 21 -->
                    <div class="cols product location21" onclick="showModal(this)" data-price="230" data-bedrooms="4" data-houseType="townhouse" data-amenities="parking,pool" data-img="img/hotel21.jpg" data-star="★★★★★">
                        <div class="">
                            <img class="image" src="img/hotel21.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 21</h4>
                            <p>Giá: $230</p>
                            <p>Đánh giá: <span>★★★★★</span></p>
                        </div>
                    </div>

                    <!-- Nhà 22 -->
                    <div class="cols product location22" onclick="showModal(this)" data-price="250" data-bedrooms="2" data-houseType="apartment" data-amenities="wifi,parking" data-img="img/hotel22.jpg" data-star="★★★☆☆">
                        <div class="">
                            <img class="image" src="img/hotel22.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 22</h4>
                            <p>Giá: $250</p>
                            <p>Đánh giá: <span>★★★☆☆</span></p>
                        </div>
                    </div>

                    <!-- Nhà 23 -->
                    <div class="cols product location23" onclick="showModal(this)" data-price="270" data-bedrooms="3" data-houseType="villa" data-amenities="wifi,pool" data-img="img/hotel23.jpg" data-star="★★★★☆">
                        <div class="">
                            <img class="image" src="img/hotel23.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 23</h4>
                            <p>Giá: $270</p>
                            <p>Đánh giá: <span>★★★★☆</span></p>
                        </div>
                    </div>

                    <!-- Nhà 24 -->
                    <div class="cols product location24" onclick="showModal(this)" data-price="290" data-bedrooms="4" data-houseType="townhouse" data-amenities="parking,pool" data-img="img/hotel24.jpg" data-star="★★★★★">
                        <div class="">
                            <img class="image" src="img/hotel24.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 24</h4>
                            <p>Giá: $290</p>
                            <p>Đánh giá: <span>★★★★★</span></p>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
</main>
