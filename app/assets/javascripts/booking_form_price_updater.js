// This code will run on the new booking form and also the confirm_booking
// form.  Its job is to keep the price of the gig updated as start_time,
// end_time or any of the equipment selections have changed for the event

$(document).on('turbolinks:load', function(){
  // First make sure we're on confirm bookings and that there is some equipment
  if (document.querySelector('#bookings_confirmation')) {
    if (document.querySelector('.equipment_booking')) {

      function updatePrice(e){
        var equipmentPrice = parseInt(
          e.target.parentNode.querySelector('.equipment-cost').innerText.split("$").pop()
        )
        var currentPrice = parseInt(
          document.querySelector('#booking-price').innerText.split("$").pop()
        )

        if (this.checked) {
          document.querySelector('#booking-price').innerText = "Total Price: $" + (currentPrice + equipmentPrice)
        } else {
          document.querySelector('#booking-price').innerText = "Total Price: $" + (currentPrice - equipmentPrice)
        }
      }

      // get an array of all checkboxes and add event listeners to each
      var equipmentCheckboxes = document.querySelectorAll('.checkmark')
      equipmentCheckboxes.forEach(checkbox => checkbox.addEventListener('change', updatePrice))
    }
  }
})
