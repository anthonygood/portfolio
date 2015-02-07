@BG.module "Etching.Show", (Show, App) ->

  class Show.Preview extends Marionette.ItemView
    template: "etching/show/templates/preview"

    onShow: ->
      console.log "Show.Preview.onShow()"
