//
//  doomScroll.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/23/24.
// gonna try to set this file up as more of a generic blueprint for other microgames
//

// add the win screen and funny max face and a label and transition. pretty good
// maybe mess with the sum amount needed for it to be deleted

import SpriteKit
import GameplayKit

class doomScroll: SKScene {
    
    
    var oLock = true
    let sound = SKAction.playSoundFileNamed("maxBG", waitForCompletion: false)
    let swipe = SKAction.playSoundFileNamed("swipe", waitForCompletion: false)
    let maxWin = SKAction.playSoundFileNamed("anita", waitForCompletion: false)
    let maxLose = SKAction.playSoundFileNamed("mammamia", waitForCompletion: false)
    
    var sum = 0
    var initialTouchLocation: CGPoint?
    var currentTouchLocation: CGPoint?
    
    var lock = false
    
    
    var screen = SKSpriteNode()
    var whichScreen = 1
    
    var hitScreen = false
    
    var hand = SKSpriteNode()
    var hitbox = SKSpriteNode()
    //   let customFont = UIFont(name: "wariofont", size: 16.0)// check if this works
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    
    
    //timer
    var gameT = 0
    

    
    
    
    var sx = 380
    var sy = 170
    var screenSy = 140
    var sm = 7
    var dy = 0
    
    
    override func sceneDidLoad(){
        remainingTime = 2.0
        totalTime = 2.0
        makeBackground()
        makeFeature()
        makeFeature2()
        makeFeature3()
        // makeFeature4()
        //makeFeature()
        //   makeFeature();
        //  makeSoy();
        
        
        
        
    }
    
    override func didMove(to view: SKView) {
        
        
    }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        initialTouchLocation = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        
        // Calculate the difference in the Y direction
        
        //this needs to be fixed
        let deltaY = touchLocation.y - previousLocation.y
        sum += Int(deltaY)
        
        sy += sum / 10
        if(lock == false){
            screenSy += sum / 10
        }
        
        
        
        if(sy > 390 && lock == false){
            lock = true
            if(whichScreen == 2){
                screenSy += 125
            }else{
                screenSy += 75
            }
            
            hitbox.run(swipe)
            whichScreen += 1
            print(whichScreen)
            
        }
      
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(whichScreen == 1 && lock == false){
            screenSy = 140
        }
        if(whichScreen == 2 && lock == false){
            screenSy = 455
        }
        sum = 0
        sx = 380
        sy = 170
        lock = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        hand.position = CGPoint(x:sx + 230, y:sy - 160)
        screen.position = CGPoint(x:sx, y: screenSy-265)
      //  if(whichScreen == 3)
        
        //timerstuff
        gameT += 1
        
        if(remainingTime > 0.0){
            timerNode.xScale = remainingTime / totalTime
        }
        if(remainingTime < 0.0){
            if(win == false){
                label.run(maxLose)
                label.fontColor = UIColor.red
                label.text = "Doomscroll incomplete..."
            }
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.8)
                view.presentScene(sammy, transition: transition)
            }
        }
        
        if(gameT % 10 == 0){
            remainingTime -= 0.1
        }
        
        if(whichScreen == 4){
            win = true
            if(oLock){
                label.run(maxWin)
                oLock = false
            }
            label.text = "Great!"
            
            //add swap to game here and timer
            //add sound
        }
        
        
        
        
        
        
    }
    
    
    func makeBackground(){
        let background = SKSpriteNode(imageNamed: "pone")
        background.position = CGPoint(x: 400, y: 200) //where its at
        background.zPosition = 3 //kind of like layers in photoshop 0 furthest back 100000 foreground
        background.xScale = 0.37
        background.yScale = 0.23
        addChild(background)
        background.run(sound)
        
        //timer
        timerNode = SKShapeNode(rectOf: CGSize(width: remainingTime*50, height: 5))
        timerNode.position = CGPoint(x: size.width - 50, y: size.height/2)
        timerNode.zPosition = 8
        timerNode.fillColor = .green  // Initial color
        timerNode.zRotation = .pi/2
        addChild(timerNode)
        
        label.position = CGPoint(x: size.width/2 + 130, y: 340)
        label.text = "Scroll!"
        label.zPosition = 4
        label.fontColor = UIColor.green
        label.fontSize = 50
        addChild(label)
        
    }
    
    func makeFeature(){
        //this will be hand that scrolls
        hand = SKSpriteNode(imageNamed:"truehand")
        hand.position = CGPoint(x: sx-200, y: sy)
        hand.zPosition = 5
        hand.zRotation = 0
        hand.xScale = 0.45
        hand.yScale = 0.36
        addChild(hand)
    }
    
    func makeFeature2(){
        //this will be the screen
        screen = SKSpriteNode(imageNamed: "wow")
        screen.position = CGPoint(x: sx, y: screenSy - 265)
        screen.zPosition = 1
        screen.xScale = 0.5
        screen.yScale = 0.48
        addChild(screen)
    }
    
    func makeFeature3(){
        //this will be the screen
        hitbox = SKSpriteNode(imageNamed: "max")
        hitbox.position = CGPoint(x: sx, y: 170)
        hitbox.zPosition = 0
        hitbox.xScale = 0.27
        hitbox.yScale = 0.25
        addChild(hitbox)
    }
}



