@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingCollection extends Backbone.Collection
    model: App.Etching.EtchingModel
    url: '/index'

    next: (model) ->
      index = @indexOf model
      if index == @length-1
        @first()
      else
        @at @indexOf(model)+1

    prev: (model) ->
      index = @indexOf model
      if index == 0
        @last()
      else
        @at index-1

    exhibit: ->
      # @get _(@SHORTLIST_IDs).sample()
      @sample()

    fetchWithIds: (array) ->
      @filter (etching) ->
        array.indexOf(etching.id) != -1
