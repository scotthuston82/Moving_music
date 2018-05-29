$(document).on('turbolinks:load', function() {
  if (document.querySelector('#new_user')) {
    // toggleMusicanFields();
    var radioButtons = document.querySelector('#user-kind-radio-buttons')
    var musicianRadioButton = document.querySelector('#kind_musician')
    var clientRadioButton = document.querySelector('#kind_client')
    var musicianFieldsDiv = document.querySelector('.musician-only-fields')

    // listen for clicks on the user_kind radio buttons
    radioButtons.addEventListener('click', toggleMusicanFields)

    function toggleMusicanFields(){
      if (musicianRadioButton.checked === true) {
        if (musicianFieldsDiv.classList.contains('hidden')) {
          musicianFieldsDiv.classList.remove('hidden')
          musicianFieldsDiv.classList.add('shown')
        }
      } else if (musicianRadioButton.checked === false) {
        if (musicianFieldsDiv.classList.contains('shown')) {
          musicianFieldsDiv.classList.remove('shown')
          musicianFieldsDiv.classList.add('hidden')
        }
      }
    }
  }

  $(function() {
    $('.directUpload').find("input:file").each((i, elem) => {
      var fileInput    = $(elem);
      var form         = $(fileInput.parents('form:first'));
      var submitButton = form.find('input[type="submit"]');
      var progressBar  = $("<div class='bar'></div>");
      var barContainer = $("<div class='progress'></div>").append(progressBar);
      fileInput.after(barContainer);
    });
  });

})
