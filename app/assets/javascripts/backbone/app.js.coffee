@BG = do (Backbone, Marionette) ->
  console.log "boot"
  console.log arguments
  $.ajaxSetup
    headers:
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

  App = new Marionette.Application

  App.addRegions
    modalRegion: "#modal-region"
    headerRegion: "#header-region"
    mainRegion:   "#main-region"
    aboutRegion:  "#about-region"
    footerRegion: "#footer"

  App.on "start", ->
    Backbone.history.start(pushState: true) if Backbone.history

  App.showModal = (model) ->
    App.modalRegion.show new App.Etching.ModalView
      model: model

  # catch all link clicks and route via Backbone.history
  $(document).on "click", "a", (e) ->
    href = $(@).attr("href")
    if (href && href.match(/^\/.*/) && $(this).attr("target") != "_blank")
      e.preventDefault()
      Backbone.history.navigate(href, true)

  App
