@BG.module "Etching.Index", (Index, App) ->

  class Index.HeaderView extends Marionette.ItemView
    template: "etching/index/templates/header"
    className: "big-image text-center"
    events:
      "click": "goToEtching"
      "click .big-name-container": "nothing"
      "click a": "followLink"

    SCHEMES = "neon turquoise pink green glitz".split(" ")

    onShow: ->
      window.header = @
      print = @randomPrint @model.get('prints')
      @$el.css "background-image", @model.backgroundImageUrl(print.large_url)
      @headerShine()

    goToEtching: (e) ->
      e.preventDefault()
      Backbone.history.navigate "/#{@model.get('id')}", trigger: true

    nothing: (e) ->
      e.preventDefault()
      e.stopPropagation()

    randomPrint: (prints) ->
      prints[ _.random (prints.length - 1) ]

    headerShine: () ->
      setTimeout => 
        @changeColour _(SCHEMES).sample()
      , 5000

    changeColour: (colour) ->
      @$('.dots').addClass(colour).removeClass(@prevColour)
      @prevColour = colour
      @headerShine()

    followLink: (e) ->
      if href = $(e.target).attr("href")
        Backbone.history.navigate href, true
