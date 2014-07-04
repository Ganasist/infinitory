ready = ->
	$(document).ajaxStart ->
		$("#wrapper").fadeTo(50, 0.65)
		$("#ajax_spinner").fadeTo(50, 1)
	$(document).ajaxStop ->
		$("#wrapper").fadeTo(75, 1)
		$("#ajax_spinner").fadeTo(75, 0)

$(document).ready(ready)
$(document).on('page:load', ready)