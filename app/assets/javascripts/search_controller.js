var SearchController = {
  setupAutocomplete: function() {
    onUserEnter()
    // onUserMouseCLick()
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
    e.preventDefault();
    iPark.clearMarkers();
    var userInput = $("#autocomplete").val();
    $.ajax({
      url:"search/spots",
      data: {q: userInput}
    }).done(function(listings){
      // if there are listings:
      // - make an AJAX call with first listing zipcode to get neighborhood
      // - move three lines below into the .done() of the 2nd ajax call
      // - stop passing userInput and instead pass the neighborhood name from the
      //   second ajax call
      var searchView = new SearchView(userInput, listings);
      searchView.render();
       if (listings.length > 0) SearchController.updateNeighborhoodFromListing(listings[0]);
    });
  },

  updateNeighborhoodFromListing: function(listing) {
    $.ajax({
      url:"search/hood",
      data: {q: listing.zip_code}
    }).done(function(neighborhood){
      console.log(neighborhood)
      var neighborhoodView = new NeighborhoodView(neighborhood);
      neighborhoodView.render()
    });
  }
}

function onUserEnter() {
  // When the user mouses down on a neighborhood OR clicks enter, the autocomplete selects it
  // Currently this only works on enter.
  window.addEventListener('keypress', function (e) {
    if (e.keyCode == 13) {
    SearchController.findSpots(e)
    }
  }, false);
}

// function onUserMouseCLick() {
//   window.addEventListener('click', function (e) {
//     SearchController.findSpots(e)
//   })
// }




// if valid zipcode send back listing based on zip code without converting to neighboorhood
// if address send back listing that matches street!
// populate autocomplete database library with potential zips/