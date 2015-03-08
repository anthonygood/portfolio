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

  # catch all link clicks and route via Backbone.history
  $(document).on "click", "a", (e) ->
    console.log "clicking happened"
    href = $(@).attr("href")
    if (href && href.match(/^\/.*/) && $(this).attr("target") != "_blank")
      console.log "routing through backbone"
      e.preventDefault()
      Backbone.history.navigate(href, true)

  App
