

var doOnLoad = function(){
  initializeMap()
  SearchController.setupAutocomplete()
}

$(document).ready(function(){
  doOnLoad()
});

$(window).bind('page:change', doOnLoad);
