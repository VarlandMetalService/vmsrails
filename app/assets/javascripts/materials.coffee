# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.vat-filter').click ->
    vat = $(@).data('vat')
    $('select[name=with_vat]').val(vat)
    $('select[name=with_vat]').closest("form").submit()

$(document).on 'turbolinks:load', ->
  $('.dept-filter').click ->
    dept = $(@).data('dept')
    $('select[name=with_department]').val(dept)
    $('select[name=with_department]').closest("form").submit()