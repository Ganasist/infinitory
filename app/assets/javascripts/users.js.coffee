jQuery ->
	console.log('hi')
	$('.GLform').removeClass('hidden') if $('#user_role').val() is "group_leader"
	$('.GLform').addClass('hidden') if $('#user_role').val() isnt "group_leader"

	$('.LMform').removeClass('hidden') if $('#user_role').val() in ["lab_manager", "lab_member"]
	$('.LMform').addClass('hidden') if $('#user_role').val() not in ["lab_manager", "lab_member"]


	$('#user_role').change ->
		$('.GLform').removeClass('hidden') if $('#user_role').val() is "group_leader"
		$('.GLform').addClass('hidden') if $('#user_role').val() isnt "group_leader"

		$('.LMform').removeClass('hidden') if $('#user_role').val() in ["lab_manager", "lab_member"]
		$('.LMform').addClass('hidden') if $('#user_role').val() not in ["lab_manager", "lab_member"]


	$('#user_institute_name').autocomplete
  	source: $('#user_institute_name').data('autocomplete-source'),
  	minLength: 3,
  	delay: 50,
  	autoFocus: true

  $('#user_department_name').autocomplete
  	source: $('#user_department_name').data('autocomplete-source'),
  	minLength: 3,
  	delay: 50,
  	autoFocus: true
