@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingCollection extends Backbone.Collection
    model: App.Etching.EtchingModel
    url: '/index'
