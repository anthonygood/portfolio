@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingCollection extends Backbone.Collection
    model: App.Etching.EtchingModel
    url: '/index'
    events:
      "add reset": "sort"

    comparator: (model) -> parseInt model.get('id')

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
