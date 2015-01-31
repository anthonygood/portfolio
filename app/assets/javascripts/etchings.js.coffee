# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $med = $('.medium')
  orientation = $med.data('orientation')
  lock = if $med.data('orientation') == 'landscape'
    'height'
  else
    'width'

  $(window).resize -> 
    $med.css(lock, '')

  $('.thumbnail-link > img').click (e) ->
    $med.css("#{lock}", $med.css(lock))
        .attr('src', $(this).attr('src'))
