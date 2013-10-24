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
    });
  },
  buildAndAssociateMarkersAndList:function(title, listings){
    var newListing = new ListingsView()
    $.each(listings, function(index, listing){
      var num = index+1
      var sideBarListing = newListing.addListing(num,listing)
      var marker = iPark.makeMarker(num, listing)

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
      data: {q: listing.zip_code}
    }).done(function(neighborhood){
      var neighborhoodView = new NeighborhoodView(neighborhood);
      neighborhoodView.render()
    });
  }
}

function findSpotsFromSearchBar(e, ui) {
  var userInput = $("#autocomplete").val();
  SearchController.findSpots(e, ui, userInput)
}

function onUserEnter() {
  $('.navbar-form').on("submit", findSpotsFromSearchBar)
}

