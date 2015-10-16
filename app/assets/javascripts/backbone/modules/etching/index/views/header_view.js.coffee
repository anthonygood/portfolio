@BG.module "Etching.Index", (Index, App) ->

  class Index.HeaderView extends Marionette.ItemView
    template: "etching/index/templates/header"
    className: "big-image text-center"
    ui:
      seeMore: ".see-more"
    events:
      "click": "goToPiece"
      "click .big-name-container": "nothing"
      "click .mail": "followLink"
      "click @ui.seeMore": "scrollDown"

    fadeTime: 250
    headerVideo: "video/flytrap.mp4"
    headerBackground: "large/tabasco_2.jpg"

    onRender: ->
      @$el.css "background-image", "url(#{@headerBackground})"

      if @videoViewed()
        @$("video").hide()
        @$el.addClass "in"

      store = window.localStorage
      store.setItem "header:video:viewed", @headerVideo
      store.setItem "header:video:viewedAt", new Date()

    onShow: ->
      return if @videoViewed()
      @$("video").on "ended", =>
        @revealHeader()

      # setTimeout @revealHeader.bind(@), 1000

    videoViewed:   -> !!@videoViewedAt()
    videoViewedAt: -> window.localStorage.getItem "header:video:viewedAt"
    revealHeader:  -> @$('video').fadeOut @fadeTime, => @$el.addClass("in")

    goToPiece: (e) ->
      e.preventDefault()
      Backbone.history.navigate "/#{@model.get('id')}", trigger: true

    nothing: (e) ->
      e.preventDefault()
      e.stopPropagation()

    scrollDown: (e) ->
      $("body").animate
        scrollTop: $("#e1").offset().top

    followLink: (e) ->
      $target = $(e.target)
      if href = $target.attr("href")
        if $target.hasClass "mail" then return window.location = href else return Backbone.history.navigate href, true
