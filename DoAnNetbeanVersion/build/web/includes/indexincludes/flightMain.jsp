<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .mainht {
        padding-bottom: 50px;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        width: 100%;
        position: relative;
        background: url('img/citycenter.jpg'); /* Background image */
    }

    .bodyht {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 100%;
    }

    .containerht {
        box-sizing: border-box;
        background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin-top: 30px;
        width: 60%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    /* Header styling */
    .headerht {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
        text-align: center;
    }

    .headerht h1 {
        font-size: 24px;
        color: #333;
        margin-bottom: 10px;
    }

    .headerht .optionals-buttonht {
        display: flex;
        justify-content: center;
        gap: 20px;
    }

    .optionals-buttonht input[type="radio"] {
        width: 10%;
    }

    .optionals-buttonht label {
        background-color: #f0f0f0; /* Background color for labels */
        padding: 10px 25px;
        border-radius: 5px;
        font-size: 16px;
        color: #333;
        transition: background-color 0.3s ease;
    }

    .optionals-buttonht {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* Form styling */
    .optionalht form {
        display: flex;
        flex-direction: column;
        width: 100%;
        gap: 20px;
    }

    .optionalht input{
        margin-top: 0px;
    }


    /* Input row styling */
    .boxht {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }

    .leftht,
    .rightht,
    .leftt,
    .rightt {
        flex: 1;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .leftht img,
    .rightht img,
    .leftt img,
    .rightt img {
        width: 20px;
        height: 20px;
    }

    .containerht img{
        margin-top: 20px;
    }

    .startht,
    .endht,
    .peopleht,
    .roomht {
        display: flex;
        flex-direction: column;
    }

    .containerht label {
        font-size: 14px;
        color: #666;
        margin-bottom: 5px;
    }

    .containerht input[type="text"],
    input[type="number"],
    input[type="date"] {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        width: 100%;
    }

    .containerht input[type="text"]:focus,
    input[type="number"]:focus,
    input[type="date"]:focus {
        border-color: #007bff;
        outline: none;
    }

    /* Submit button row */
    .submit-rowht {
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .btnsht {
        padding: 10px 20px;
        background-color: #007bff;
        color: #ffffff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        width: 100%; /* Full width for the button */
        text-align: center;
    }

    .btnsht:hover {
        background-color: #0056b3;
    }

    .timeht input{
        width: 127%;
    }

    /* Responsive adjustments */
    @media (max-width: 600px) {
        .containerht .boxht {
            flex-direction: column;
        }

        .containerht .optionals-buttonht {
            flex-direction: column;
            align-items: center;
        }

        .headerht {
            flex-direction: column;
            align-items: center;
        }
    }
</style>
<main class="mainht">
    <div class="bodyht">
        <div class="containerht">
            <div class="titleht">
                <h1>Đặt chuyến bay ngay tại đây</h1>
            </div>

            <div class="optionalht">
                <div class="optionals-buttonht">
                    <input type="radio" id="roundTrip" class="khuhoiht active">
                    <label for="roundTrip">Khứ hồi</label>

                    <input type="radio" id="oneWay" class="khuhoiht">
                    <label for="oneWay">Một chiều</label>

                    <input type="radio" id="multiCity" class="khuhoiht">
                    <label for="multiCity">Multi-city</label>
                </div>

                <div class="boxht">
                    <div class="leftht">
                        <div><img src="img/airplane.png" alt=""></div>
                        <div class="startht">
                            <label for="start">Bay từ</label>
                            <input type="text" id="start" placeholder="Bay từ">
                        </div>
                    </div>
                    <div class="rightht">
                        <div><img src="img/placeholder.png" alt=""></div>
                        <div class="endht">
                            <label for="end">Bay đến</label>
                            <input type="text" id="end" placeholder="Bay đến">
                        </div>
                    </div>
                </div>

                <div class="boxht">
                    <div class="leftht">
                        <div><img src="img/people.png" alt=""></div>
                        <div class="peopleht">
                            <label for="people">Hành khách</label>
                            <input type="text" id="people" placeholder="Hành khách">
                        </div>
                    </div>
                    <div class="rightht duoiht">
                        <div><img src="img/exit.png" alt=""></div>
                        <div class="roomht">
                            <label for="room">Hạng</label>
                            <input type="text" id="room" placeholder="Phổ thông">
                        </div>
                    </div>
                </div>

                <div class="boxht box1ht timeht">
                    <div class="leftht">
                        <div><img src="img/calendar.png" alt=""></div>
                        <div class="roomht">
                            <label for="date">Khởi hành:</label>
                            <input type="date" id="date">
                        </div>
                    </div>
                    <div class="rightht">
                        <div><img src="img/calendar.png" alt=""></div>
                        <div class="roomht">
                            <label for="dateReturn">Khứ hồi:</label>
                            <input type="date" id="dateReturn">
                        </div>
                    </div>
                </div>

                <div class="submit-rowht">
                    <button type="submit" class="btnsht">TÌM CHUYẾN BAY</button>
                </div>
            </div>
        </div>
    </div>
</main>

