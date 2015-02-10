@BG.module "Etching.Index", (Index, App) ->

  class Index.SplashView.ItemView extends Marionette.ItemView
    template: "etching/index/templates/item"
    events:
      "click a": "goToShow"

    goToShow: (e) ->
      e.preventDefault()
      Backbone.history.navigate("/#{@model.get('id')}", trigger: true)
