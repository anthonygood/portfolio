@BG.module "Etching.Show", (Show, App) ->

  class Show.Preview extends Marionette.CompositeView
    template: "etching/show/templates/preview"
    childViewContainer: ".thumbnails"
    collectionEvents:
      "thumbnail:select": "embiggenThumbnail"

    initialize: (options) ->
      @lock = @getLock(options.orientation)

    onShow: ->
      enclose = (lock, callback) ->
        return -> callback @[lock]

      @$('.medium').load enclose(@lock, @setLockValue) 

    setLockValue: (val) =>
      @fixedLength = val

    getLock: (orientation) ->
      if orientation == "landscape" then "height" else "width"

    onRender: ->
      if @fixedLength
        @$('.medium').css @lock, @fixedLength

    embiggenThumbnail: (model) ->
      @model = model
      @render()
