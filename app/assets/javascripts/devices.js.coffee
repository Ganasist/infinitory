$(document).ready ->
	$("#check_all:radio").click ->
		$('.check_boxes').prop 'checked', true

	$("#check_none:radio").click ->	
		$('.check_boxes').prop 'checked', false