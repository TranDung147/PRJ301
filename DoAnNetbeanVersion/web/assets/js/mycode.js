
document.addEventListener("DOMContentLoaded", function() {
    const exploreOffersContainer = document.getElementById("exploreOffersContainer");
    const exploreOffers = Array.from(exploreOffersContainer.getElementsByClassName("explore-card"));
    const itemsPerPage = 6; // Number of elements to show at a time
    let startIndex = 0;

    function showElements(startIndex) {
        exploreOffers.forEach((offer, i) => {
            if (i >= startIndex && i < startIndex + itemsPerPage) {
                offer.style.display = "block";
            } else {
                offer.style.display = "none";
            }
        });

        // Update visibility of navigation buttons based on the current start index
        document.getElementById("prevExplore").style.visibility = startIndex <= 0 ? "hidden" : "visible";
        document.getElementById("nextExplore").style.visibility = startIndex >= exploreOffers.length - itemsPerPage ? "hidden" : "visible";
    }

    document.getElementById("nextExplore").addEventListener("click", function() {
        if (startIndex < exploreOffers.length - itemsPerPage) {
            startIndex++;
            showElements(startIndex);
        }
    });

    document.getElementById("prevExplore").addEventListener("click", function() {
        if (startIndex > 0) {
            startIndex--;
            showElements(startIndex);
        }
    });

    showElements(startIndex); // Initialize with the first set of elements
});





