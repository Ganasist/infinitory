jQuery ->
	$.ajaxStart ->
  console.log('starting...')
  return

	# when an ajax request complets, hide spinner    
	$.ajaxStop ->
	  console.log('finished!')
	  return