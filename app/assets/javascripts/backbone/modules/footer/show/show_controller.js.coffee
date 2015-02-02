@EtchingsApp.module "Footer.Show", (Show, EtchingsApp) ->
  
  Show.Controller = 
    showFooterView: ->
      EtchingsApp.footerRegion.show new @getFooterView()

    getFooterView: ->
      new Show.FooterView()
