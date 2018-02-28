document.addEventListener('DOMContentLoaded', function(){
  var findMusiciansForm = document.querySelector('#new_booking')
  var musicianResulstDiv = document.createElement('div');
  musicianResulstDiv.classList.add('musician-results');

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
        var foundMusiciansDiv = document.querySelector('.found-musicians-container')
        foundMusiciansDiv.addEventListener('click', function(e){
          if (e.target.localName === 'a') {
            e.preventDefault();
            var profileDetailsDiv = e.target.parentNode.parentNode.querySelector('.partial-profile-details')
            var showDetailsLink = e.target.parentNode.parentNode.querySelector('.profile-details-show')
            var hideDetailsLink = e.target.parentNode.parentNode.querySelector('.profile-details-hide')
            profileDetailsDiv.classList.toggle('shown');
            profileDetailsDiv.classList.toggle('hidden');
            showDetailsLink.classList.toggle('shown');
            showDetailsLink.classList.toggle('hidden');
            hideDetailsLink.classList.toggle('shown');
            hideDetailsLink.classList.toggle('hidden');
          }
        });
      } else {
        var noNomusicianMsg = document.createElement('p');
        noNomusicianMsg.innerText = 'Sorry, no musicians found, please refine your search.';
        document.querySelector('body').append(noNomusicianMsg);
      }
    });
  });
});
