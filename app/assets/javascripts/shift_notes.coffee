# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.date-filter').click ->
    date = $(@).data('date')
    $('select[name=with_timestamp').val(date)
    $('select[name=with_timestamp]').closest("form").submit()

$(document).on 'turbolinks:load', ->
  $('.dept-filter').click ->
    dept = $(@).data('dept')
    $('select[name=with_dept]').val(dept)
    $('select[name=with_dept]').closest("form").submit()

$(document).on 'turbolinks:load', ->
  $('.user-filter').click ->
    user = $(@).data('user')
    $('select[name=with_user]').val(user)
    $('select[name=with_user]').closest("form").submit()


$(document).on 'turbolinks:load', ->
  $('.shift_time-filter').click ->
    shift_time = $(@).data('shift_time')
    $('select[name=with_shift_time]').val(shift_time)
    $('select[name=with_shift_time]').closest("form").submit()


$(document).on 'turbolinks:load', ->
  $('.shift_type-filter').click ->
    type = $(@).data('shift_type')
    $('select[name=with_shift_type]').val(type)
    $('select[name=with_shift_type]').closest("form").submit()