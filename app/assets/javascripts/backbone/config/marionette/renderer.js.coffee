Backbone.Marionette.Renderer.render = (template, data) ->
  template = JST["backbone/modules/" + template]
  throw "Template not found." unless template
  template(data)
