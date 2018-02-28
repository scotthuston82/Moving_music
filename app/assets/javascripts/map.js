// This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">


function initAutocomplete() {
    map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 43.6474475, lng: -79.38708780000002},
    zoom: 15,
    mapTypeId: 'roadmap'
  });


  function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
                          'Error: The Geolocation service failed.' :
                          'Error: Your browser doesn\'t support geolocation.');
    infoWindow.open(map);
  }

  // Create the search box and link it to the UI element.
  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }

    // Clear out the old markers.
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };



      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }

// Only run this if we are on the musician update page

      if (document.querySelector('#user_lat')) {
        var userLat = document.querySelector('#user_lat');
        var userLong= document.querySelector('#user_long');
        var userAddress= document.querySelector('#user_address');

        userLat.value = place.geometry.location.lat();
        userLong.value = place.geometry.location.lng();
        userAddress.value = place.formatted_address;
      }
// ===================================================

// Only run this if we are on the new_no_musician page

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
        }

        var set_radius = document.querySelector('#set_radius');

        set_radius.addEventListener('click', function() {
          var radius = document.getElementById('radius').value;
          var venueLat = place.geometry.location.lat();
          var venueLong = place.geometry.location.lng();
          makeCircle(venueLat, venueLong, radius);
        })

// get musicians using searched area as centrepoint

        function makeMarker(latitude, longitude) {
          var marker = new google.maps.Marker({
            position: {lat: latitude, lng: longitude},
            map: map
          });
        }

        var getMusicians = document.querySelector('#musicians_in_radius');

        getMusicians.addEventListener('click', function(e) {
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
              var musicianLatLngObject = new google.maps.LatLng(musician.lat, musician.long);
              if (google.maps.geometry.spherical.computeDistanceBetween(venueLatLngObject, musicianLatLngObject) <= (radius*1000)) {
                makeMarker(musician.lat, musician.long);
                console.log("it hit the if" + musician);
              }
            })
          })
        })
      }
    });
    map.fitBounds(bounds);
  });

}
