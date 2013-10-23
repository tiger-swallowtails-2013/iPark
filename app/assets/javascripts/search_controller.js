var SearchController = {
  setupAutocomplete: function() {
    onUserEnter()
    $("#autocomplete").autocomplete({
      source: SearchController.onUserKeystroke,
      minLength: 2,
      select: SearchController.findSpots
    });
  },

  onUserKeystroke: function(request, response){
    $.ajax({
      url: "search/autocomplete",
      data: {q: request.term}
    }).done(function(data){
      // response is a jQuery-UI function, apparently
      response(data)
    });
  },

  findSpots: function(e, ui){
     iPark.clearMarkers();
    var userInput = $("#autocomplete").val();
    $.ajax({
      url:"search/spots",
      data: {q: userInput}
    }).done(function(listings){
      var searchView = new SearchView(userInput, listings);
      searchView.render();
    });
  }
}

function onUserEnter() {
  window.addEventListener('keypress', function (e) {
    if (e.keyCode == 13) {
    SearchController.findSpots(e)
    }
  }, false);
}




// if valid zipcode send back listing based on zip code without converting to neighboorhood
// if address send back listing that matches street!
// populate autocomplete database library with potential zips/