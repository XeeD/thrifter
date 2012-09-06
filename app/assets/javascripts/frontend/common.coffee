jQuery ->
  $('a.pjax').pjax('[data-pjax-container]')

  data = null

  $(document)
    .on('pjax:timeout', '[data-pjax-container]', ->
      alert("timeout")
    )
    .on('pjax:error', '[data-pjax-container]', (e, xhr, err) ->
      alert(err)
    )
    .on('pjax:success', '[data-pjax-container]', ->
      data = jQuery.parseJSON($("#pjax_data").text());

      $('nav a.pjax').removeClass('active')
      $('#' + data.active_menu).addClass('active')

      unless data.eval.empty?
        eval(data.eval)
    )

  #JS initialize
  #$(document).on('ready pjax:success') ->
  #  alert("success")