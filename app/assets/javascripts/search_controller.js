var SearchController = {
  setupAutocomplete: function() {
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
    var userInput = $(this).val();
    $.ajax({
      url:"search/spots",
      data: {q: userInput}
    }).done(function(listings){
      var searchView = new SearchView(userInput, listings);
      searchView.render();
    });
  }
}
