@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.InquiryModel extends Backbone.Model
    url: "/inquiry"

    initialize: (options) ->
      if options?.etching_id
        @set 'etching', App.Data.etchings.get(options.etching_id)

    inquiryText: ->
      if etching = @get('etching')
        "Regarding: \"#{etching.get('title')}\"\nPrice: £#{etching.get('price')}\n"
