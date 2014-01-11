jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("i").tooltip(
  	placement: "bottom",
  	delay: { show: 200, hide: 100 }
  	)