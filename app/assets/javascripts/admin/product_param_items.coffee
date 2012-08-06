jQuery ->
  $("input[data-copy-to]").each ->
    id = $(this).data("copy-to")
    $(this).onkeyup ->
      $(id).value = $(this).value
