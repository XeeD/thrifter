jQuery ->
    # check radio/check_box field on keyup action
    # copy text field value to radio/check_box value
    $("input[data-copy]").live("keyup", ->
      form_input = $(this).prev('.new_value')
      form_input.val($(this).val())
      form_input.attr("checked", "checked")
    )

    # New text field param
    $(".add_new_field_link").live("click", ->
      html = $(this).parent().clone()
      # reset text field input value
      html.find('.new_value_input').val("")

      # reset check box input value and uncheck it
      check_box = html.find('.new_value')
      check_box.val("")
      check_box.attr("checked", false)

      # hide add next link
      $(this).hide()

      #append new block
      $(this).closest("ul").append(html)
    )
