jQuery ->
	console.log('hi')
	$('#user_role').change ->
		console.log($('#user_role').val())
		$('.GLform').removeClass('hidden') if $('#user_role').val() is "group_leader"
		$('.GLform').addClass('hidden') if $('#user_role').val() isnt "group_leader"

		$('.LMform').removeClass('hidden') if $('#user_role').val() in ["lab_manager", "lab_member"]
		$('.LMform').addClass('hidden') if $('#user_role').val() not in ["lab_manager", "lab_member"]
