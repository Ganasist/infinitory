jQuery ->
  $("#user_institute_name").autocomplete
    source: $("#user_institute_name").data("autocomplete-source")
    minLength: 3
    delay: 100
  
  $("#user_institute_name").on "autocompleteselect", (event, ui) ->
    $("#user_department_name").removeAttr "disabled"

  $("#user_department_name").autocomplete
    source: $("#user_department_name").data("autocomplete-source")
    minLength: 3
    delay: 100

  $("#user_lab_name").autocomplete
    source: $("#user_lab_name").data("autocomplete-source")
    minLength: 3
    delay: 100
