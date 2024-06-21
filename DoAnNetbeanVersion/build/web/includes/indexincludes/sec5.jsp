<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
          <form class="form col-md-4" action="">
            <h1>Điểm đến cần tìm</h1>
            <p>Điểm đến:</p>
            <select name="" id="">
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
            <button type="submit">Tìm kiếm</button>
            </div>
          </form>
        </div>
      </div>
    </section>