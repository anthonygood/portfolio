@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.InquiryModel extends Backbone.Model
    url: "/inquiry"

    initialize: (options) ->
      if options?.etching_id
        @set 'etching', App.Data.etchings.get(options.etching_id)

    inquiryText: ->
      if etching = @get('etching')
        "Re: \"#{etching.get('title')}\"\n"
