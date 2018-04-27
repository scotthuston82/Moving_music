$(document).on('turbolinks:load', function(){
  if (document.querySelector('#bookings_confirmation')) {
    if (document.querySelector('.equipment_booking')) {
      console.log("I see some equipment");
    }
  }
})
