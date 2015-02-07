@BG.module "Footer", (Footer, App) ->

  @startWithParent = false

  API = 
    show: ->
      Footer.Show.Controller.showFooterView()

  Footer.on "start", ->
    console.log "FooterModule started..."
    API.show()
