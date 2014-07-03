jQuery ->
	$(document).ajaxStart ->
		$("#wrapper").addClass("ajax_dim")
		$("#ajax_spinner").show()
	$(document).ajaxStop ->
		$("#wrapper").removeClass("ajax_dim")
		$("#ajax_spinner").hide()