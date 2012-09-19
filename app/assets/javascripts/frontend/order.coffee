jQuery ->
  $('input[name="order[customer_type]"]')
    .bind('change', ->
      if $(this).attr('value') == 'company'
        $('#company_wrapper').show("fast")
      else
        $('#company_wrapper').hide("fast")
    )
  $('input[name="order[use_billing_address][]"]')
    .bind('change', ->
      if $(this).is(':checked')
        $('#billing_address_wrapper').show("fast")
      else
        $('#billing_address_wrapper').hide("fast")
    )