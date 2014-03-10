jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("i").tooltip(
  	placement: "bottom",
  	delay: { show: 150, hide: 100 }
  	)

  # Activating Best In Place 
  $('.best_in_place').best_in_place()