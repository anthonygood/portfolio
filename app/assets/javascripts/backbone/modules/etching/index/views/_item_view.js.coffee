@BG.module "Etching.Index", (Index, App) ->

  class Index.ItemView extends Marionette.ItemView
    template: "etching/index/templates/item"
    events:
      "click a": "goToShow"
    templateHelpers: ->
      colour: @getColour()
      notes: @model.get('prints')[0].notes

    onShow: ->
      src = @model.backgroundImageUrl @model.largePrintUrl()
      @$('.etching-image').css "background-image", src

    goToShow: (e) ->
      e.preventDefault()
      Backbone.history.navigate("/#{@model.get('id')}", trigger: true)

    printUrl: ->
      @model.get('prints')[0].medium_url

    background: ->
      'url("'+@printUrl()+'")'

    getColour: ->
      notes = @model.get('prints')[0].notes
      if colour = notes.match(/(red)|(blue)|(green)|(red)|(yellow)|(neon)|(turquoise)|(gold)/i)
        colour[0].toLowerCase()
      else
        "black"
