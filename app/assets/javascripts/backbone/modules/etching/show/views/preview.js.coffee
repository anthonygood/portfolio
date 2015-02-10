@BG.module "Etching.Show", (Show, App) ->

  class Show.Preview extends Marionette.CompositeView
    template: "etching/show/templates/preview"
    childViewContainer: ".thumbnails"
    collectionEvents:
      "thumbnail:select": "embiggenThumbnail"

    onShow: ->
      @lock = new Show.Lock(@$('.medium'), @options.orientation)
      @$(".thumbnails").hide() unless @collection.length > 1

    onRender: ->
      @lock.applyLock(@$('.medium')) if @lock

    embiggenThumbnail: (model) ->
      @model = model
      @render()
