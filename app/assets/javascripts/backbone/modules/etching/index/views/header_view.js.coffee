@BG.module "Etching.Index", (Index, App) ->

  class Index.HeaderView extends Marionette.LayoutView
    template: "etching/index/templates/header"
    className: "text-center"
    regions:
      bigImage: "#big-image-container"
      bigName: "#big-name-container"

    onShow: ->
      @bigName.show new Index.BigNameView()
