//
//  pong.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/26/24.
// Add the audio files to yaf laugh and yafboo

import SpriteKit
import GameplayKit

class Pong: SKScene {
    
    var canHit = false
    var lock = 0
    //random int when he throws vs not game delay between 2 videos
    var random = Int.random(in: 1...5)
 
    
    //Music
    
    
    let sound = SKAction.playSoundFileNamed("yafPong", waitForCompletion: false)
    let yafLaugh = SKAction.playSoundFileNamed("yafLaugh", waitForCompletion: false)
    let yafBoo = SKAction.playSoundFileNamed("yafBoo", waitForCompletion: false)
    //Timer
    var gameT = 0
    
    //SpriteNodes
    
    //let yafer = SKVideoNode(fileNamed: "yaf1.mov")
    
    //video of yafer throwing up a pong ball
    
    var hitScreen = true
    var ball = SKSpriteNode()
    var paddle = SKSpriteNode()
    var yaf = SKSpriteNode()
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
        SKTexture(imageNamed: "pong11"),
        SKTexture(imageNamed: "pong22"),
        SKTexture(imageNamed: "pong33"),
        SKTexture(imageNamed: "pong22"),
        SKTexture(imageNamed: "pong11")
        
      ]
    

    override func sceneDidLoad(){
        remainingTime = 3.8
        totalTime = 3.8
        makeBackground()
        makeFeature()
     //  makeFeature2()
      //  makeFeature3()
        
        label.text = "Get Ready!"
        label.position = CGPoint(x: 150, y:80)
        label.zPosition = 8
        addChild(label)
        
  
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if(hitScreen && canHit){
                hitScreen = false
                win = true
                makeFeature2()
                makeFeature5()
            }
            if(hitScreen){
                hitScreen = false
                makeFeature2()
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //updates timer
        gameT += 1
        
        if(gameT > random * 30 && lock == 0){
            lock += 1
           // label.text = "changed now"
            makeFeature3()
            makeFeature4()
           // canHit = true
        }
        
        
        if(gameT > (random * 30) + 30){
            //ball.removeAllActions()
        }
        if(gameT > (random * 30) && win == false){
            label.text = "Hit!"
            canHit = true
        }
        if(gameT > (random * 30) + 60 && win == false){
            label.text = "Missed.."
            label.run(yafBoo)
            yaf = SKSpriteNode(imageNamed:"badjob")
            yaf.position = CGPoint(x: 450, y: 150)
            yaf.xScale = 0.3
            yaf.yScale = 0.16
            yaf.zPosition = 1
            addChild(yaf)
            canHit = false
        }
        
        if(remainingTime > 0.0){
            timerNode.xScale = remainingTime / totalTime
        }
        if(remainingTime < 0.0){
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
        
    }
    
    func makeBackground(){
        let yaf1 = SKVideoNode(fileNamed: "pixYafer.mov")
        yaf1.position = CGPoint(x:410,y:150)
        yaf1.xScale = 0.7
        yaf1.yScale = 0.7
        yaf1.zPosition = 0
        addChild(yaf1)
        yaf1.play()
        yaf1.run(sound)
        
        
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
        paddle.zPosition = 2
        paddle.xScale = 0.2
        paddle.yScale = 0.2
        addChild(paddle)
    }
    
    func makeFeature2(){ //swing
        let swing = SKAction.animate(with:swingTexture, timePerFrame: 0.11)
        paddle.run(swing){
            self.hitScreen = true
        }
    }
    
    func makeFeature3(){ //pong ball throw
        let yaf2 = SKVideoNode(fileNamed: "pixYaferhit.mov")
        yaf2.position = CGPoint(x:410,y:150)
        yaf2.xScale = 0.7
        yaf2.yScale = 0.7
        yaf2.zPosition = 0
        addChild(yaf2)
        yaf2.play()
    }
    
    func makeFeature4(){
        ball = SKSpriteNode(imageNamed: "pball")
        ball.position = CGPoint(x: 330, y: 265)
        ball.xScale = 0.1
        ball.yScale = 0.1
        ball.zPosition = 1
        addChild(ball)
        
        let action = SKAction.moveBy(x: -30, y: 0, duration: 8.0)
        let action0 = SKAction.moveBy(x: 30, y:0 , duration: 0.2)
        let action1 = SKAction.moveBy(x: 0, y: -150, duration: 1.0)
        let action2 = SKAction.rotate(byAngle: .pi, duration: 0.3)
        let ac = SKAction.repeatForever(action2)
        let big = SKAction.scale(by: 4, duration: 0.7)
        
        let zoom = SKAction.group([action1, ac, big])
        ball.run(action)
        ball.run(action0)
        ball.run(zoom)
    }
    
    func makeFeature5(){ //hit ball back
        let action1 = SKAction.moveBy(x: 0, y: 160, duration: 1.0)
        let action2 = SKAction.rotate(byAngle: .pi, duration: 0.3)
        let ac = SKAction.repeatForever(action2)
        let small = SKAction.scale(by: 0.2, duration: 0.7)
        let back = SKAction.group([action1, ac, small])
        ball.run(back)
        hitScreen = false
        yaf = SKSpriteNode(imageNamed:"goodjob")
        yaf.position = CGPoint(x: 450, y: 150)
        yaf.xScale = 0.3
        yaf.yScale = 0.16
        yaf.zPosition = 1
        addChild(yaf)
        label.text = "Great!"
        label.run(yafLaugh)
        
    }
    

}


