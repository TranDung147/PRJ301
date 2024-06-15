<%@page contentType="text/html" pageEncoding="UTF-8"%>
<main>
    <div class="bodys">
        <div class="container">
            <div class="tittle">
                <h1>Toàn bộ kì nghỉ chỉ với một cú bấm chuột!</h1>
                <h2>Đặt chuyến bay ngay tại đây</h2>
            </div>
            <div class="optionals">
                <div class="optionals-button">
                    <div>
                        <input type="radio" class="khuhoi active">
                        <span>Khứ hồi</span>
                    </div>
                    <div>
                        <input type="radio" class="khuhoi">
                        <span>Một chiều</span>
                    </div>
                    <div>
                        <input type="radio" class="khuhoi">
                        <span>Multi-city</span>
                    </div>
                </div>
                <div style="display: none" id="Hello">Hello</div>
                <div class="row">
                    <div class="col-md-6">
                        <div>
                            <div class="box">
                                <div class="left">
                                    <div><img src="img/airplane.png" alt=""></div>
                                    <div class="start">
                                        <label for="start">Bay từ</label>
                                        <input type="text" id="start" placeholder="Bay từ">
                                    </div>
                                </div>
                                <div class="right">
                                    <div><img src="img/placeholder.png" alt=""></div>
                                    <div class="end">
                                        <label for="end">Bay đến</label>
                                        <input type="text" id="end" placeholder="Bay đến">
                                    </div>
                                </div>
                            </div>
                            <div class="box">
                                <div class="left">
                                    <div><img src="img/people.png" alt=""></div>
                                    <div class="people">
                                        <label for="people">Hành khách</label>
                                        <input type="text" id="people" placeholder="Hành khách">
                                    </div>
                                </div>
                                <div class="right duoi">
                                    <div><img src="img/exit.png" alt=""></div>
                                    <div class="room">
                                        <label for="room">Hạng</label>
                                        <input type="text" id="room" placeholder="Phổ thông">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="box box1">
                            <div class="left">
                                <div><img src="img/calendar.png" alt=""></div>
                                <div class="start-time">
                                    <label for="date">Khởi hành:</label>
                                    <input type="date" id="date">
                                </div>
                            </div>
                            <div class="right">
                                <div><img src="img/calendar.png" alt=""></div>
                                <div class="end-time">
                                    <label for="date">Khứ hồi: </label>
                                    <input type="date" id="dateReturn">
                                </div>
                            </div>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-primary btns"><h6>TÌM CHUYẾN BAY</h6></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
