@BG.module "Etching", (Etching, App) ->

  class Etching.ModalView extends Marionette.LayoutView
    template: "etching/modal/templates/modal"
    className: "modal fade"
    ui:
      modalContent: ".modal-content"
      prev: "button.prev"
      next: "button.next"
      image: ".marquee-image"
    events:
      "click @ui.prev": "prev"
      "click @ui.next": "next"

    templateHelpers: ->
      image: @model.largePrintUrl()

    onRender: ->
      @scrollMid()

    onShow: ->
      @$el.modal()
      $(".modal").one "shown.bs.modal", =>
        @$el.animate scrollTop: @midScreenPoint()

    scrollMid: ->
      @$el.scrollTop @midScreenPoint()

    midScreenPoint: ->
      @ui.image.height() / 2

    prev: ->
      @model = @model.collection.prev @model
      @render()

    next: ->
      @model = @model.collection.next @model
      @render()
