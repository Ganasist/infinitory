# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#user_password').focus ->
    $('.user_password_confirmation').show()

	$('.GLform').removeClass('hidden') if $('#user_role').val() is "group_leader"
	$('.GLform').addClass('hidden') if $('#user_role').val() isnt "group_leader"

	$('.LMform').removeClass('hidden') if $('#user_role').val() in ["lab_manager", "lab_member"]
	$('.LMform').addClass('hidden') if $('#user_role').val() not in ["lab_manager", "lab_member"]

	$('#user_role').change ->
		$('.GLform').removeClass('hidden') if $('#user_role').val() is "group_leader"
		$('.GLform').addClass('hidden') if $('#user_role').val() isnt "group_leader"

		$('.LMform').removeClass('hidden') if $('#user_role').val() in ["lab_manager", "lab_member"]
		$('.LMform').addClass('hidden') if $('#user_role').val() not in ["lab_manager", "lab_member"]


  $("#user_institute_name").autocomplete
    source: $("#user_institute_name").data("autocomplete-source")
    minLength: 3
    delay: 100
  
  # $("#user_institute_name").on "autocompleteselect", (event, ui) ->
  #   $("#user_department_name").removeAttr "disabled"

  $("#user_department_name").autocomplete
    source: $("#user_department_name").data("autocomplete-source")
    minLength: 3
    delay: 100