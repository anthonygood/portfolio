@BG.module "Etching.Index", (Index, App) ->

  class Index.ItemView extends Marionette.ItemView
    template: "etching/index/templates/item"
    events:
      "click a": "goToShow"

    onShow: ->
      src = @model.backgroundImageUrl @model.printUrl()
      @$('.etching-image').css "background-image", src

    goToShow: (e) ->
      e.preventDefault()
      Backbone.history.navigate("/#{@model.get('id')}", trigger: true)

    printUrl: ->
      @model.get('prints')[0].medium_url

    background: ->
      'url("'+@printUrl()+'")'
