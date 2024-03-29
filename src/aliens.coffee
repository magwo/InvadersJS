gamejs = require 'gamejs'


class Alien extends gamejs.sprite.Sprite
  constructor: (@rect) ->
    console.log "Rect is #{@rect}"
    @initialYOffset = @rect.top
  
  
  setPos: (newPos) ->
    @rect.center(newPos)
    
  setYPos: (yPos) ->
    @rect.center = ([@rect.center[0], yPos])

  move: (delta) ->
    @rect.moveIp(delta)
  
  collidesWithWalls: (wallRects) ->
    for wallRect in wallRects
      overlap = @rect.clip(wallRect)
      if overlap.width != 0 or overlap.height != 0
        return overlap
    return null

exports.Alien = Alien
  
  
exports.HiveController = (sideWallRects, moveSpeed) ->
  
  yOffset = 0.0
  currentTask = null
  
  MoveDownTask = (distance, nextTaskCreator) ->
    console.log "MoveDownTask #{distance}"
    targetYOffset = yOffset + distance
    @update = (dt, aliens) ->
      yOffset = Math.min(yOffset + moveSpeed * dt, targetYOffset)
      for alien in aliens
        alien.setYPos(alien.initialYOffset + yOffset)
      
    @getNextTask = () ->
      if yOffset >= targetYOffset
        return nextTaskCreator()
      else
        return null
    
    return this
  
  MoveSidewaysTask = (direction, nextTaskCreator) ->
    console.log "MoveSidewaysTask #{direction}"
    hitWall = false
    
    @update = (dt, aliens) ->
      for alien in aliens
        alien.move([moveSpeed * direction * dt, 0.0])
      
      for alien in aliens
        overlap = alien.collidesWithWalls(sideWallRects)
        if overlap?
          toMove = -Math.abs(overlap.width)*direction
          for innerAlien in aliens
            innerAlien.move([toMove, 0.0])
          hitWall = true
          break
      return undefined
    
    @getNextTask = () ->
      if hitWall
        return nextTaskCreator()
      else
        return null
      
    return this
  
  
  @update = (dt, aliens) ->
    direction = -1
    
    verticalMoveDistance = 80
    
    moveSidewaysTaskCreator = () ->
      direction = -direction
      return new MoveSidewaysTask(direction, moveDownTaskCreator)
      
    moveDownTaskCreator = () ->
      return new MoveDownTask(80, moveSidewaysTaskCreator)
    
    unless currentTask
      currentTask = moveDownTaskCreator()
    
    currentTask.update(dt, aliens)
    currentTask = currentTask.getNextTask() || currentTask
  
  return this
    
  
    