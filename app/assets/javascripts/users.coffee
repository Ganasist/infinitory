jQuery ->

  $('body').tooltip({ selector: "[data-toggle~='tooltip']"})

  $('#inner-form input').prop('disabled', true)
  
  $('#user_password').focus ->
    $('.user_password_confirmation').show()

	$('#user_role').change ->
    test = ->
      $('.GLform').removeClass('hidden') and $('#user_lab_email').val([""]) if $('#user_role').val() is "group_leader"
      $('.GLform').addClass('hidden') and $('#user_institute_name').val([""]) and $('#user_department_id').val([""]) if $('#user_role').val() isnt "group_leader"

      $('.LMform').removeClass('hidden') if $('#user_role').val() isnt "group_leader"
      $('.LMform').addClass('hidden') if $('#user_role').val() is "group_leader"

    $('#inner-form input').prop(
      'disabled', false
      test()
      ) if $('#user_role').val() isnt ""

    $('#inner-form input').prop(
      'disabled', true
      test()
      ) if $('#user_role').val() is "" 

		

      
  

  