@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingModel extends Backbone.Model
    url: "/show/:id"

    printUrl: (index=0) ->
      @get('prints')[index].medium_url

    backgroundImageUrl: (url) ->
      ['url("', url, '")'].join('')

    randomPrint: ->
      prints = @get('prints')
      prints[ _.random (prints.length - 1) ]
