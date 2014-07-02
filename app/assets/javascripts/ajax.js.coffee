jQuery ->
	$.ajaxStart ->
  console.log('starting...')
  return
 
	$.ajaxStop ->
	  console.log('finished!')
	  return