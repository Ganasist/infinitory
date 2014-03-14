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

  $("#reagents th a").live "click", ->
    $.getScript @href
    return false



	$("div#spinner").hide()
	# when an ajax request starts, show spinner
	$.ajaxStart ->
	  $("div#spinner").show()
	  return
	# when an ajax request complets, hide spinner    
	$.ajaxStop ->
	  $("div#spinner").hide()
	  return