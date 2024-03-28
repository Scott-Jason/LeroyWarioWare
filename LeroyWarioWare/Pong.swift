//
//  pong.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/26/24.
// yafer pong minigame WIP

import SpriteKit
import GameplayKit

class Pong: SKScene {
    
    var lock = 0
    //random int when he throws vs not game delay between 2 videos
    var random = Int.random(in: 1...5)
 
    
    //Music
    let sound = SKAction.playSoundFileNamed("bgEffoc", waitForCompletion: false)
    //Timer
    var gameT = 0
    
    //SpriteNodes
    
    let yafer = SKVideoNode(fileNamed: "sample.mov")
    
    //video of yafer throwing up a pong ball
    
    var hitScreen = false
    var ball = SKSpriteNode()
    var paddle = SKSpriteNode()
    var asset3 = SKSpriteNode()
    var hitbox = SKSpriteNode()
 
    //Labels
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label1 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label2 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label3 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
  
    //Movement Variables
    var sx = 380 - 100
    var sy = 170
    var sm = 7
    var dy = 0
    
    
    
    
    //Textures & Actions
    
    // how to make these happen at the same time
    
    

    
    
    // 3 panels of a transparent hand hitting pong back
    let swingTexture: [SKTexture] = [
        SKTexture(imageNamed: "michael1"),
        SKTexture(imageNamed: "michael2")
      ]
    

    
    
    override func sceneDidLoad(){
        remainingTime = 3.8
        totalTime = 3.8
        makeBackground()
        makeFeature()
        makeFeature2()
      //  makeFeature3()
        
        label.text = "Hi there \(random)"
        label.position = CGPoint(x: 200, y:80)
        label.zPosition = 8
        addChild(label)
        
  
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let current = touch.location(in: self)
        

    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        
        //updates timer
        gameT += 1
        
        if(gameT > random * 30 && lock == 0){
            lock += 1
            label.text = "changed now"
            makeFeature3()
        }
        
        if(gameT > (random * 30) + 30){
            ball.removeAllActions()
        }
        
        
        
        
        timerNode.xScale = remainingTime / totalTime
        if(gameT % 10 == 0){
            remainingTime -= 0.1
        }
        
    }
    
    
    func makeBackground(){
        let background = SKSpriteNode(imageNamed: "black")
        background.position = CGPoint(x: 400, y: 200) //where its at
        background.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        background.xScale = 5
        background.yScale = 4
        addChild(background)
        background.run(sound) //playing music
        
        //timer
        timerNode = SKShapeNode(rectOf: CGSize(width: remainingTime*50, height: 5))
        timerNode.position = CGPoint(x: size.width - 50, y: size.height/2)
        timerNode.zPosition = 8
        timerNode.fillColor = .green  // Initial color
        timerNode.zRotation = .pi/2
        addChild(timerNode)
    }
    
    
    func makeFeature(){ //make pong paddle
        paddle = SKSpriteNode(texture: swingTexture[0])
        paddle.position = CGPoint(x: 400, y: 95)
        paddle.zPosition = 1
        paddle.xScale = 0.7
        paddle.yScale = 0.35
        addChild(paddle)
    }
    
    func makeFeature2(){ //swing
        let swing = SKAction.animate(with:swingTexture, timePerFrame: 0.08)
        paddle.run(swing)
      
    }
    
    func makeFeature3(){ //pong ball throw
        ball = SKSpriteNode(imageNamed: "pball")
        ball.position = CGPoint(x:size.width / 2 , y: size.height / 2)
        ball.xScale = 0.2
        ball.yScale = 0.2
        ball.zPosition = 4
        addChild(ball)
        
        let action1 = SKAction.moveBy(x: 0, y: -150, duration: 1.0)
        let action2 = SKAction.rotate(byAngle: .pi, duration: 0.3)
        let ac = SKAction.repeatForever(action2)
        let big = SKAction.scale(by: 4, duration: 0.7)
        
        let zoom = SKAction.group([action1, ac, big])
        ball.run(zoom)
        
            
        
    }
    

}


