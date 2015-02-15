@BG.module "Etching.Index", (Index, App) ->

  class Index.CollectionView extends Marionette.CollectionView
    childView: Index.ItemView
