@BG.module "Etching.Index", (Index, App) ->

  class Index.SplashView.CollectionView extends Marionette.CollectionView
    childView: Index.SplashView.ItemView

    onShow: ->
      "Showing Index.SplashView.Collection"
