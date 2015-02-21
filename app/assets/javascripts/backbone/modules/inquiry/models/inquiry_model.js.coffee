@BG.module "Inquiry", (Inquiry, App) ->
  class Inquiry.InquiryModel extends Backbone.Model
    url: "/inquiry"
