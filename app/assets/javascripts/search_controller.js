var SearchController = {
  setupAutocomplete: function() {
    onUserEnter()
    $("#autocomplete").autocomplete({
      source: SearchController.onUserKeystroke,
      minLength: 2,
      select: findSpotsFromSearchBar
    });
  },

  onUserKeystroke: function(request, response){
    $.ajax({
      url: "search/autocomplete",
      data: {q: request.term}
    }).done(function(data){
      response(data)
    });
  },

  findSpots: function(e, ui, searchterm){
    e.preventDefault();
    iPark.clearMarkers();
    var date = $('#searchdate').val()
    $.ajax({
      url:"search/spots",
      data: {q: searchterm, d: date}
    }).done(function(listings){
      SearchController.buildAndAssociateMarkersAndList(searchterm, listings)
       if (listings.length > 0) SearchController.updateNeighborhoodFromListing(listings[0]);
    });
  },
  buildAndAssociateMarkersAndList:function(title, listings){
    var newListing = new ListingsView()
    $.each(listings, function(index, listing){
      var num = index+1
      var sideBarListing = newListing.addListing(num,listing)
      var marker = iPark.makeMarker(num, listing)
      var neighborhoodView = new NeighborhoodView(title)
      neighborhoodView.render()
      function selectOnlyMe(){
        $(".listing").removeClass("selected")
        iPark.focusOnMarker(marker)
        sideBarListing.select()
      }

      google.maps.event.addListener(marker, 'click', selectOnlyMe)
      $(sideBarListing.$elem).on("click", selectOnlyMe)

    })

  },
  updateNeighborhoodFromListing: function(listing) {
    $.ajax({
      url:"search/hood",
      data: {zip: listing.zip_code}
    }).done(function(neighborhood){
      var neighborhoodView = new NeighborhoodView(neighborhood);
      neighborhoodView.render()
      var newLatLng = new google.maps.LatLng(37.7833,-122.4167);
      iPark.map.setCenter(newLatLng);
      iPark.map.setZoom(13);
    });
  }
}

function findSpotsFromSearchBar(e, ui) {
  if ( $("#autocomplete").val().length == 0 )
    {
      var userInput = "Chinatown"
    }
    else
    {
      var userInput = $("#autocomplete").val();
    }
      SearchController.findSpots(e, ui, userInput)
}

function onUserEnter() {
  $('.navbar-form').on("submit", findSpotsFromSearchBar)
}

