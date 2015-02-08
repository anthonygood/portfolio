@BG.module "Etching.Show", (Show, App) ->

  class Show.Lock
    constructor: ($el, @orientation) ->
      @dimension = @getLock(@orientation)
      @getSize($el)

    applyLock: ($el) ->
      $el.css(@dimension, @size)

    getSize: ($el) ->
      enclose = (context, dimension) ->
        return -> context.size = @[dimension]
      $el.load enclose(@, @dimension)

    getLock: (orientation) ->
      if orientation == "landscape" then "height" else "width"
