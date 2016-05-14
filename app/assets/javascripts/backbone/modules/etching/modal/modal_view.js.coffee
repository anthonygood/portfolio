@BG.module "Etching", (Etching, App) ->

  class Etching.ModalView extends Marionette.LayoutView
    template: "etching/modal/templates/modal"
    className: "modal fade"
    ui:
    	modalContent: ".modal-content"

    templateHelpers: ->
    	image: @model.largePrintUrl()

    onShow: ->
    	@$el.modal()
    # 	@ui.modalContent.css "background-image", "url(#{@model.largePrintUrl()})"


