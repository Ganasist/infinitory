jQuery ->
	$("#check_all:radio").click ->
		$('.linked_users').prop 'checked', true

	$("#check_none:radio").click ->	
		$('.linked_users').prop 'checked', false