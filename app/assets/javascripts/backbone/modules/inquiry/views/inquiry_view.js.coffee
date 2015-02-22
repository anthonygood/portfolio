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
      console.log "inquire, sir"
      console.log e
      data = @parseForm e.target
      console.log data
      @model.set(data).save()
      # false

    parseForm: ->
      {
        name:  @ui.name.val()
        phone: @ui.phone.val()
        email: @ui.email.val()
        notes: @ui.message.val()
      }


