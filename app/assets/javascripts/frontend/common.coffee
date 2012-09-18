jQuery ->
  $('a:not([data-remote]):not([data-pjax-section]):not([data-behavior]):not([data-skip-pjax])').pjax('[data-pjax-container]')

  $('a[data-pjax-section]').pjax('[data-pjax-section-container]');

  $.pjax.defaults.timeout = 3000

  data = null

  $(document)
    .on('pjax:timeout', '[data-pjax-container]', ->
    )
    .on('pjax:error', '[data-pjax-container]', (e, xhr, err) ->
      #alert(err)
    )
    .on('pjax:success', '[data-pjax-container]', ->
      data = jQuery.parseJSON($("#pjax_data").text());

      if data != null
        if data.active_menu != null
          $('nav a').removeClass('active')
          $('#' + data.active_menu).addClass('active')

        unless data.eval != null
          eval(data.eval)

      $('#shopping_cart').html($('#pjax_shopping_cart').html())
    )
