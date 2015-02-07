@BG.module "Etching.Show", (Show, App) ->

  class Show.Router extends Marionette.AppRouter
    appRoutes:
      ":id": "show"

  class Show.Controller extends Marionette.Controller
    show: (id) ->
      console.log "Show.Controller.show(id) -> ", id

  Show.addInitializer ->
    new Show.Router controller: new Show.Controller()