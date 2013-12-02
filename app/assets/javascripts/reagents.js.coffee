jQuery ->
	$('#reagent_expiration').datepicker
		dateFormat: 'yy-mm-dd',
		minDate: 0,
		changeMonth: true,
		changeYear: true,
		showOtherMonths: true,
	  selectOtherMonths: true