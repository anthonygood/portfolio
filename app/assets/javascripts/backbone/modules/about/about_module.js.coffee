@BG.module "About", (About, App) ->

  class About.Router extends Marionette.AppRouter
    appRoutes:
      "about": "about"

  class About.Controller extends Marionette.Controller
    about: ->
      App.headerRegion.empty()
      App.mainRegion.show new About.View()


  About.addInitializer ->
    new About.Router controller: new About.Controller()
