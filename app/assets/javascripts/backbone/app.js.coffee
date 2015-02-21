@BG = do (Backbone, Marionette) ->
  $.ajaxSetup
    headers:
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    mainRegion:   "#main-region"
    footerRegion: "#footer"

  App.on "start", ->
    Backbone.history.start(pushState: true) if Backbone.history

  App
