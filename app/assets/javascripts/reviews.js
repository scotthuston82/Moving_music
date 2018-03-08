// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('DOMContentLoaded', function(){

  if (document.querySelector('.write_review')) {

    function showReviewModal(e) {
      if (e.target.innerText === "Write review") {
        e.preventDefault();
        const reviewForm = e.target.parentNode.querySelector('.review_form');
        reviewForm.classList.toggle('hidden');
      }
    }

    function hideReviewModal(e) {
      e.preventDefault();
      e.target.parentElement.parentElement.classList.toggle('hidden');
    }

    var closeButton = document.querySelector('.close')
    past_bookings.addEventListener('click', showReviewModal)
    closeButton.addEventListener('click', hideReviewModal)

  }

})
