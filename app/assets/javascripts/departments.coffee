# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	before = $('#user_institute_name').val()
	$('#user_institute_name').blur ->
		after = $('#user_institute_name').val()
		$('#department_select').val() == ""
		$('#department_select').hide() if before isnt after

  $("#department_name").autocomplete
    source: $("#department_name").data("autocomplete-source")
    minLength: 3
    delay: 100


	  
