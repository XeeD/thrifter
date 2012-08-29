jQuery ->
  $('a.pjax').pjax('[data-pjax-container]', {
    timeout: 1000,
  })

  $('nav a.pjax').bind({
    click: ->
      $('nav a.pjax').removeClass('active')
      $(this).addClass('active')
  })

  $(document)
    .on('pjax:timeout', '[data-pjax-container]', ->
      false
    )
    .on('pjax:error', '[data-pjax-container]', (e, xhr, err) ->
      alert(err)
    )

  #JS initialize
  #$(document).on('ready pjax:success') ->
  #  alert("success")