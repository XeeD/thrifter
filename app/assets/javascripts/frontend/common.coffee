jQuery ->
  $('a.pjax').pjax('[data-pjax-container]', {
    timeout: 1000,
  })

  data = null

  $(document)
    .on('pjax:timeout', '[data-pjax-container]', ->
      false
    )
    .on('pjax:error', '[data-pjax-container]', (e, xhr, err) ->
      alert(err)
    )
    .on('pjax:success', '[data-pjax-container]', ->
      data = jQuery.parseJSON($("#pjax_data").text());

      $('nav a.pjax').removeClass('active')
      $('#' + data.active_menu).addClass('active')
    )

  #JS initialize
  #$(document).on('ready pjax:success') ->
  #  alert("success")