# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

set_cookie = (name, value) ->
  document.cookie = name + "=" + value + "; path=/"

delete_cookie = (name) ->
  set_cookie name, ""

get_cookie = (name) ->
  name_eq = name + "="
  ca = document.cookie.split(";")
  i = 0
  while i < ca.length
    c = ca[i]
    c = c.substring(1, c.length)  while c.charAt(0) is " "
    return c.substring(name_eq.length, c.length) if c.indexOf(name_eq) is 0
    i++
  null

$(document).on 'turbolinks:load', ->
  $('.folder-link').each ->
    folder = $(@).data('folder')
    cookie = get_cookie folder
    if cookie
      target = $($(@).attr('href'))
      icon = $($(@).data('icon'))
      target.addClass 'show'
      icon.html '<i class="fa fa-folder-open fa-fw"></i>'
  $('.folder-link').click ->
    target = $($(@).attr('href'))
    icon = $($(@).data('icon'))
    folder = $(@).data('folder')
    if target.hasClass('show')
      icon.html '<i class="fa fa-folder fa-fw text-muted"></i>'
      delete_cookie folder
    else
      icon.html '<i class="fa fa-folder-open fa-fw"></i>'
      set_cookie folder, 1