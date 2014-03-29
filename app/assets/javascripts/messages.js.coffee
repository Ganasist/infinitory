jQuery ->
  text_max = 223
  $("#comment_feedback, #description_feedback").html "* " + text_max + " characters remaining"
  $("#comment, #description").keyup ->
    text_remaining = text_max - $("#comment, #description").val().length
    $("#comment_feedback, #description_feedback").html "* " + text_remaining + " characters remaining"

    $('#comment_feedback, #description_feedback').addClass("overlimit") &&
    $('#feedback_submit, #item_submit').attr("disabled", true) if text_remaining < 0

    $('#comment_feedback, #description_feedback').removeClass("overlimit") &&
    $('#feedback_submit, #item_submit').attr("disabled", false) if text_remaining  >= 0
