function setupAutocomplete(){
  $("#autocomplete").autocomplete({
    source: function(request, response){
      $.ajax({
        url: "search/autocomplete",
        data: {
          q: request.term
        },
        success: function(data){
          response(data)
        }
      })
    },
    minLength: 2,
    select: function(e, ui){
      var data = $(this).val()
      $.ajax({
        url:"search/spots",
        data: {q: data},
        success: function(data){
          iPark.makeMarkers(data)
        }
      })
      updateNeighborhoodTitle(data)
    }
  })
}


function updateNeighborhoodTitle(title){
  $("#neighborhood").html("Available Spots in " + title + ":")
}