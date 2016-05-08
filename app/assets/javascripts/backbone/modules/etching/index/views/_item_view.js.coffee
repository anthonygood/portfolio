@BG.module "Etching.Index", (Index, App) ->

  class Index.ItemView extends Marionette.ItemView
    template: "etching/index/templates/item"
    events:
      "click": "viewItem"

    templateHelpers: ->
      colour: "black"
      notes: @model.get('prints')[0].notes

    onShow: ->
      src = @model.backgroundImageUrl @model.largePrintUrl()
      @$('.etching-image').css "background-image", src

    viewItem: ->
      App.modalRegion.show new App.Etching.ModalView
        model: @model

    printUrl: ->
      @model.get('prints')[0].medium_url

    background: ->
      'url("'+@printUrl()+'")'
