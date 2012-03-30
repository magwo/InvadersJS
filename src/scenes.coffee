
gamejs = require 'gamejs'
aliens = require 'aliens'

#==============================================================================
exports.StartScene = (sceneChanger, gameSceneCreator) ->

  x = 0.0
  leftKey = 0.0
  rightKey = 0.0
  
  @start = (oldScene) ->
    console.log "Start scene"
  
  @handleEvent = (event) ->
    #console.dir event
    if (event.type == gamejs.event.KEY_DOWN)
      if event.key == gamejs.event.K_LEFT
        leftKey = 1
      else if event.key == gamejs.event.K_RIGHT
        rightKey = 1
      #gamejs.log(event.key)
    if (event.type == gamejs.event.KEY_UP)
      if event.key == 37
        leftKey = 0
      if event.key == 39
        rightKey = 0
    return
  
  @update = (dt) ->
    x += 200.0 * (rightKey - leftKey) * dt
    
    if x > 300
      sceneChanger.replaceScene(gameSceneCreator(this))
    return
      
    
    
  @draw = (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.clear() # to save battery when developing
    rect = new gamejs.Rect(x, 10)
    display.blit font.render('Move me to the right to start game'), rect
    return

  return this


#==============================================================================
exports.GameScene = (sceneChanger, gameEndedSceneCreator, options) ->
  unless options
    options =
      sideWallRects: [
        new gamejs.Rect(-100, 0, 100, 3000)
        new gamejs.Rect(640, 0, 100, 3000) ]
      alienMoveSpeed: 100
      
  alienHive = (new aliens.Alien(new gamejs.Rect(i*50, 10, 30, 30)) for i in [0...10])
  hiveController = new aliens.HiveController(options.sideWallRects, options.alienMoveSpeed)
  

  @start = (oldScene) ->
    console.log "Game scene"

  @draw = (display) ->
    font = new gamejs.font.Font('12px Sans-serif')
    display.clear()
    rect = new gamejs.Rect(10, 30)
    display.blit font.render('Game running'), rect
    for alien, i in alienHive
      display.blit font.render("A#{i}"), alien.rect
    
    return
    
  timeSum = 0
  @update = (dt) ->
    hiveController.update(dt, alienHive)
    timeSum += dt
    if timeSum > 10
      sceneChanger.replaceScene(gameEndedSceneCreator(this))
    
    
  return this


#==============================================================================
exports.GameEndedScene = (sceneChanger, startSceneCreator) ->
  
  @start = (oldScene) ->
    console.log "Game ended"
    
  @draw = (display) ->
    #font = new gamejs.font.Font('30px Sans-serif')
    #display.clear()
    #rect = new gamejs.Rect(30, 50)
    #display.blit font.render('Game over!'), rect
    return
    
  timeSum = 0
  @update = (dt) ->
    timeSum += dt
    if timeSum > 2000
      sceneChanger.replaceScene(startSceneCreator())
    
  return this
  