jQuery ->
	before = $('#user_institute_name').val()
	$('#user_institute_name').blur ->
		after = $('#user_institute_name').val()
		$('#user_department_id').val() == ""
		$('#department_select').hide() if before isnt after

  # $("#department_name").autocomplete
  #   source: $("#department_name").data("autocomplete-source")
  #   minLength: 3
  #   delay: 100