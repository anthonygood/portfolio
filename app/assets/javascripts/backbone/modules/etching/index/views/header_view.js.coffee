@BG.module "Etching.Index", (Index, App) ->

  class Index.HeaderView extends Marionette.ItemView
    template: "etching/index/templates/header"
    className: "big-image text-center"
    events:
      "click": "goToEtching"
      "click .big-name-container": "nothing" 

    onShow: ->
      print = @randomPrint @model.get('prints')
      @$el.css "background-image", "url('#{print.large_url}')"

    goToEtching: (e) ->
      e.preventDefault()
      Backbone.history.navigate "/#{@etching.get('id')}", trigger: true

    nothing: (e) ->
      e.preventDefault()
      e.stopPropagation()

    randomPrint: (prints) ->
      prints[ _.random (prints.length - 1) ]
