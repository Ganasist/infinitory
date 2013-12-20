jQuery(function() {
  var before;
  before = $('#user_institute_name').val();
  return $('#user_institute_name').blur(function() {
    var after;
    after = $('#user_institute_name').val();
    $('#user_department_id').val() === "";
    if (before !== after) {
      return $('#department_select').hide();
    }
  });
});
