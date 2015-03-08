@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingModel extends Backbone.Model
    url: "/show/:id"

    printUrl: (index=0) ->
      @get('prints')[index].medium_url

    largePrintUrl: (index=0) ->
      @get('prints')[index].large_url

    backgroundImageUrl: (url) ->
      ['url("', url, '")'].join('')

    randomPrint: ->
      prints = @get('prints')
      prints[ _.random (prints.length - 1) ]
