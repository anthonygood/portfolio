@BG.module "Data", (Data, App) ->
  Data.etchings = new App.Etching.EtchingCollection()
