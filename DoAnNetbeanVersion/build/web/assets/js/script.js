// script.js
const startInput = document.getElementById('start');
const endInput = document.getElementById('end');

// Initialize Leaflet map
const map = L.map('map').setView([0, 0], 2); // Default view

// Add OpenStreetMap tile layer
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors'
}).addTo(map);

// Initialize search box
startInput.addEventListener('input', function(event) {
    searchPlace(event.target.value);
});

endInput.addEventListener('input', function(event) {
    searchPlace(event.target.value);
});

function searchPlace(query) {
    // Perform search and display results
    console.log('Searching for:', query);
    // Implement your search functionality here
}
