@BG.module "Etching.Index", (Index, App) ->

  class Index.HeaderView extends Marionette.ItemView
    template: "etching/index/templates/header"
    className: "big-image text-center"
    ui:
      seeMore: ".see-more"
      videoContainer: ".video-container"
      loadContainer: ".load-container"
      video: "video"
      videoBar: ".video-bar"
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
      @ui.video.css opacity: 0

      if @videoViewed()
        @hideLoadContainer()
        @$("video").hide()
        @$el.addClass "in"
      else
        store = window.localStorage
        store.setItem "header:video:viewed", @headerVideo
        store.setItem "header:video:viewedAt", new Date()

        $video = @ui.video
        $video.on "progress", @progress.bind(@)
        $video.one "ended", @revealHeader.bind(@)

    progress: (e) ->
      video = @$("video")[0]
      endBuffer = if video.buffered.length then video.buffered.end(0) else 0
      currentProgress = ( endBuffer / video.duration ) * 100

      @ui.videoBar.css width: "#{currentProgress}%"

      if currentProgress == 100
        @hideLoadContainer()
        video.play()
        @ui.video.css opacity: 1

    videoViewed:   -> !!@videoViewedAt()
    videoViewedAt: -> window.localStorage.getItem "header:video:viewedAt"
    revealHeader:  -> @$('video').fadeOut @fadeTime, => @$el.addClass("in")
    hideLoadContainer: -> @ui.loadContainer.fadeOut @fadeTime, => @ui.loadContainer.remove()
    goToPiece: (e) ->
      e.preventDefault()
      App.showModal @model

    scrollDown: (e) ->
      $("body").animate
        scrollTop: $("#e1").offset().top

    followLink: (e) ->
      $target = $(e.target)
      if href = $target.attr("href")
        if $target.hasClass "mail" then return window.location = href else return Backbone.history.navigate href, true

    nothing: (e) ->
      e.preventDefault()
      e.stopPropagation()

    onDestroy: -> @ui.video.off()
