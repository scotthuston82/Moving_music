// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {

  if (document.querySelector('.equipment')) {

    const addEquipment = document.querySelector('.new_equipment');

    $(function(){
      $("form").submit(function(e){

        e.preventDefault();

        var action = $(this).attr('action');
        var method = $(this).attr('method');

        const eCategory = $(this).find('#equipment_category').val();
        const eDetails = $(this).find('#equipment_details').val();
        const ePrice = $(this).find('#equipment_price').val();

        var data = $(this).serializeArray();

        $.ajax({
          method: method,
          url: action,
          data: data,
          dataType: 'script'
        })
      })
    })
  }

})
