@BG.module "Etching.Index", (Index, App) ->

  class Index.HeaderView extends Marionette.ItemView
    template: "etching/index/templates/header"
    className: "big-image text-center"
    events:
      "click": "goToEtching"
      "click .big-name-container": "nothing"
      "click a": "followLink"

    fadeTime: 250

    onShow: ->
      @$('video').on "ended", =>
        @revealHeader()

    revealHeader: ->
      @$el.css "background-image", "url(large/tabasco_2.jpg)"
      @$('video').fadeOut @fadeTime, => @$el.addClass "in"

    goToEtching: (e) ->
      e.preventDefault()
      Backbone.history.navigate "/#{@model.get('id')}", trigger: true

    nothing: (e) ->
      e.preventDefault()
      e.stopPropagation()

    randomPrint: (prints) ->
      prints[ _.random (prints.length - 1) ]


    changeColour: (colour) ->
      @$('.dots').addClass(colour).removeClass(@prevColour)
      @prevColour = colour
      @headerShine()

    followLink: (e) ->
      if href = $(e.target).attr("href")
        Backbone.history.navigate href, true
