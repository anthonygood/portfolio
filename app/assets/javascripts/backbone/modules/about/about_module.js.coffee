@BG.module "About", (About, App) ->

  class About.Router extends Marionette.AppRouter
    appRoutes:
      "about": "about"

  class About.Controller extends Marionette.Controller
    about: ->
      theArtistHimself = App.Data.themes.findWhere(name: "The Artist Himself")

      # themes only have their etchings' IDs, so fetch the etchings themselves
      ids       = _(theArtistHimself.get('etchings')).pluck "id"
      portraits = new App.Etching.EtchingCollection App.Data.etchings.fetchWithIds(ids)

      App.headerRegion.empty()
      App.mainRegion.show new About.View
        model: theArtistHimself
        collection: portraits


  About.addInitializer ->
    new About.Router controller: new About.Controller()
