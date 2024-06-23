window.onload = function() {
    var modal = document.getElementById('id01');
    var errorMessage = document.getElementById('errorMessage').innerText;
    
    if (errorMessage && errorMessage.trim() !== "") {
        modal.style.display = 'block';
    }
};

var modal = document.getElementById('id01');
var modal2 = document.getElementById('id02');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
    if (event.target == modal2) {
        modal2.style.display = "none";
    }
}
