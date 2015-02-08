@BG.module "Etching.Show", (Show, App) ->

  class Show.ThumbnailView extends Marionette.ItemView
    template: "etching/show/templates/thumbnail"
    tagName: "a"
    className: "thumbnail-link"
    events:
      "click": "select"

    select: ->
      @model.collection.trigger "thumbnail:select", @model
