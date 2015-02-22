@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.ItemInfoView extends Marionette.LayoutView
    template: "inquiry/templates/item_info"
