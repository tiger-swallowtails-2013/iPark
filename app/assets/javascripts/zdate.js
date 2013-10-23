function datepick() {
  $(document).on("click", "#addReservation", function(){
    $("#chooseDateForm").removeClass('hidden');
    $("#addReservation").addClass('hidden');
    $('.date-pick')
    .datePicker(
      {
        clickInput:true,
        closeOnSelect:false,
        selectMultiple:true
      }
    )
    .bind(
        'dpClosed',
        function(e, selectedDates)
        {
          $("input[name=dates]").val(selectedDates);
        }
      )
  })
}

$(document).ready(function(){
  datepick()
});
