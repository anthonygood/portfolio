@BG.module "Etching.Show", (Show, App) ->

  class Show.ShowView extends Marionette.LayoutView
    template: "etching/show/templates/show"
    regions:
      preview:    "#preview"
      navigation: "#navigation"

    onShow: ->
      prints = new Backbone.Collection @model.get('prints')
      @navigation.show new Show.NavigationView(model: @model)
      @preview.show    new Show.Preview
                                  model: prints.first()
                                  collection: prints
                                  childView: Show.ThumbnailView
