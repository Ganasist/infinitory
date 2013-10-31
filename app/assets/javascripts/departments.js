// Generated by CoffeeScript 1.6.3
var departmentFlower;

if ((typeof gon !== "undefined" && gon !== null) && ($("#departmentFlower").length)) {
  departmentFlower = new CodeFlower("#departmentFlower", 300, 300);
  departmentFlower.update(gon.department);
  console.log(gon.department);
}

jQuery(function() {
  var before;
  before = $('#user_institute_name').val();
  return $('#user_institute_name').blur(function() {
    var after;
    after = $('#user_institute_name').val();
    $('#department_select').val() === "";
    if (before !== after) {
      $('#department_select').hide();
    }
    return $("#department_name").autocomplete({
      source: $("#department_name").data("autocomplete-source"),
      minLength: 3,
      delay: 100
    });
  });
});
