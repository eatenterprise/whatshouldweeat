var gmarkers = [];
var lat;
var lng;

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14,
    center: {lat: 32.7156, lng: -117.1581 }
  });

  map.addListener('click', function(e) {
    removeMarkers();
    placeMarkerAndPanTo(e.latLng, map);
    lat = e.latLng.lat().toFixed(6)
    lng = e.latLng.lng().toFixed(6)
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
