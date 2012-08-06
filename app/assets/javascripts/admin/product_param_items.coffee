jQuery ->
  $("input[data-copy-to]").each ->
    $(this).keyup ->
      id = $(this).data("copy-to")
      $("##{id}").val($(this).val())