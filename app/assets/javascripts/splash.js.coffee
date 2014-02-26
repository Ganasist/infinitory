jQuery ->
	jumboHeight = $(".jumbotron").outerHeight()

	parallax = ->
	  scrolled = $(window).scrollTop()
	  $(".bg").css "height", (jumboHeight - scrolled) + "px"
	  return

	$(window).scroll (e) ->
	  parallax()
	  return