@BG.module "About", (About, App) ->

  class About.View extends Marionette.CompositeView
    template: "about/templates/about"
    id: "about"
    childViewContainer: ".portrait"
    childView: BG.About.PreloadImage
    ui:
      portrait: ".portrait"
    events:
      "mouseenter a": "showLink"
      "mouseleave a": "hideLink"

    onShow: -> @loop()

    showPortrait: ->
      target = @collection.sample().get('id')
      @show target

    show: (target) ->
      @release()
      @$(".fader[data-target-id=#{target}]").addClass "in"

    showLink: (event) ->
      target = event.target.dataset.target
      @$(".fader[data-target-id=#{target}]").addClass "in"

    release: ->
      @ui.portrait.find('.slow.in').removeClass('in')

    hideLink: ->
      @ui.portrait.find('.fast.in').removeClass('in')

    loop: =>
      @showPortrait()
      @loopTimer = 
        setTimeout @loop, 6000

    onDestroy: ->
      clearTimeout @loopTimer
