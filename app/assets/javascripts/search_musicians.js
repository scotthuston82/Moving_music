function setupSearchMusicians(place) {
  booking_address.value = place.formatted_address;
  new_booking.addEventListener('submit', searchMusicians)
  var musicianResulstDiv = document.createElement('div');
  musicianResulstDiv.classList.add('musician-results');

  function searchMusicians(e) {
    e.preventDefault();
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
  found_musicians_container.innerHTML = responseData
}

function ajaxFails() {
  console.log('Error', err);
}

function initAutocomplete() {

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 43.6474475, lng: -79.38708780000002},
    zoom: 15,
    mapTypeId: 'roadmap'
  });

  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
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
    })
  })
}
