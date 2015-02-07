@BG.module "Etching.Index", (Index, App) ->

  class Index.SplashView extends Marionette.LayoutView
    template: "etching/index/templates/splash"
    regions:
      indexRegion: "#index"

    onShow: ->
      @indexRegion.show new Index.SplashView.CollectionView(collection: App.Data.etchings)

