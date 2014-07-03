jQuery ->
	$(document).ajaxStart ->
		$("#wrapper").fadeTo(75, 0.65)
		$("#ajax_spinner").fadeTo(75, 1)
	$(document).ajaxStop ->
		$("#wrapper").fadeTo(100, 1)
		$("#ajax_spinner").fadeTo(100, 0)