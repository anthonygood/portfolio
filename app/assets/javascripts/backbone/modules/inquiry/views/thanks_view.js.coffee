@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.ThanksView extends Marionette.ItemView
    template: "inquiry/templates/thanks"
    id: "inquiry"
    events:
      "click a": "back"

    back: (e) ->
      e.preventDefault()
      Backbone.history.navigate('/', trigger: true)

    onDestroy: ->
      $('body').css "background-image", ""
