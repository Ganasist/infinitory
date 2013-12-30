$(document).ready ->
  text_max = 500
  $("#comment_feedback").html "* Comment: " + text_max + " characters remaining"
  $("#comment").keyup ->
    text_length = $("#comment").val().length
    text_remaining = text_max - text_length
    $("#comment_feedback").html "* Comment: " + text_remaining + " characters remaining"