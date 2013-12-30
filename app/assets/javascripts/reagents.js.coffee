jQuery ->
	$('#reagent_expiration').datepicker
		dateFormat: 'yy-mm-dd',
		minDate: 0,
		changeMonth: true,
		changeYear: true,
		showOtherMonths: true,
	  selectOtherMonths: true

	reagent_remaining = $('#reagent_remaining').val()
	$("#reagent_remaining_feedback").html "Amount remaining: " + reagent_remaining + "%"

	$("#reagent_remaining").change ->
		reagent_remaining = $('#reagent_remaining').val()
		$("#reagent_remaining_feedback").html "Amount remaining: " + reagent_remaining + "%"