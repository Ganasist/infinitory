jQuery ->
	$( document ).ajaxStart ->
  console.log('starting...')
  return
 
	$( document ).ajaxStop ->
	  console.log('finished!')
	  return