var gmarkers = [];
var lat;
var lng;
var eventFired = false;

$(document).on('turbolinks:load', function() {
  initMap();
  eventFired = false;
})

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14,
    center: {lat: 32.7156, lng: -117.1581 }
  });

  map.addListener('click', function(e) {
    removeMarkers();
    placeMarkerAndPanTo(e.latLng, map);
    lat = e.latLng.lat().toFixed(6);
    lng = e.latLng.lng().toFixed(6);
    if(eventFired === false){
      instructionsChange();
      eventFired = true;
    }
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
      $('#radius-div').show()
      $('#create-button').show()
      $("#direction").text("Choose the radius of your search and click create")
      $("#direction").animate({opacity: '100'}, 'slow')
      $("#radius-div").animate({opacity: '100'}, 'slow')
  })
  $("#map").css('border', 'solid 5px black')

}
