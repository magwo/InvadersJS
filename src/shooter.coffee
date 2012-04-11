gamejs = require 'gamejs'


class Shooter extends gamejs.sprite.Sprite
  
  rateOfFire = 2.0
  
  constructor: (@rect, @bulletMaker) ->
    @leftKey = 0
    @rightKey = 0
    @fireKey = 0
    @fireCooldown = 0.0
    @bullets = []
  
  handleEvent: (event) ->
    for inputReaction in [{e: gamejs.event.KEY_DOWN, keyVal: 1}, {e: gamejs.event.KEY_UP, keyVal: 0}]
      if inputReaction.e == event.type
        @leftKey = inputReaction.keyVal if event.key == gamejs.event.K_LEFT
        @rightKey = inputReaction.keyVal if event.key == gamejs.event.K_RIGHT
        @fireKey = inputReaction.keyVal if event.key == gamejs.event.K_SPACE
    return event
  
  attemptFire: () ->
    if @fireCooldown <= 0.0
      bullet = @bulletMaker(@rect.clone())
      @bullets.push(bullet)
      @fireCooldown = 1.0 / rateOfFire
    
  update: (dt) ->
    shooterMoveSpeed = 200
    @rect.left += (@rightKey - @leftKey)*dt*shooterMoveSpeed
    
    for bullet in @bullets
      bullet.update(dt)
      
    @fireCooldown = Math.max(0.0, @fireCooldown - dt)
    if @fireKey
      @attemptFire()
    
    for bullet in @bullets
      if bullet.age > 10.0
        # TODO: Remove old flying bullets
      
    
  draw: (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.blit font.render('SHOOTER'), @rect
    
    for bullet in @bullets
      bullet.draw(display)
    return
    


class Bullet extends gamejs.sprite.Sprite
  
  constructor: (@rect, @speed) ->
    @age = 0.0
  update: (dt) ->
    @rect.moveIp(0, @speed*dt)
    @age += dt
    
  draw: (display) ->
    font = new gamejs.font.Font('30px Sans-serif')
    display.blit font.render('B'), @rect
    return


exports.Shooter = Shooter
exports.Bullet = Bullet
  