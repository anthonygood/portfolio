@BG.module "Etching.Show", (Show, App) ->

  class Show.ShowView extends Marionette.LayoutView
    template: "etching/show/templates/show"
    regions:
      preview:    "#preview"
      thumbnails: "#thumbnails"
      navigation: "#navigation"

    onShow: ->
      @navigation.show new Show.NavigationView(model: @model)
