jQuery ->
  $("#group_leader_institute_name").autocomplete
    source: $("#group_leader_institute_name").data("autocomplete-source")
    minLength: 3
    delay: 100
  
  $("#group_leader_institute_name").on "autocompleteselect", (event, ui) ->
    $("#group_leader_department_name").removeAttr "disabled"

  $("#group_leader_department_name").autocomplete
    source: $("#group_leader_department_name").data("autocomplete-source")
    minLength: 3
    delay: 100
