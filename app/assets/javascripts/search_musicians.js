function setupSearchMusicians(place) {
  booking_address.value = place.formatted_address;
  new_booking.addEventListener('submit', searchMusicians)
  var musicianResulstDiv = document.createElement('div');
  musicianResulstDiv.classList.add('musician-results');

  function searchMusicians(e) {
    e.preventDefault();
    e.stopPropagation();
    console.log($(new_booking).serialize());
    var request = {
      url: '/bookings/search_musicians',
      method: 'post',
      dataType: 'html',
      data: $(new_booking).serialize()
    }
    $.ajax(request)
     .done(displayResults)
     .fail(ajaxFails)
  }
}

function displayResults(responseData) {
  if (responseData) {
    found_musicians_container.innerHTML = responseData
    var foundMusiciansInnerDiv = document.querySelector('.found-musicians-container')
    foundMusiciansInnerDiv.addEventListener('click', function(e){
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
    })
  } else {
    var noNomusicianMsg = document.createElement('p');
    noNomusicianMsg.innerText = 'Sorry, no musicians found, please refine your search.';
    document.querySelector('body').append(noNomusicianMsg);
  }
    addEventListenersToPartialProfileContainers()
}

function ajaxFails() {
  console.log('Error');
}

function updateMusicianOnboarding(lat, long, address) {
  // Only run this if we are on the musician update page
        if (document.querySelector('#user_lat')) {
          var userLat = document.querySelector('#user_lat');
          var userLong= document.querySelector('#user_long');
          var userAddress= document.querySelector('#user_address');

          userLat.value = place.geometry.location.lat();
          userLong.value = place.geometry.location.lng();
          userAddress.value = place.formatted_address;
        }
}


function initAutocomplete() {

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 43.6474475, lng: -79.38708780000002},
    zoom: 15,
    mapTypeId: 'roadmap'
  });

  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
  // var searchBox = new google.maps.places.Autocomplete(input)
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];

  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0)
      return;

    markers.forEach(marker => marker.setMap(null))

    markers = []

    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      if (!place.geometry)
        return

      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport)
        bounds.union(place.geometry.viewport);
      else
        bounds.extend(place.geometry.location);

      setupSearchMusicians(place)

// AJAX call for see musicians in my area, does not do anything to filter

  if (document.querySelector('#musicians_in_radius')) {
    var getMusicians = document.querySelector('#musicians_in_radius')

    function makeMarker(latitude, longitude) {
      var marker = new google.maps.Marker({
        position: {lat: latitude, lng: longitude},
        map: map
      });
      markers.push(marker)
    }
// Map markers, allows to remove and add markers
    function setMapOnAll(map) {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
      }
    }

    // Removes the markers from the map, but keeps them in the array.
    function clearMarkers() {
      setMapOnAll(null);
    }

    // Shows any markers currently in the array.
    function showMarkers() {
      setMapOnAll(map);
    }

    // Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
      clearMarkers();
      markers = [];
    }
//  -----------------------------------------------------

    getMusicians.addEventListener('click', function() {
      deleteMarkers()
      $.ajax({
        url: '/bookings/musicians_in_radius',
        method: 'get',
        dataType: 'json'
      }).done(function(responseData) {
        var venueLat = place.geometry.location.lat();
        var venueLong = place.geometry.location.lng();
        var radius = document.getElementById('radius').value;
        var venueLatLngObject = new google.maps.LatLng(venueLat, venueLong);
        responseData.forEach(function(musician) {
          var musicianLatLngObject = new google.maps.LatLng(musician.latitude, musician.longitude);
          if (google.maps.geometry.spherical.computeDistanceBetween(venueLatLngObject, musicianLatLngObject) <= (radius*1000)) {
            makeMarker(musician.latitude, musician.longitude);
          }
        })
      })
    })
  }

 // ----------------------------------------------------------------

// Only run this if we are on the musician update page
      if (document.querySelector('#radius')) {

        var circle;
        function makeCircle(latitude, longitude, radius) {
          if (circle){
            circle.setMap(null);
          }
          circle = new google.maps.Circle({
            strokeColor: 'rgb(20, 126, 14)',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: 'rgb(26, 148, 1)',
            fillOpacity: 0.35,
            map: map,
            center: {lat: latitude, lng: longitude},
            radius: radius * 1000
          });
          map.fitBounds(circle.getBounds());
        }

        var set_radius = document.querySelector('#set_radius');

        set_radius.addEventListener('click', function() {
          var radius = document.getElementById('radius').value;
          var venueLat = place.geometry.location.lat();
          var venueLong = place.geometry.location.lng();
          makeCircle(venueLat, venueLong, radius);
        })
      }
//  ------------------------------------------------------


    })
    map.fitBounds(bounds);
  })
}

function addEventListenersToPartialProfileContainers() {
  var partialProfileContainers = document.querySelectorAll('.partial-profile-container')
  partialProfileContainers.forEach(showAndHideImage);

}

function showAndHideImage(partialProfileContainer){
  var showDetailsLink = partialProfileContainer.querySelector('.profile-details-show')
  var hideDetailsLink = partialProfileContainer.querySelector('.profile-details-hide')
  var profilePictureContainer = partialProfileContainer.querySelector('.profile-picture-container')
  showDetailsLink.addEventListener('click',function(){
    profilePictureContainer.classList.toggle('shown');
  });

  hideDetailsLink.addEventListener('click',function(){
    profilePictureContainer.classList.toggle('shown');
  });
}
