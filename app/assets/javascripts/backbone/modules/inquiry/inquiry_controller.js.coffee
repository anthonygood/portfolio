@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.InquiryRouter extends Marionette.AppRouter
    appRoutes:
      "buy(/:id)": "buy"
      "inquire"  : "inquire"

  class Inquiry.InquiryController extends Marionette.Controller
    initialize: ->
      console.log "InquiryController"

    buy: (id) ->
      return Backbone.history.navigate('/inquire', trigger: true) unless id
      etching = App.Data.etchings.get(id)
      inquiry = new Inquiry.InquiryModel(etchingId: id)
      App.mainRegion.show new Inquiry.InquiryView model: inquiry

    inquire: ->
      inquiry = new Inquiry.InquiryModel()
      App.mainRegion.show new Inquiry.InquiryView model: inquiry
  
  Inquiry.addInitializer ->
    new Inquiry.InquiryRouter controller: new Inquiry.InquiryController()
