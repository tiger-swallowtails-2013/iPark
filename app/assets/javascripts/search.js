function initializeSearch(){
  setSearchListeners()
  setupAutocomplete()
}


function setSearchListeners(){
  onKeyboardFocus()
  onSearchSuccess()
}

function onSearchSuccess(){
  $("#search").on("ajax:success", function(e, data){
    iPark.makeMarkers(data)
  })
}

function onKeyboardFocus(){
  $("#q").focus(logKeystrokes())
}

function logKeystrokes(){
  $("#q").keyup(function(){
    var q = $("#q").val()
    if (q.length > 2){
      getGuess(q)
    }
  })
}

function getGuess(q){
  $.get("search/autocomplete", { q: q } )
  .done(function(data){
    placeGuess(data)
  })
}

function placeGuess(data){
  $(data).each(function(i,v){
    if (!($("#autocomplete").text === v)){
      $("#autocomplete").html(v)
    }
  })
}

function setupAutocomplete(){
  $("#autocomplete").on("autocompletesearch", function(e, ui) {
    //console.log(e)
    console.log(ui)
  } )
  $("#autocomplete").autocomplete({
    source: [ "mission", "chinatown", "tenderloin", "castro", "russian hill", "financial district", "sunset" ]
  });
}

