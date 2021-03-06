// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


function getMarkers(callback) {
  $.get("search/spots")
  .done(function(data){
    callback(data)
  }).fail(function(){
    console.log('fail')
  })
}


iPark = {}

var markersArray = []
var counter = 0
iPark.infoWindow = new google.maps.InfoWindow;

iPark.makeMap = function () {
  var mapOptions = {
    center: new google.maps.LatLng(37.7833, -122.4167),
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  iPark.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
}

iPark.makeMarkers = function (markers) {
  var self = this
  $.each(markers, function(index, element) {
    var marker = self.makeMarker(index, element)
    google.maps.event.addListener(marker, 'click', function () {
      iPark.focusOnMarker(marker)
    });

    google.maps.event.addListener(marker, 'mouseover', function() {
      iPark.infoWindow.setOptions({disableAutoPan : true })
      iPark.infoWindow.open(iPark.map, marker)
      var content =  'Address: '  + String(street) + ' parking type: ' + String(location) + ' '
      var link = '<a href=/spots/' + spot_id + '>Reserve this Spot</a>'
      iPark.infoWindow.setContent(content + link)
    });


  });
}

iPark.makeMarker = function (index, markerData) {
  global = markerData
  var myLatlng = new google.maps.LatLng(markerData.latitude, markerData.longitude)
  var num = index
  var marker = new google.maps.Marker({
    position: myLatlng,
    title: 'Click to Zoom',
    icon: 'https://chart.googleapis.com/chart?chst=d_map_pin_letter_withshadow&chld='+num+'|FF0000|000000'
  });
  marker.setMap(this.map);
  markersArray.push(marker);

  return marker
}

iPark.focusOnMarker = function(marker){
  iPark.centerAndZoom(marker);
}

iPark.centerAndZoom = function(marker) {
  if(iPark.currentlyCenteredOn(marker) && iPark.map.getZoom() == 18){
    iPark.map.setZoom(13);
  }
  else{
    iPark.map.setCenter(marker.getPosition());
    iPark.map.setZoom(18);
  }
}

iPark.currentlyCenteredOn = function(marker) {
  if (iPark.map.getCenter() == marker.position){
    return true
  }
  else{
    return false
  }
}

iPark.clearMarkers = function() {
  for (var i = 0; i < markersArray.length; i++) {
    markersArray[i].setMap(null);
  }
  markersArray = []
}

function initializeMap() {
  if ($('#map-canvas').length > 0){
    iPark.makeMap()
     $(".listing").removeClass("selected")
     SearchController.findSpots(event, ui=0, "Chinatown" )
  }
}
