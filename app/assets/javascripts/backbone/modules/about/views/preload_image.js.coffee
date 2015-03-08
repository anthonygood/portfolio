@BG.module "About", (About, App) ->
  class About.PreloadImage extends Marionette.ItemView
    template: "about/templates/preload_image"
    className: "fader slow"

    initialize: ->
      @$el.css "background-image", @model.backgroundImageUrl(@model.largePrintUrl())
      @$el.attr "data-target-id", @model.get('id')
