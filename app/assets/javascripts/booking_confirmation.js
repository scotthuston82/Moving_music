$(document).on('turbolinks:load', function(){
  // First make sure we're on confirm bookings and that there is some equipment
  if (document.querySelector('#bookings_confirmation')) {
    if (document.querySelector('.equipment_booking')) {

      function updatePrice(e){
        var equipmentPrice = parseInt(
          e.target.parentNode.querySelector('.booking-price').innerText.split("$").pop()
        )
        if (this.checked) {
          console.log("I'm checked");
        } else {
          console.log("Unchecked");
        }
      }

      var equipmentCheckboxes = document.querySelectorAll('.checkmark')
      equipmentCheckboxes.forEach(checkbox => checkbox.addEventListener('change', updatePrice))
    }
  }
})
