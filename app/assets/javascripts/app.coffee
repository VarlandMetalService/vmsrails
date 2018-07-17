$(document).on 'turbolinks:load', ->
  $('[data-toggle="tooltip"]').tooltip()
  $('.collapse-filters').click ->
    target = $(@)
    collapsed = $(@).hasClass('collapsed')
    if collapsed
      target.text('[ - ]')
    else
      target.text('[ + ]')