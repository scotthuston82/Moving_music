// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {

  if (document.querySelector('.equipment')) {
    const addEquipment = document.querySelector('.add_equipment');
    addEquipment.addEventListener('click', function(e) {

      console.log(e.target);
    })


  }

  })
