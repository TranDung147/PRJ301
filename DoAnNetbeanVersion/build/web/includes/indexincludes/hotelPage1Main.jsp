

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <span class="text">1/</span>
                        <span class="text">2</span>
                        <button class="btn prev"><a href="hotelPage1.jsp">Prev</a></button>
                        <button class="btn next"><a href="hotelPage2.jsp">Next</a></button>
                    </div>
                </div>


                 <!-- Modal -->
            <div id="myModal" class="modal modals">
              <div class="modal-content contents">
                <h1><span class="close" onclick="closeModal()">&times;</span></h1>
                <div id="modalInfo" class="modal-info infos"></div>
              </div>
            </div>

            <!-- Your product list -->
            <div class="product-list">
                <div class="cols product location1" onclick="showModal(this)" data-price="30" data-bedrooms="1" data-houseType="apartment" data-amenities="wifi,parking" data-img="img/hotel1.jpg" data-star="★★★☆☆">
                    <div class="">
                        <img class="image" src="img/hotel1.jpg" alt="">
                    </div>
                    <div class="info">
                        <h4>Nhà 1</h4>
                        <p>Giá: $30</p>
                        <p>Đánh giá: <span>★★★☆☆</span></p>
                    </div>
                </div>
                <div class="cols product location2" onclick="showModal(this)" data-price="60" data-bedrooms="2" data-houseType="villa" data-amenities="wifi,pool" data-img="img/hotel2.jpg" data-star="★★★★☆">
                    <div class="">
                        <img class="image" src="img/hotel2.jpg" alt="">
                    </div>
                    <div class="info">
                        <h4>Nhà 2</h4>
                        <p>Giá: $60</p>
                        <p>Đánh giá: <span>★★★★☆</span></p>
                    </div>
                </div>
                <div class="cols product location3" onclick="showModal(this)" data-price="150" data-bedrooms="3" data-houseType="townhouse" data-amenities="parking,pool" data-img="img/hotel3.jpg" data-star="★★★★☆">
                    <div class="">
                        <img class="image" src="img/hotel3.jpg" alt="">
                    </div>
                    <div class="info">
                        <h4>Nhà 3</h4>
                        <p>Giá: $150</p>
                        <p>Đánh giá: <span>★★★★☆</span></p>
                    </div>
                </div>
                    <div class="cols product location3" onclick="showModal(this)" data-price="150" data-bedrooms="3" data-houseType="townhouse" data-amenities="parking,pool" data-img="img/hotel3.jpg" data-star="★★★★☆">
                        <div class="">
                            <img class="image" src="img/hotel3.jpg" alt="">
                        </div>
                        <div class="info">
                            <h4>Nhà 3</h4>
                            <p>Giá: $150</p>
                            <p>Đánh giá: <span>★★★★☆</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
    </div>
</main>

