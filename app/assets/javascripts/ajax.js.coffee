ajax = ->
	$(document).ajaxStart ->
		$("#ajax_div").fadeTo(50, 0.65)
		$("#ajax_spinner").fadeTo(50, 1)
	$(document).ajaxStop ->
		$("#ajax_div").fadeTo(75, 1)
		$("#ajax_spinner").fadeTo(75, 0)

$(document).ready(ajax)
$(document).on('page:load', ajax)


# start_spinner = ->
# 	$("#ajax_spinner").fadeTo(50, 1)

# stop_spinner = ->
# 	$("#ajax_spinner").fadeTo(50, 0)

# $(document).ready(start_spinner)
# $(document).ready(stop_spinner)
# $(document).on('page:fetch', start_spinner)
# $(document).on('page:receive', stop_spinner)