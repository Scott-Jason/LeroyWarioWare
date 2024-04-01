//
//  BatSwat.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/22/24.
//

import SpriteKit
import GameplayKit

class BatSwat: SKScene {
    
    var gameT = 0
    
    let sound = SKAction.playSoundFileNamed("batBG", waitForCompletion: false)
    let sorry = SKAction.playSoundFileNamed("sorry", waitForCompletion: false)
    //add sorry effect
    
    var gameTime = 0
    var bat = SKSpriteNode()
    var x = Int.random(in: 50...350)
    var y = Int.random(in: 30...200)
    var bx = 14
    var by = 14
    
    var bat2 = SKSpriteNode()
    var racket = SKSpriteNode()
    
    let batTex: [SKTexture] = [
        SKTexture(imageNamed: "bat1"),
        SKTexture(imageNamed: "bat2"),
        SKTexture(imageNamed: "bat3")
      ]
    
    
    var hitScreen = true
    
    let swingTex: [SKTexture] = [
        SKTexture(imageNamed: "tennis1"),
        SKTexture(imageNamed: "tennis2"),
        SKTexture(imageNamed: "tennis3"),
        SKTexture(imageNamed: "tennis2"),
        SKTexture(imageNamed: "tennis1")
      ]
    
    
    var hitbox = SKSpriteNode()
 //   let customFont = UIFont(name: "wariofont", size: 16.0)// check if this works
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
  

   
    
    
    override func sceneDidLoad(){
        remainingTime = 17.0
        totalTime = 17.0
        makeBackground()
        makeRacket()
        //makeSwing()
        spawnBat()
      
        
        
        
        
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
        if let touch = touches.first{
            if(hitScreen){
                hitScreen = false
                makeSwing()
            }
            
                //stuff that happens if you hit
        }
        
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //Timercode
        gameTime += 1
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
        
        
        
        //make a random int that if gameTime == int thats what goes in 112
        if(gameTime % 75 == 0){
            let targetPosition = CGPoint(x: 400, y: 115) // Example target position
            let moveToTargetAction = SKAction.move(to: targetPosition, duration: 0.4)
            bat.run(moveToTargetAction){
                self.x = Int.random(in:400...405)
                self.y = Int.random(in: 115...120)
            }
            
           
        }
        
        //game goes back to menu hud
        
        if(x < 30 || x > 800){
            bx *= -1
            bat.xScale *= -1
        }
        if(y < 0 || y > 400){
            by *= -1
            
        }
       
        x += bx
        y += by
       // print(x)
        //print(y)
    
        bat.position = CGPoint(x:x, y:y)
     
        
        
    }
    
    func makeBackground(){
        let grid = SKSpriteNode(imageNamed: "grid")
        grid.position = CGPoint(x: 430, y: 197) //where its at
        grid.zPosition = 1 //kind of like layers in photoshop 0 furthest back 100000 foreground
        grid.xScale = 0.73
        grid.yScale = 0.33
        addChild(grid)
        grid.run(sound)
       
        // add hitbox to racket
        //make bat add sepearte hitbox to bat
        //collision
       // makeswing on touches.
        hitbox = SKSpriteNode(imageNamed: "hitbox")
        hitbox.position = CGPoint(x:405,y:115)
        hitbox.xScale = 0.18
        hitbox.yScale = 0.14
        hitbox.zPosition = 0 // behind everything
        addChild(hitbox)
        label.position = CGPoint(x: 380, y: 190)
        label.fontSize = 50
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.fontColor = UIColor.red
        label.text = "Swing!"
        addChild(label)
      
        //timer
        timerNode = SKShapeNode(rectOf: CGSize(width: remainingTime*50, height: 5))
        timerNode.position = CGPoint(x: size.width - 50, y: size.height/2)
        timerNode.zPosition = 8
        timerNode.fillColor = .green  // Initial color
        timerNode.zRotation = .pi/2
        addChild(timerNode)
    }
    
    func makeSwing(){
        let swing = SKAction.animate(with:swingTex, timePerFrame: 0.08)
        if(bat.frame.intersects(hitbox.frame)){
            label.text = "What has Michael done.."
            label.run(sorry)
            bat.removeFromParent()
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = doomScroll(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.8)
                view.presentScene(sammy, transition: transition)
            }
        }
        racket.run(swing){
            self.hitScreen = true
        }
    }
    
    
    func spawnBat(){
        bat = SKSpriteNode(texture: batTex[0])
        bat.zPosition = 10
        bat.position = CGPoint(x: x, y: y)
        bat.yScale = 0.25
        bat.xScale = -0.25
        let cycleTime = SKAction.animate(with:batTex, timePerFrame: 0.08)
        let repeatForever = SKAction.repeatForever(cycleTime)
        bat.run(repeatForever)
        addChild(bat)
    }
    func spawnBat2(){
        
        
    }
    
    
    
    func makeRacket(){
        racket = SKSpriteNode(texture: swingTex[0])
        racket.texture?.filteringMode = .nearest
        racket.position = CGPoint(x: 400, y: 95)
        racket.zPosition = 3
        racket.xScale = 0.7
        racket.yScale = 0.35
        addChild(racket)
        
        
        
    }
}

