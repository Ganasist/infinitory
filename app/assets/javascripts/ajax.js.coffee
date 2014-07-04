
$ =>
	ajax = ->
		$(document).ajaxStart ->
			$("#ajax_div").fadeTo(75, 0.45)
			$("#ajax_spinner").fadeTo(75, 1)
		$(document).ajaxStop ->
			$("#ajax_div").fadeTo(75, 1)
			$("#ajax_spinner").fadeTo(75, 0)

	$(document).ready(ajax)
	$(document).on('page:load', ajax)

	startSpinner = ->
	  $("html").css "cursor", "progress"
	  return
	stopSpinner = ->
	  $("html").css "cursor", "auto"
	  return
	$(document).on "page:fetch", startSpinner
	$(document).on "page:receive", stopSpinner