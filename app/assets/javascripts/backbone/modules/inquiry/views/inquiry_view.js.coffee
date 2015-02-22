@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.InquiryView extends Marionette.ItemView
    template: "inquiry/templates/inquiry"
    events:
      "submit form": "submitInquiry"
    ui:
      "form" : "form"
      "name" : "#name"
      "email": "#email"
      "phone": "#phone"
      "message": "#message"

    initialize: ->
      console.log "init"
      window.inquiry = @

    onShow: ->
      @$form = $('form')

    submitInquiry: (e) ->
      e.preventDefault()
      data = @parseForm e.target
      @model.set(data).save {},
        dataType: "text" # don't expect JSON response
        success: (e) => @saved(e)
        error:   (e) => @err(e)

    parseForm: ->
      {
        name:  @ui.name.val()
        phone: @ui.phone.val()
        email: @ui.email.val()
        notes: @ui.message.val()
      }

    saved: (e) ->
      console.log "SAVED, ", e
      App.vent.trigger "inquiry:success"

    err: (e) ->
      console.log "There was an error: ", e
      App.vent.trigger "inquiry:failure"
