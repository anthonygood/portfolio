@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingModel extends Backbone.Model
    url: "/show/:id"
