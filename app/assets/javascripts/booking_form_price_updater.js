// This code will run on the new booking form and also the confirm_booking
// form.  Its job is to keep the price of the gig updated as start_time,
// end_time or any of the equipment selections have changed for the event

// $(document).on('turbolinks:load', function(){
//   // First make sure we're on confirm bookings and that there is some equipment
//   if (document.querySelector('#bookings_confirmation')) {
//     if (document.querySelector('.equipment_booking')) {
//
//       function updatePrice(e){
//         var equipmentPrice = parseInt(
//           e.target.parentNode.querySelector('.equipment-cost').innerText.split("$").pop()
//         )
//         var currentPrice = parseInt(
//           document.querySelector('#booking-price').innerText.split("$").pop()
//         )
//
//         if (this.checked) {
//           document.querySelector('#booking-price').innerText = "Total Price: $" + (currentPrice + equipmentPrice)
//         } else {
//           document.querySelector('#booking-price').innerText = "Total Price: $" + (currentPrice - equipmentPrice)
//         }
//       }
//
//       // get an array of all checkboxes and add event listeners to each
//       var equipmentCheckboxes = document.querySelectorAll('.checkmark')
//       equipmentCheckboxes.forEach(checkbox => checkbox.addEventListener('change', updatePrice))
//     }
//   }
// })

$(document).on('turbolinks:load', function(){
  // First make sure we're on confirm booking or new booking page
  if (document.querySelector('#bookings_confirmation') || document.querySelector('#bookings_new')) {
    var artistHourlyRate = parseInt(document.querySelector('#artist-hourly-rate').innerText)
    var totalPriceSentenceEle = document.querySelector('#booking-price')
    var equipmentCheckboxes = document.querySelectorAll('.checkmark')

    // get all date select fields into variables
    var startYearSelect = document.querySelector('#booking_start_time_1i')
    var startMonthSelect = document.querySelector('#booking_start_time_2i')
    var startDaySelect = document.querySelector('#booking_start_time_3i')
    var startHourSelect = document.querySelector('#booking_start_time_4i')
    var startMinuteSelect = document.querySelector('#booking_start_time_5i')
    var endYearSelect = document.querySelector('#booking_end_time_1i')
    var endMonthSelect = document.querySelector('#booking_end_time_2i')
    var endDaySelect = document.querySelector('#booking_end_time_3i')
    var endHourSelect = document.querySelector('#booking_end_time_4i')
    var endMinuteSelect = document.querySelector('#booking_end_time_5i')

    var timeSelectorsArray = [startYearSelect]
    timeSelectorsArray.push(startMonthSelect)
    timeSelectorsArray.push(startDaySelect)
    timeSelectorsArray.push(startHourSelect)
    timeSelectorsArray.push(startMinuteSelect)
    timeSelectorsArray.push(endYearSelect)
    timeSelectorsArray.push(endMonthSelect)
    timeSelectorsArray.push(endDaySelect)
    timeSelectorsArray.push(endHourSelect)
    timeSelectorsArray.push(endMinuteSelect)

    function updatePrice(e){
      console.log("Ch ch ch ch CHANGES");
    }

    // get an array of all checkboxes and add event listeners to each
    equipmentCheckboxes.forEach(checkbox => checkbox.addEventListener('change', updatePrice))
    timeSelectorsArray.forEach(timeSelect => timeSelect.addEventListener('change', updatePrice))
  }
})
