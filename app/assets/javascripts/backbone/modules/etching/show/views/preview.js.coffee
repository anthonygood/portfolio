@BG.module "Etching.Show", (Show, App) ->

  class Show.Preview extends Marionette.CompositeView
    template: "etching/show/templates/preview"
    className: "preview"
    childViewContainer: ".thumbnails"
    collectionEvents:
      "thumbnail:select": "embiggenThumbnail"

    onShow: ->
      @$(".thumbnails").hide() unless @collection.length > 1

    onRender: ->
      # show loading colours unless image is cached
      view = @
      @$('.medium').each (thing) ->
        if @.complete
          view.$el.addClass "loaded"
        else
          $(@).on 'load', -> view.$el.addClass "loaded"

    embiggenThumbnail: (model) ->
      @model = model
      @$el.removeClass('loaded')
      @render()
