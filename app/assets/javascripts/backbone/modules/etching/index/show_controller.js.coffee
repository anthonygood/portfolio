@EtchingsApp.module "Etching.Index", (Index, EtchingsApp) ->

  class Index.Router extends Marionette.AppRouter
    appRoutes:
      "": "index"

  class Index.Controller extends Marionette.Controller
    index: ->
      EtchingsApp.mainRegion.show new Index.SplashView()

  Index.addInitializer ->
    new Index.Router controller: new Index.Controller()
