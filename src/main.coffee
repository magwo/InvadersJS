gamejs = require "gamejs"
v = require "gamejs/utils/vectors"
scenes = require "scenes"
# gamejs.preload([]);
console.dir v


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


StartScene = (sceneChangeListener, @gameSceneCreator) ->
  
  x = 0.0
  leftKey = 0.0
  rightKey = 0.0
  
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
      sceneChangeListener.replaceScene(@gameSceneCreator(this))
      
    
    
  @draw = (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.clear()
    rect = new gamejs.Rect(x, 10)
    display.blit font.render('Hello World'), rect
    return

  return this


    
GameScene = (gameOverScene) ->

  @draw = (display) ->
    display.clear()
    
  return this  

gamejs.ready(() ->

    director = new Director(640, 480)
    director.start(new StartScene(director, (startScene) -> new GameScene()))
)
