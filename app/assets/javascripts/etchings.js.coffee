# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $('.thumbnail-link > img').click ->
    $med = $('.medium')
    $med.css('width', $med.css('width'))
        .attr('src', $(this).attr('src'))