var gmarkers = [];
var lat, lng, currentLat, currentLng;

$(document).on('turbolinks:load', function() {
  getLocation();
  // initMap();
})

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(initMap)
  }
}

// function getCoord(position) {
//   currentlat = position.coords.latitude;
//   currentlng = position.coords.longitude;
// }

function initMap(position) {
  currentLat = position.coords.latitude;
  currentLng = position.coords.longitude;
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14,
    center: {lat: currentLat, lng: currentLng }
  });

  map.addListener('click', function(e) {
    removeMarkers();
    placeMarkerAndPanTo(e.latLng, map);
    lat = e.latLng.lat().toFixed(6);
    lng = e.latLng.lng().toFixed(6);
    instructionsChange();
  });
}

function placeMarkerAndPanTo(latLng, map) {
  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    draggable: true
  });
  gmarkers.push(marker)
  map.panTo(latLng);
}

function removeMarkers() {
  for (i = 0; i < gmarkers.length; i++) {
    gmarkers[i].setMap(null)
  }
}

function instructionsChange() {
  $("#direction").animate({opacity: '0'}, 'slow', function() {
      $("#direction").text("Choose the radius of your search")
      $("#direction").animate({opacity: '100'}, 'slow')
      $("#radius-div").css('border', 'solid 2px #41A005').animate({opacity: '100'}, 'slow')
  })
  $("#map").css('border', 'solid 5px black')

}
