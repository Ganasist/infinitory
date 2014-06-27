$(document).ajaxStart ->
  $(".spinner").show()
  return


$( document ).ajaxStop ->
  $( ".spinner" ).hide()
  return