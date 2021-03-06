@Hipster ?= {}
Hipster.Routers ?= {}
Hipster.Views ?= {}
Hipster.Models ?= {}
Hipster.Collections ?= {}


$warnings = $('.warnings');
activateClass = do ->
  isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)
  if Detector.webgl
    if !isMobile and navigator.userAgent.match(/Chrom(e|ium)/)
      return '.shouldWork' 
    return '.maybeWork'
  else
    return '.cantWorkMobile' if isMobile
    return '.cantWork'


$ ->
    # Load App Helpers
    require '../lib/app_helpers'
    importer = require './importer'
    sceneKeeper = require './sceneKeeper'

    # Initialize App
    Hipster.Views.AppView = new AppView = require 'views/app_view'

    # Initialize Backbone History
    Backbone.history.start pushState: yes


    $warnings.find(activateClass).addClass('active')

    data = importer.load().then (data)->
      $('.intro .button').text("Start")
      $('.intro .button').removeClass("deactivated")

      $('.intro .button').click =>
        $('.intro').hide()
        $('.warnings').hide()
        sceneKeeper.init(data)
        $('body').addClass('activated')

      $('.showNavigation').click =>
        $('.copy.overview').hide()
        $('.copy.navigation').show()

      $('.showOverview').click =>
        $('.copy.overview').show()
        $('.copy.navigation').hide()


