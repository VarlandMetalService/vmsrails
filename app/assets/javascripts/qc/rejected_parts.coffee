$(document).on 'turbolinks:load', ->

  template = $('#load-template').html()
  container = $('#load-specific-info')

  $('.shop-order-field').change ->
    temp = $('.temp_information').data('temp');
    shopOrder = $(@).val()
    fromTagField = $('.from-tag-field')
    rejectTagField = $('.reject-tag-field')
    fromTagField.empty()
    fromTagField.append($("<option></option>").attr("value", '').text(''))
    fromTagField.append($("<option></option>").attr("value", 'Original S.O.').text('Original S.O.'))
    if (shopOrder of temp)
      rejectTagField.val(temp[shopOrder] + 1)
      for i in [1..temp[shopOrder]]
        val = 'Reject Tag # ' + i
        fromTagField.append($("<option></option>").attr("value", val).text(val))
    else
      rejectTagField.val(1)
      

  $('.add-load-button').click (event)->
    event.preventDefault()
    container.append(template)

  $("#load-specific-info").on 
    click:->
      $(@).closest('tr').remove()
    '.remove-load-button'