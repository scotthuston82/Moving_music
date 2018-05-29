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
      fileInput.fileupload({
        fileInput:        fileInput,
        url:              form.data('url'),
        type:             'POST',
        autoUpload:       true,
        formData:         form.data('form-data'),
        paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
        dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
        replaceFileInput: false,
        progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          progressBar.css('width', progress + '%')
        },
        start: function (e) {
          submitButton.prop('disabled', true);

          progressBar.
            css('background', 'green').
            css('display', 'block').
            css('width', '0%').
            text("Loading...");
        },
        done: function(e, data) {
          submitButton.prop('disabled', false);
          progressBar.text("Uploading done");

          // extract key and generate URL from response
          var key   = $(data.jqXHR.responseXML).find("Key").text();
          var url   = '//' + form.data('host') + '/' + key;

          // create hidden field
          var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
          form.append(input);
        },
        fail: function(e, data) {
          submitButton.prop('disabled', false);
          progressBar.
            css("background", "red").
            text("Failed");
        }
      });
    });
  });
})
