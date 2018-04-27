$(document).on('turbolinks:load', function(){
  if (document.querySelector('#bookings_confirmation')) {
    if (document.querySelector('.equipment_booking')) {
      var equipmentCheckboxes = document.querySelectorAll('.checkmark')
      console.log(equipmentCheckboxes);
    }
  }
})
