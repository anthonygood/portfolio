@BG.module "Etching.Show", (Show, App) ->
  
  class Show.ThumbnailView extends Marionette.ItemView
    template: "etching/show/templates/thumbnail"
    tagName: "a"
    className: "thumbnail-link"
