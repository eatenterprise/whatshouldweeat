var gmarkers = [];
var lat;
var lng;

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: {lat: -25.363882, lng: 131.044922 }
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
  console.log(marker.getPosition())
}

function removeMarkers() {
  for (i = 0; i < gmarkers.length; i++) {
    gmarkers[i].setMap(null)
  }
}
