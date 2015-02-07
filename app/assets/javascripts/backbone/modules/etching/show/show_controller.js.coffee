@BG.module "Etching.Show", (Show, App) ->

  class Show.Router extends Marionette.AppRouter
    appRoutes:
      ":id": "show"


  class Show.Controller extends Marionette.Controller
    initialize: ->
      @listenTo App.vent, "navigation:next", @next
      @listenTo App.vent, "navigation:previous", @prev
      @listenTo App.vent, "navigation:home", @home

    show: (id) ->
      etching = App.Data.etchings.find id: @process(id)
      App.mainRegion.show new Show.ShowView(model: etching)

    process: (id) ->
      parseInt id

    next: (model) ->
      next = App.Data.etchings.next(model)
      Backbone.history.navigate("/#{next.get('id')}", trigger: true)

    prev: (model) ->
      prev = App.Data.etchings.prev(model).get('id')
      Backbone.history.navigate("/#{prev}", trigger: true)

    home: ->
      Backbone.history.navigate('/', trigger: true)


  Show.addInitializer ->
    new Show.Router controller: new Show.Controller()
