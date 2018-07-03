# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.vat-filter').click ->
    vat = $(@).data('vat')
    $('select[name=with_vat]').val(vat)
    $('select[name=with_vat]').closest("form").submit()