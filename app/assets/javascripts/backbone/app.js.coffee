@EtchingsApp = do (Backbone, Marionette) ->
  console.log "app setup"

  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header"
    mainRegion:   "#main-region"
    footerRegion: "#footer"

  App.addInitializer ->
    App.module("Splash").start()
    App.module("Footer").start()

  App.on "start", ->
    console.log "starting"
    Backbone.history.start() if Backbone.history

  App
