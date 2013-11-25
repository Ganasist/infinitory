jQuery ->

  $('body').tooltip({ selector: "[data-toggle~='tooltip']"})
  
  $('#user_password').focus ->
    $('.user_password_confirmation').show()

  # $('#user_lab_email').typeahead
  #   local: ['timtrueman', 'JakeHarding', 'vskarich']

  # $("#user_institute_name").autocomplete
  #   source: $("#user_institute_name").data("autocomplete-source")
  #   minLength: 3
  #   delay: 100

  # $("#user_department_name").autocomplete
  #   source: $("#user_department_name").data("autocomplete-source")
  #   minLength: 3
  #   delay: 100

	$('.GLform').removeClass('hidden') if $('#user_role').val() is "group_leader"
	$('.GLform').addClass('hidden') if $('#user_role').val() isnt "group_leader"

	$('.LMform').removeClass('hidden') if $('#user_role').val() isnt "group_leader"
	$('.LMform').addClass('hidden') if $('#user_role').val() is "group_leader"

	$('#user_role').change ->
		$('.GLform').removeClass('hidden') and $('#user_lab_email').val([""]) if $('#user_role').val() is "group_leader"
		$('.GLform').addClass('hidden') and $('#user_institute_name').val([""]) and $('#user_department_id').val([""]) if $('#user_role').val() isnt "group_leader"

		$('.LMform').removeClass('hidden') if $('#user_role').val() isnt "group_leader"
		$('.LMform').addClass('hidden') if $('#user_role').val() is "group_leader"