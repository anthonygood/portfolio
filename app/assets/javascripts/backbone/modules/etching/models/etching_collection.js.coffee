@BG.module "Etching", (Etching, App) ->

  class Etching.EtchingCollection extends Backbone.Collection
    model: App.Etching.EtchingModel
    url: '/index'

    # SHORTLIST_IDs: [
    #   2
    #   5
    #   6
    #   10
    #   11
    #   13
    #   14
    #   15
    #   17
    #   18
    #   19
    #   20
    #   22
    #   23
    #   26
    #   27
    #   30
    #   32
    #   33
    #   36
    #   37
    #   43
    #   45
    #   47
    #   48
    #   50
    #   51
    #   53
    #   54
    #   55
    #   56
    # ]

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
