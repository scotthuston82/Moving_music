// This code will run on the new booking form and also the confirm_booking
// form.  Its job is to keep the price of the gig updated as start_time,
// end_time or any of the equipment selections have changed for the event

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
      // build time objects from current time selector states
      var startTimeObj = new Date(startMonthSelect.selectedOptions[0].value + ' '
      + startDaySelect.selectedOptions[0].value + ', '
      + startYearSelect.selectedOptions[0].value + ' '
      + startHourSelect.selectedOptions[0].value + ':'
      + startMinuteSelect.selectedOptions[0].value + ':00')
      var endTimeObj = new Date(endMonthSelect.selectedOptions[0].value + ' '
      + endDaySelect.selectedOptions[0].value + ', '
      + endYearSelect.selectedOptions[0].value + ' '
      + endHourSelect.selectedOptions[0].value + ':'
      + endMinuteSelect.selectedOptions[0].value + ':00')

      // check for end time later than start time to produce valid price
      if (endTimeObj - startTimeObj > 0) {
        var priceFromHourlyRate = (endTimeObj - startTimeObj) / 3600000 * artistHourlyRate
        var priceFromEquipment = 0;
        // if there's any equipment available, add it up
        if (document.querySelector('.equipment_booking')) {
          equipmentCheckboxes.forEach(checkbox => {
            if (checkbox.checked) {
              priceFromEquipment += parseInt(checkbox.parentNode.querySelector('.equipment-cost').innerText.split("$").pop())
            }
          })
        }
        // modify actual Total Price element
        totalPriceSentenceEle.innerText = "Total Price: $" + (priceFromHourlyRate + priceFromEquipment)
      } else {
        totalPriceSentenceEle.innerText = "Please enter valid start and end times to see total price"
      }
    }

    // run update price on page load
    updatePrice();
    // add event listeners to each checkbox and date field that trigger updatePrice
    equipmentCheckboxes.forEach(checkbox => checkbox.addEventListener('change', updatePrice))
    timeSelectorsArray.forEach(timeSelect => timeSelect.addEventListener('change', updatePrice))
  }
})
