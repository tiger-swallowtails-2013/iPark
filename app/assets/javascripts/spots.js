// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


function getMarkers(callback) {
  $.get("spot/find")
  .done(function(data){
    callback(data)
  }).fail(function(){
    console.log('fail')
  })
}


iPark = {}

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
    title: 'Click to Zoom'
  });
  marker.setMap(this.map)

  google.maps.event.addListener(marker, 'click', function() {
    iPark.map.setZoom(18);
    iPark.map.setCenter(marker.getPosition());
    google.maps.event.addListener(marker, 'click', function() {
      iPark.map.setZoom(13)
      iPark.map.setCenter(37.7833, -122.4167)
    })
  });

  google.maps.event.addListener(marker, 'mouseover', function() {
    iPark.infoWindow.open(iPark.map, marker)
    var content =  'Address: '  + String(street) + ' parking type: ' + String(location) + ' '
    var link = '<a href=/spots/' + spot_id + '>Reserve this Spot</a>'
    iPark.infoWindow.setContent(content + link)
  });
}


function initializeMap() {
  if ($('#map-canvas').length > 0){
    iPark.makeMap()
    getMarkers(function(markers){
      iPark.makeMarkers(markers)
    })
  }
}
