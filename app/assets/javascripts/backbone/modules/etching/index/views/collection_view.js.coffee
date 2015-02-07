@BG.module "Etching.Index", (Index, App) ->

  class Index.SplashView.CollectionView extends Marionette.CollectionView
    # template: "etching/index/templates/collection"
    console.log App.Etching.Index.SplashView.ItemView
    childView: Index.SplashView.ItemView

    onShow: ->
      "Showing Index.SplashView.Collection"
