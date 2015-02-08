@BG.module "Etching.Show", (Show, App) ->

  class Show.Preview extends Marionette.CompositeView
    template: "etching/show/templates/preview"
    childViewContainer: ".thumbnails"
    collectionEvents:
      "thumbnail:select": "embiggenThumbnail"

    onShow: ->
      @lockPreviewAccordingToOrientation()
      @$(".thumbnails").hide() unless @collection.length > 1

    lockPreviewAccordingToOrientation: ->
      @lock = @getLock(@options.orientation)
      enclose = (lock, view) ->
        return -> view.fixedLength = @[lock]

      @$('.medium').load enclose(@lock, @)

    getLock: (orientation) ->
      if orientation == "landscape" then "height" else "width"

    onRender: ->
      if @fixedLength
        @$('.medium').css @lock, @fixedLength

    embiggenThumbnail: (model) ->
      @model = model
      @render()
