jQuery ->
	$(document).ajaxStart ->
		$("#wrapper").fadeTo(75, 0.65)
		$("#ajax_spinner").show()
	$(document).ajaxStop ->
		$("#wrapper").fadeTo(75, 1)
		$("#ajax_spinner").hide()