if (document.querySelector('#new_booking')){

document.addEventListener('DOMContentLoaded', function(){
  var findMusiciansForm = document.querySelector('#new_booking')
  var musicianResulstDiv = document.createElement('div');
  musicianResulstDiv.classList.add('musician-results')

  findMusiciansForm.addEventListener('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: '/bookings/new/find_musicians',
      method: 'get',
      dataType: 'html',
      data: $(this).serialize(),
    }).done(function(responseData){
      if (responseData) {
        musicianResulstDiv.innerHTML = responseData;
        document.querySelector('body').append(musicianResulstDiv);
      } else {
        var noNomusicianMsg = document.createElement('p');
        noNomusicianMsg.innerText = 'Sorry, no musicians found, please refine your search.';
        document.querySelector('body').append(noNomusicianMsg);
      }
    });
  });
});
}
