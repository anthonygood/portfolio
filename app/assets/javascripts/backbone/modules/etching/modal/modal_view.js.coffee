@BG.module "Etching", (Etching, App) ->

  class Etching.ModalView extends Marionette.LayoutView
    template: "etching/modal/templates/modal"
    className: "modal fade"

    onShow: ->
    	@$el.modal()
