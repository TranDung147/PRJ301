<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <main>
        <div class="bodys">
            <div class="container">
                <div class="tittle animate__heartBeat">
                    <h1>Đặt khách sạn của bạn ngay hôm nay!</h1>
                </div>

                <div class="optionals">
                    <form action="">
                        <div class="optionals-button">
                            <div>
                                <input type="radio" class="khuhoi active">
                                <span>Một đêm</span>
                            </div>
                            <div>
                                <input type="radio" class="khuhoi">
                                <span>Nhiều đêm</span>
                            </div>
                        </div>

                        <div class="box">
                            <div class="left">
                                <div><img src="img/location.png" alt=""></div>
                                <div class="start">
                                    <label for="city">Thành phố:</label>
                                    <input type="text" id="city" placeholder="Nhập thành phố">
                                </div>
                            </div>
                            <div class="right">
                                <div><img src="img/globe.png" alt=""></div>
                                <div class="end">
                                    <label for="country">Quốc gia:</label>
                                    <input type="text" id="country" placeholder="Nhập quốc gia">
                                </div>
                            </div>
                        </div>

                        <div class="box">
                            <div class="left">
                                <div><img src="img/room.png" alt=""></div>
                                <div class="people">
                                    <label for="rooms">Số phòng:</label>
                                    <input type="number" id="rooms" placeholder="Số phòng cần đặt">
                                </div>
                            </div>
                            <div class="right duoi">
                                <div><img src="img/calendar.png" alt=""></div>
                                <div class="room">
                                    <label for="checkin">Ngày nhận phòng:</label>
                                    <input type="date" id="checkin">
                                </div>
                            </div>
                        </div>

                        <div class="box box1">
                            <div class="left">
                                <div><img src="img/calendar.png" alt=""></div>
                                <div class="room">
                                    <label for="checkout">Ngày trả phòng:</label>
                                    <input type="date" id="checkout">
                                </div>
                            </div>
                            <button type="submit" class="btns">ĐẶT NGAY</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>