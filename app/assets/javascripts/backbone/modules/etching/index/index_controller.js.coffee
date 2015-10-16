@BG.module "Etching.Index", (Index, App) ->

  class Index.Router extends Marionette.AppRouter
    appRoutes:
      "": "index"

  class Index.Controller extends Marionette.Controller
    index: ->
      App.headerRegion.show new Index.HeaderView(model: App.Data.etchings.first())
      App.mainRegion.show new Index.CollectionView(collection: App.Data.etchings)

  Index.addInitializer ->
    new Index.Router controller: new Index.Controller()
