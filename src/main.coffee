gamejs = require "gamejs"
v = require "gamejs/utils/vectors"
# gamejs.preload([]);
console.dir v

gamejs.ready(() ->

    display = gamejs.display.setMode([600, 400]);
    font = new gamejs.font.Font('30px Sans-serif')

    x = 0.0
    leftKey = 0.0
    rightKey = 0.0
    
    tick = (msDuration) ->
      events = gamejs.event.get()

      for event in events
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
      
      x += 200.0 * (rightKey - leftKey) * msDuration * 0.001
      
      # game loop
      display.clear()
      rect = new gamejs.Rect(x, 10)
      display.blit font.render('Hello World'), rect
      return
        
    gamejs.time.fpsCallback(tick, this, 65)
)
