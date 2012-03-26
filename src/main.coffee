gamejs = require "gamejs"
v = require "gamejs/utils/vectors"
scenes = require "scenes"
# gamejs.preload([]);


Director = (@w, @h) ->

  active = false
  activeScene = null

  @tick = (msDuration) ->
    if active
      if activeScene.handleEvent
        activeScene.handleEvent(event) for event in gamejs.event.get()
      else
        # Just empty event queue
        gamejs.event.get()
      if activeScene.update
        activeScene.update(msDuration * 0.001)
      if activeScene.draw
        activeScene.draw(display)
        
  @replaceScene = (scene) ->
    oldScene = activeScene
    activeScene = scene
    if activeScene.start
      activeScene.start(oldScene)
  
  @start = (scene) ->
    active = true
    @replaceScene(scene)
    
  display = gamejs.display.setMode([w, h]);
  gamejs.time.fpsCallback(@tick, this, 30);
  return this


StartScene = (sceneChanger, gameSceneCreator) ->
    
  x = 0.0
  leftKey = 0.0
  rightKey = 0.0
  
  @start = (oldScene) ->
    console.log "Start scene"
  
  @handleEvent = (event) ->
    #console.dir event
    if (event.type == gamejs.event.KEY_DOWN)
      if event.key == 37
        leftKey = 1
      else if event.key == 39
        rightKey = 1
      #gamejs.log(event.key)
    if (event.type == gamejs.event.KEY_UP)
      if event.key == 37
        leftKey = 0
      if event.key == 39
        rightKey = 0
  
  @update = (dt) ->
    x += 200.0 * (rightKey - leftKey) * dt
    
    if x > 300
      sceneChanger.replaceScene(gameSceneCreator(this))
      
    
    
  @draw = (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.clear()
    rect = new gamejs.Rect(x, 10)
    display.blit font.render('Move me to the right to start game'), rect
    return

  return this


    
GameScene = (sceneChanger, gameEndedSceneCreator) ->

  @start = (oldScene) ->
    console.log "Game scene"

  @draw = (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.clear()
    rect = new gamejs.Rect(10, 30)
    display.blit font.render('Game running'), rect
    return
    
  timeSum = 0
  @update = (dt) ->
    timeSum += dt
    if timeSum > 2
      sceneChanger.replaceScene(gameEndedSceneCreator(this))
    
    
  return this

GameEndedScene = (sceneChanger, startSceneCreator) ->
  
  @start = (oldScene) ->
    console.log "Game ended"
    
  @draw = (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.clear()
    rect = new gamejs.Rect(10, 50)
    display.blit font.render('Game ended, wait for reset...'), rect
    return
    
  timeSum = 0
  @update = (dt) ->
    timeSum += dt
    if timeSum > 2
      sceneChanger.replaceScene(startSceneCreator())
    
  return this

gamejs.ready(() ->
  console.log "READY!"
  director = new Director(640, 480)
  
  startSceneCreator = null

  gameEndedSceneCreator = (gameScene) ->
    console.log "gameEndedSceneCreator called"
    return new GameEndedScene(director, startSceneCreator)
    
  gameSceneCreator = (startScene) ->
    console.log "gameSceneCreator called"
    return new GameScene(director, gameEndedSceneCreator)
    
  startSceneCreator = () ->
    console.log "startSceneCreator called"
    return new StartScene(director, gameSceneCreator)
    
  director.start(startSceneCreator())
)
