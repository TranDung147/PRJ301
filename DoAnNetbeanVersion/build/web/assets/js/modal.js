// Function to show the modal
function showModal(element) {
    var modal = document.getElementById("myModal");
    var modalInfo = document.getElementById("modalInfo");
    
    // Extract information from the clicked element
    var price = element.getAttribute('data-price');
    var bedrooms = element.getAttribute('data-bedrooms');
    var houseType = element.getAttribute('data-houseType');
    var amenities = element.getAttribute('data-amenities');
    var imgSrc = element.getAttribute('data-img');
    var star = element.getAttribute('data-star');
    
    // Prepare the modal content
    modalInfo.innerHTML = `
        <style>
        .imgs{
            width: 400px;
            height: 300px;
            border-radius: 15px;
            margin: 0 20px;
        }
        .show{
            display:flex;
            font-size: 20px
        }
        span{
            color:orangered;
        }
        </style>
        <div class="show">
            <div class="modal-left">
                <img class="imgs" src="${imgSrc}" alt="Hotel Image">
            </div>
            <div class="modal-right">
                <h2>Thông tin khách sạn</h2>
                <p>Giá: $${price}</p>
                <p>Số phòng ngủ: ${bedrooms}</p>
                <p>Loại nhà: ${houseType}</p>
                <p>Tiện nghi: ${amenities}</p>
                <p>Đánh giá: <span>${star}</span></p>
            </div>
        </div>
    `;

    // Show the modal
    modal.style.display = "block";
}

// Function to close the modal
function closeModal() {
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
}

// Close the modal when clicking outside of it
window.onclick = function(event) {
    var modal = document.getElementById("myModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
