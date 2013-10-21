// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


function getMarkers(callback) {
  $.get("spot/find")
  .done(function(data){
    console.log(data)
    callback(data)
  }).fail(function(){
    console.log('fail')
  })
}


function initialize() {
  iPark.makeMap()
  getMarkers(function(markers){
    iPark.makeMarkers(markers)
  })
  setSearchListener()
  document.getElementById("search").addEventListener("submit",
    function(event) {
      event.preventDefault();
      iPark.clearMarkers()
    });
}


iPark = {}

var markersArray = []

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
      self.makeMarker(this.latitude, this.longitude, this.street, this.location_type, this.description, this.id )
  });
}

iPark.makeMarker = function (lat, long, street, location, description, spot_id ) {
  var myLatlng = new google.maps.LatLng(lat, long)
  var marker = new google.maps.Marker({
    position: myLatlng,
    title: 'Click to Zoom',
    icon: 'https://chart.googleapis.com/chart?chst=d_map_pin_letter_withshadow&chld='+spot_id+'|FF0000|0000FF'
  });
  marker.setMap(this.map);
  markersArray.push(marker);

  google.maps.event.addListener(marker, 'click', function () {

    iPark.centerAndZoom(marker);
});

  google.maps.event.addListener(marker, 'mouseover', function() {
    iPark.infoWindow.setOptions({disableAutoPan : true })
    iPark.infoWindow.open(iPark.map, marker)
    var content =  'Address: '  + String(street) + ' parking type: ' + String(location) + ' '
    var link = '<a href=/spots/' + spot_id + '>Reserve this Spot</a>'
    iPark.infoWindow.setContent(content + link)
  });
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


function setSearchListener(){
  $("#search").on("ajax:success", function(e, data){
    iPark.makeMarkers(data)
  })
}


$(document).ready(initialize)

