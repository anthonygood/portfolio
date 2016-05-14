@BG.module "Etching", (Etching, App) ->

  class Etching.ModalView extends Marionette.LayoutView
    template: "etching/modal/templates/modal"
    className: "modal fade"
    ui:
    	modalContent: ".modal-content"
    	prev: "button.prev"
    	next: "button.next"
    events:
    	"click @ui.prev": "prev"
    	"click @ui.next": "next"

    templateHelpers: ->
    	image: @model.largePrintUrl()

    onShow: ->
    	@$el.modal()

    prev: ->
    	@model = @model.collection.prev @model
    	@render()

    next: ->
    	@model = @model.collection.next @model
    	@render()
