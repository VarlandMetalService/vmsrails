# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.admin_users-controller a[target="_blank"]').each ->
    text = $(@).text() + ' <i class="fa fa-external-link"></i>'
    $(@).html(text)