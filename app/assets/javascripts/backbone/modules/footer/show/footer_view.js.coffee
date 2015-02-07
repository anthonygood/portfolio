@BG.module "Footer.Show", (Show, App, Backbone, Marionette) ->
  
  class Show.FooterView extends Marionette.ItemView
    template: "footer/show/footer"
