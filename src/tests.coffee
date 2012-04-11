gamejs = require "gamejs"
scenes = require "scenes"
aliens = require "aliens"
shooter = require "shooter"


describe "shooter", ->
  shooterObj = undefined
  
  beforeEach ->
    shooterObj = new shooter.Shooter(new gamejs.Rect(0, 0, 30, 30))
  
  it "should construct without exceptions", ->
    expect(shooterObj).to.be.an("object")
  


describe "alien", ->
  alien = undefined
  
  beforeEach ->
    alien = new aliens.Alien(new gamejs.Rect(0, 0, 30, 30))
  
  it "should construct without exceptions", ->
    expect(alien).to.be.an("object")
  
  it "should move when moved", ->
    alien.move([10, 10])
    expect(alien.rect.topleft).to.eql([10, 10])



describe "hivecontroller", ->
  
  hiveController = undefined
  beforeEach ->
    sideWallRects = [
      new gamejs.Rect(-100, 0, 100, 3000),
      new gamejs.Rect(640, 0, 100, 3000)
      ]
    hiveController = new aliens.HiveController(sideWallRects, 100)
    
  it "should construct without exceptions", ->
    expect(hiveController).to.be.an("object")
    
  it "should move aliens around", ->
    alienHive = [new aliens.Alien(new gamejs.Rect(50, 0, 30, 30))]
    posBefore = alienHive[0].rect.topleft
    hiveController.update(0.01, alienHive)
    expect(alienHive[0].rect.topleft).to.not.equal(posBefore)
  
  it "should never move aliens outside walls", ->
    alienHive = (new aliens.Alien(new gamejs.Rect(50*i, 0, 30, 30)) for i in [0...10])
    t = 0.0
    while t < 50
      dt = 0.1 + Math.random() * 0.01
      t += dt
      hiveController.update(dt, alienHive)
      for alien in alienHive
        if alien.rect.left < 0.0
          throw new Error("Passed left wall")
        if alien.rect.right > 640.0
          throw new Error("Passed right wall")
        
        
  
  longTestDuration = 200
  it "should move aliens for #{longTestDuration} seconds", ->
    alienHive = (new aliens.Alien(new gamejs.Rect(50*i, 0, 30, 30)) for i in [0...10])
    expect(alienHive.length).to.eql(10)
    posBefore = alienHive[0].rect.topleft
    timer = 0.0
    while timer < longTestDuration
      dt = 0.05 + Math.random() * 0.01
      timer += dt
      hiveController.update(dt, alienHive)
    
    console.log alienHive[0].rect
    expect(alienHive[0].rect.topleft).to.not.equal(posBefore)
    
    
describe "startscene", ->

  sceneChanger = undefined
  scene = undefined
  beforeEach ->
    sceneChanger = 
      replaceSceneCalled: false
      replaceScene: ->
        @replaceSceneCalled = true
    
    scene = new scenes.StartScene(sceneChanger)
    
    
  it "should construct without exceptions", ->
    expect(scene).to.be.an("object")
    
  it "should transition to next scene on right events", ->
    nextSceneCreatorCalled = false
    nextSceneCreator = ->
      nextSceneCreatorCalled = true
    console.dir sceneChanger
    scene = new scenes.StartScene(sceneChanger, nextSceneCreator)
    
    event = new gamejs.event.Event()
    event.type = gamejs.event.KEY_DOWN
    event.key = gamejs.event.K_RIGHT
    scene.handleEvent(event)
    
    scene.update(10.0)
    expect(sceneChanger.replaceSceneCalled).to.be(true)
    expect(nextSceneCreatorCalled).to.be(true)

  
  
  
    
    
    