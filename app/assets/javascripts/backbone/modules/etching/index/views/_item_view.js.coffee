@BG.module "Etching.Index", (Index, App) ->

  class Index.SplashView.ItemView extends Marionette.ItemView
    template: "etching/index/templates/item"
    className: "ragged"
    events:
      "click a": "goToShow"

    onShow: ->
      console.log @model.get('title')

    goToShow: (e) ->
      e.preventDefault()
      console.log "goToShow #{@model.get('id')}"
      Backbone.history.navigate("/#{@model.get('id')}", trigger: true)
