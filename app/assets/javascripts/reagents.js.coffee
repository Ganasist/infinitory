jQuery ->
	$('#reagent_expiration').datepicker
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
		showOtherMonths: true,
	  selectOtherMonths: true

	sliderColor = ->
		$("#reagent_remaining_feedback").css("color", "black") if 25 < $('#reagent_remaining').val() < 100
		$("#reagent_remaining_feedback").css("color", "#E68A00") if 10 < $('#reagent_remaining').val() <= 25
		$("#reagent_remaining_feedback").css("color", "red") if $('#reagent_remaining').val() <= 10
		return

	sliderColor()

	reagent_remaining = $('#reagent_remaining').val()
	$("#reagent_remaining_feedback").html "Amount remaining: " + reagent_remaining + "%"
	$("#reagent_remaining").change ->
		reagent_remaining = $('#reagent_remaining').val()
		$("#reagent_remaining_feedback").html "Amount remaining: " + reagent_remaining + "%"

		sliderColor()

  $("#reagents th a").live "click", ->
    $.getScript @href
    return false