gamejs = require "gamejs"
scenes = require "scenes"
aliens = require "aliens"

describe "example", ->
  it "1 should equal 1", () ->
    expect(1).toEqual(1)
    
    
describe "alien", ->
  alien = undefined
  
  beforeEach ->
    alien = new aliens.Alien(new gamejs.Rect(0, 0, 30, 30))
  
  it "should construct without exceptions", ->
    expect(alien).toBeDefined()
  
  it "should move when moved", ->
    alien.move([10, 10])
    expect(alien.rect.topleft).toEqual([10, 10])
    
    

describe "hivecontroller", ->
  
  hiveController = undefined
  beforeEach ->
    sideWallRects = [
      new gamejs.Rect(0, 0, -100, 480),
      new gamejs.Rect(640, 0, 100, 480)
      ]
    hiveController = new aliens.HiveController(sideWallRects)
    
  it "should construct without exceptions", ->
    expect(hiveController).toBeDefined()
    
  it "should move aliens around", ->
    alienHive = [new aliens.Alien(new gamejs.Rect(50, 0, 30, 30))]
    posBefore = alienHive[0].rect.topleft
    hiveController.update(0.01, alienHive)
    expect(alienHive[0].rect.topleft).toNotEqual(posBefore)