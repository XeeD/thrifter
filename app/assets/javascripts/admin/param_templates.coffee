jQuery ->
  fixHelper = (e, ui)->
    ui.children().each ->
      $(this).width($(this).width())
    ui
  $("#param_groups tbody").sortable
    axis: 'y'
    helper: fixHelper
    update: ->
      url = $(this).parent().data('update-url')
      data = $(this).sortable('serialize')
      $.post(url, data)