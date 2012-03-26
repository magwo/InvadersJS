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



gamejs.ready(() ->
  console.log "READY!"
  director = new Director(640, 480)

  gameEndedSceneCreator = (gameScene) ->
    console.log "gameEndedSceneCreator called"
    return new scenes.GameEndedScene(director, startSceneCreator)
    
  gameSceneCreator = (startScene) ->
    console.log "gameSceneCreator called"
    return new scenes.GameScene(director, gameEndedSceneCreator)
    
  startSceneCreator = () ->
    console.log "startSceneCreator called"
    return new scenes.StartScene(director, gameSceneCreator)
    
  director.start(startSceneCreator())
)
