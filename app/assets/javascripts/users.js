// Generated by CoffeeScript 1.6.3
jQuery(function() {
  $('body').tooltip({
    selector: "[data-toggle~='tooltip']"
  });
  $('#inner-form input').prop('disabled', true);
  $('#user_password').focus(function() {
    return $('.user_password_confirmation').show();
  });
  if ($('#user_role').val() === "group_leader") {
    $('.GLform').removeClass('hidden');
  }
  if ($('#user_role').val() !== "group_leader") {
    $('.GLform').addClass('hidden');
  }
  if ($('#user_role').val() !== "group_leader") {
    $('.LMform').removeClass('hidden');
  }
  if ($('#user_role').val() === "group_leader") {
    return $('.LMform').addClass('hidden');
  }
});

$('#user_role').change(function() {
  var test;
  test = function() {
    if ($('#user_role').val() === "group_leader") {
      $('.GLform').removeClass('hidden') && $('#user_lab_email').val([""]);
    }
    if ($('#user_role').val() !== "group_leader") {
      $('.GLform').addClass('hidden') && $('#user_institute_name').val([""]) && $('#user_department_id').val([""]);
    }
    if ($('#user_role').val() !== "group_leader") {
      $('.LMform').removeClass('hidden');
    }
    if ($('#user_role').val() === "group_leader") {
      return $('.LMform').addClass('hidden');
    }
  };
  if ($('#user_role').val() !== "") {
    $('#inner-form input').prop('disabled', false, test());
  }
  if ($('#user_role').val() === "") {
    return $('#inner-form input').prop('disabled', true, test());
  }
});
