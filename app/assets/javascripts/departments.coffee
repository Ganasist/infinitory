if gon? && ($("#departmentFlower").length)
	departmentFlower = new CodeFlower("#departmentFlower", 300, 300)
	departmentFlower.update(gon.department)
	# console.log gon.department

jQuery ->
	before = $('#user_institute_name').val()
	$('#user_institute_name').blur ->
		after = $('#user_institute_name').val()
		$('#department_select').val() == ""
		$('#department_select').hide() if before isnt after

  # $("#department_name").autocomplete
  #   source: $("#department_name").data("autocomplete-source")
  #   minLength: 3
  #   delay: 100