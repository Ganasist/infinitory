jQuery ->
	$('#reagent_expiration').datepicker
		dateFormat: 'yy-mm-dd',
		minDate: 0,
		showOtherMonths: true,
	  selectOtherMonths: true

  $('input#reagent_name').typeahead
	  name: 'accounts',
	  local: ['timtrueman', 'JakeHarding', 'vskarich']