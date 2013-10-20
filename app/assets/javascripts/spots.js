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

  // return [[37.792210, -122.406141],
  //         [37.778143, -122.390872],
  //         [37.78367, -122.490],
  //         [37.78339, -122.4167],
  //         ]
}


function initialize() {
  iPark.makeMap()
  getMarkers(function(markers){
    iPark.makeMarkers(markers)
  })
}


iPark = {}

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
      self.makeMarker(element[0], element[1])
  });
}

iPark.makeMarker = function (lat, long) {
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
  });
  google.maps.event.addListener(marker, 'mouseout', function(){
    iPark.infoWindow.close()
  });
}

iPark.infoWindow = new google.maps.InfoWindow({
  content: "This is a test"
});


$("input[value='Search']").on("ajax:success", function(e, data){
  iPark.makeMarkers(data)
})


$(document).ready(initialize)

