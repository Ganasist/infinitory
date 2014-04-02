jQuery ->
  # $("a[rel~=popover], .has-popover").popover()
  # $("a[rel~=tooltip], .has-tooltip").tooltip()

  $('.dropdown-toggle').dropdown() 
  
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("i").tooltip
    placement: "bottom"
    delay:
      show: 150
      hide: 100

  $(".best_in_place").best_in_place()