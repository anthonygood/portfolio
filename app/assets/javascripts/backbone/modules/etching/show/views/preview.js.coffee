@BG.module "Etching.Show", (Show, App) ->

  class Show.Preview extends Marionette.CompositeView
    template: "etching/show/templates/preview"
    childViewContainer: ".thumbnails"

