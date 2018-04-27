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
