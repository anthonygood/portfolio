@BG.module "Etching.Show", (Show, App) ->

  class Show.NavigationView extends Marionette.ItemView
    template: "etching/show/templates/navigation"
    events:
      "click .back": "home"
      "click .next": "next"
      "click .prev": "prev"

    home: (e) ->
      e.preventDefault()
      App.vent.trigger("navigation:home")

    next: (e) ->
      e.preventDefault()
      App.vent.trigger("navigation:next", @model)

    prev: (e) ->
      e.preventDefault()
      App.vent.trigger("navigation:previous", @model)
