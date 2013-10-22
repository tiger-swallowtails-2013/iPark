function setupAutocomplete(){
  $("#autocomplete").autocomplete({
    source: function(request, response){
      $.ajax({
        url: "search/autocomplete",
        data: {q: request.term},
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
          updateListings(data)
        }
      })
      updateNeighborhoodTitle(data)
      iPark.clearMarkers()
    }
  })
}

function updateNeighborhoodTitle(title){
  $("#neighborhood").html("Available Spots in " + title + ":")
}

function updateListings(list){
  var $target = $('.listings')
  clearListings($target)
  $.each(list, function(i, obj) {
    var list_item = buildListItem(i, obj, appendListing)
    appendListing(list_item)
  })
}

function appendListing(list_item){
    $('.listings').append(list_item)
}

function clearListings($target){
  $target.html("")
}

function buildListItem(i, obj){
  var $item = $('.hidden .listing').clone()
  var num = i + 1
  $($item.children()[0]).text("#" + num)
  $($item.children()[1]).text(obj.street)
  $($item.children()[2]).text("$" + obj.price)
  $($item.children()[3]).text("Reserve Spot").attr("href", "/spots/" + obj.id)
  return $item
}