@BG.module "Etching.Index", (Index, App) ->

  class Index.Router extends Marionette.AppRouter
    appRoutes:
      "": "index"

  class Index.Controller extends Marionette.Controller
    index: ->
      view        = App.mainRegion.show new Index.SplashView()
      window.view = view

  Index.addInitializer ->
    new Index.Router controller: new Index.Controller()
