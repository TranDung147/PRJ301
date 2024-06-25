<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vn">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>QTALD - Website đặt vé máy bay pro vjp FPT</title>

        <!-- Bootstrap JS and dependencies -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />

        <link href="assets/css/headerfooter.css" rel="stylesheet" />
        <link href="assets/css/index.css" rel="stylesheet" />
    </head>

    <% 
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
    <%@include file="includes/header.jsp" %>
    <% } else { %>
    <%@include file="includes/header_user.jsp" %>
    <% } %>
    
    <!-- Body Section -->
    <main>
        <!-- 1 - Carousel Section -->


        <div id="myCarousel1" class="sec1 carousel slide" data-bs-ride="carousel" data-bs-interval="3000">

            <div class="carousel-inner">
                <div class="carousel-item active">

                    <img src="img/caurong.jpg" class="d-block w-100 img-fluid" alt="Slide 1" />
                </div>
                <div class="carousel-item">

                    <img src="img/hand.jpg" class="d-block w-100 img-fluid" alt="Slide 2" />
                </div>
                <div class="carousel-item">

                    <img src="img/city.jpg" class="d-block w-100 img-fluid" alt="Slide 3" />
                </div>
                <div class="carousel-item">

                    <img src="img/saigoncity.jpg" class="d-block w-100 img-fluid" alt="Slide 4" />
                </div>
                <div class="carousel-item">

                    <img src="img/causonghan.jpg" class="d-block w-100 img-fluid" alt="Slide 5" />
                </div>
            </div>
        </div>
        <!-- 2 - Offers Section -->
        <section class="offers my-5">
            <div class="container-body">
                <h2 class="text-center">Special Offers</h2>
                <ul class="offers-nav list-unstyled d-flex align-items-center">
                    <li class="flex-fill">
                        <div class="row">
                            <div class="col-md-6 offer-card active">
                                <a href="https://youtu.be/L8XbI9aJOXk">
                                    <div class="card mb-4">
                                        <img src="img/caurong.jpg" class="card-img-top" alt="Offer 1" />
                                        <div class="card-body">
                                            <h5 class="card-title">Offer 1</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 offer-card active">
                                <a href="https://youtu.be/L8XbI9aJOXk">
                                    <div class="card mb-4">
                                        <img src="img/hand.jpg" class="card-img-top" alt="Offer 2" />
                                        <div class="card-body">
                                            <h5 class="card-title">Offer 2</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </section>
        <!-- 3 - Explore Section -->
        <section class="explore my-5">
            <div class="container-body">
                <h2 class="text-center">Explore</h2>
                <p class="text-center">
                    These popular destinations have a lot to offer
                </p>
                <ul class="explores-nav list-unstyled d-flex align-items-center">
                    <li>
                        <button id="prevExplore" class="btn btn-link">
                            <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chevron-left" fill="currentColor"
                                 xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                  d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z" />
                            </svg>
                        </button>
                    </li>
                    <li class="explore-cards">
                        <div class="row" id="exploreOffersContainer">
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/caurong.jpg" class="card-img-top" alt="Place 1" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 1</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/hand.jpg" class="card-img-top" alt="Explore 2" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 2</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/city.jpg" class="card-img-top" alt="Explore3" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 3</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/saigoncity.jpg" class="card-img-top" alt="explore 4" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 4</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/causonghan.jpg" class="card-img-top" alt="explore 5" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 5</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/saigoncity.jpg" class="card-img-top" alt="explore 6" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 6</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/city.jpg" class="card-img-top" alt="explore 7" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 7</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 explore-card">
                                <div class="card mb-4">
                                    <img src="img/hand.jpg" class="card-img-top" alt="explore 8" />
                                    <div class="card-body">
                                        <a href="https://youtu.be/L8XbI9aJOXk">
                                            <h5 class="card-title">Offer 8</h5>
                                            <p class="card-text">Details of the special offer.</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <button id="nextExplore" class="btn btn-link">
                            <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor"
                                 xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                  d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z" />
                            </svg>
                        </button>
                    </li>
                </ul>
            </div>
        </section>
        <!-- 4 - Trending Section -->
        <section class="exploration my-5">
            <div class="container-body">
                <h2 class="text-center">Trending Tourist Spots</h2>
                <p class="text-center">Most popular choices for travelers</p>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Tourist Spot 1</h5>
                                <p class="card-text">Description of the tourist spot.</p>
                            </div>
                            <img src="img/causonghan.jpg" class="card-img-bottom" alt="Tourist Spot 1" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Tourist Spot 2</h5>
                                <p class="card-text">Description of the tourist spot.</p>
                            </div>
                            <img src="img/city.jpg" class="card-img-bottom" alt="Tourist Spot 2" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Tourist Spot 3</h5>
                                <p class="card-text">Description of the tourist spot.</p>
                            </div>
                            <img src="img/hand.jpg" class="card-img-bottom" alt="Tourist Spot 3" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Tourist Spot 4</h5>
                                <p class="card-text">Description of the tourist spot.</p>
                            </div>
                            <img src="img/saigoncity.jpg" class="card-img-bottom" alt="Tourist Spot 4" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Tourist Spot 5</h5>
                                <p class="card-text">Description of the tourist spot.</p>
                            </div>
                            <img src="img/caurong.jpg" class="card-img-bottom" alt="Tourist Spot 5" />
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- 5 - Searching willing tour -->
        <section class="willing">
            <div class="container-body">
                <div class="row content">
                    <div id="myCarousel" class="col-md-8 carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="img/caurong.jpg" class="d-block w-100" alt="Description of image" />
                            </div>
                            <div class="carousel-item">
                                <img src="img/causonghan.jpg" class="d-block w-100" alt="Description of image" />
                            </div>
                            <div class="carousel-item">
                                <img src="img/hand.jpg" class="d-block w-100" alt="Description of image" />
                            </div>
                        </div>
                    </div>
                    <form class="sec5form col-md-4" action="">
                        <h1>Điểm đến cần tìm</h1>
                        <p>Điểm đến:</p>
                        <select class="diadiem">
                            <option value="#">--Chọn địa điểm--</option>
                            <option value="">Hồ Chí Minh</option>
                            <option value="">Đà Nẵng</option>
                            <option value="">Nha Trang</option>
                            <option value="">Phú Quốc</option>
                        </select>
                        <p>Số người:</p>
                        <input type="number" min="1" placeholder="Bạn đi bao nhiêu người" />
                        <p>Ngày đi:</p>
                        <input type="date" />
                        <p>Ngày về:</p>
                        <input type="date" />
                        <div class="buttonlol">
                            <button type="submit nottub">Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!-- 6 - Các điểm đến được chúng tôi ưa thích -->
        <section class="favorite">
            <div class="container-body">
                <h2 class="text-center">Các điểm đến được ưa thích</h2>
                <div class="fav">
                    <div class="fav-link-group">
                        <a href="#" id="KV">Khu vực</a>
                        <a href="#" id="TP">Thành phố</a>
                        <a href="#" id="QT">Được quan tâm nhất</a>
                    </div>
                    <ul class="fav-item-group">
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Hà Nội</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">TP. Hồ Chí Minh</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Đà Nẵng</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item last fl">
                            <a class="fav-link" href="#">Thừa Thiên Huế</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Quảng Trị</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Quảng Bình</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Quảng Nam</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item last fl">
                            <a class="fav-link" href="#">Bình Dương</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Quảng Nam</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item last fl">
                            <a class="fav-link" href="#">Bình Dương</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                        <li class="fav-item fl">
                            <a class="fav-link" href="#">Vũng Tàu</a>
                            <span class="fav-detail">Detal about it</span>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
        <!-- 7 - Why to choose section-->
        <section class="whytochoose">
            <div class="container-body">
                <h2 class="text-center">Lý do bạn nên chọn QTALD</h2>
                <div class="cont">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="img/why1.jpg" alt="Diverse Choice" />
                            <h3>Đa dạng sự lựa chọn</h3>
                            <p>
                                Tìm kiếm niềm vui với gần nửa triệu điểm tham quan, phòng
                                khách sạn và nhiều trải nghiệm thú vị.
                            </p>
                        </div>
                        <div class="col-md-3">
                            <img src="img/why2.png" alt="Best Prices" />
                            <h3>Giá tốt, vui hết mình</h3>
                            <p>Trải nghiệm chất lượng với giá tốt, giá siêu tiết kiệm.</p>
                        </div>
                        <div class="col-md-3">
                            <img src="img/why3.jpg" alt="Easy and Comfort" />
                            <h3>Dễ dàng thao tác</h3>
                            <p>
                                Đặt vé xác nhận ngay, miễn xếp hàng, miễn phí hủy, tiện lợi
                                cho bạn tha hồ khám phá.
                            </p>
                        </div>
                        <div class="col-md-3">
                            <img src="img/why4.jpg" alt="Trustful" />
                            <h3>Tín nhiệm lâu năm</h3>
                            <p>
                                Tham khảo đánh giá chân thực. Dịch vụ hỗ trợ tận tình, đồng
                                hành cùng bạn mọi lúc, mọi nơi.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <%@include file="includes/footer.jsp" %>