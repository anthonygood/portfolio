@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.InquiryView extends Marionette.ItemView
    template: "inquiry/templates/inquiry"
    id: "inquiry"
    events:
      "submit form": "submitInquiry"
      "keyup input": "clear"
    ui:
      "form" : "form"
      "name" : "#name"
      "email": "#email"
      "phone": "#phone"
      "message": "#message"
      "flash": ".flash"

    onShow: ->
      exhibit  = App.Data.etchings.get(11)
      imageUrl = exhibit.randomPrint().large_url
      $('body').css "background-image", exhibit.backgroundImageUrl(imageUrl)

    submitInquiry: (e) ->
      e.preventDefault()
      if @validate()
        @lockForm()
        data = @parseForm e.target
        @model.set(data).save {},
          dataType: "text" # don't expect JSON response
          success: (e) => @saved(e)
          error:   (e) => @err(e)
          always:  (e) => @unlockForm()

    lockForm: ->
      @ui.form.css('opacity', 0.5)
      @$('form :input').prop('disabled', true)

    unlockForm: ->
      @ui.form.css('opacity', 1)
      @$('form :input').prop('disabled', false)

    dismissForm: ->
      @ui.form.fadeOut()

    parseForm: ->
      {
        name:  @ui.name.val()
        phone: @ui.phone.val()
        email: @ui.email.val()
        notes: @ui.message.val()
      }

    validate: ->
      email = @check @ui.email
      name  = @check @ui.name
      if email && name then true else false

    check: ($field) ->
      if $field.val().length < 1
        $field.parents('.form-group').addClass('has-error')
        $field.focus()
        false
      else
        true

    saved: (e) ->
      $.when(@dismissForm()).done ->
        App.vent.trigger "inquiry:success"

    err: (e) ->
      @ui.flash.slideDown()
      @unlockForm()
      App.vent.trigger "inquiry:failure"

    clear: (e) ->
      @$(e.target).parents('.form-group').removeClass('has-error')
      @ui.flash.slideUp()
