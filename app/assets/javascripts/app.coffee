$(document).on 'turbolinks:load', ->
  $('[data-toggle="tooltip"]').tooltip()
  $('.collapse-filters').click ->
    target = $(@)
    collapsed = target.hasClass('collapsed')
    if collapsed
      target.text('[ - ]')
    else
      target.text('[ + ]')
  $('.hide-all-classifications').click ->
    $('.spec-classification').collapse('hide')
    $('.classification-toggler').html('<i class="fa fa-expand"></i>')
    $('.classification-toggler').addClass('collapsed')
  $('.show-all-classifications').click ->
    $('.spec-classification').collapse('show')
    $('.classification-toggler').html('<i class="fa fa-compress"></i>')
    $('.classification-toggler').removeClass('collapsed')
  $('.classification-toggler').click ->
    target = $(@)
    id = target.data('id')
    collapsed = target.hasClass('collapsed')
    if collapsed
      $('.spec-' + id + '-classification').collapse('show')
      target.html('<i class="fa fa-compress"></i>')
      target.removeClass('collapsed')
    else
      $('.spec-' + id + '-classification').collapse('hide')
      target.html('<i class="fa fa-expand"></i>')
      target.addClass('collapsed')