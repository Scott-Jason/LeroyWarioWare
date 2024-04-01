//
//  template.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/31/24.


import SpriteKit
import GameplayKit

class template: SKScene {
    
    var lock = false
 
    
    //Music
    let sound = SKAction.playSoundFileNamed("bgEffoc", waitForCompletion: false)
    
    //Timer
    var gameT = 0
   
    
    //SpriteNodes
    var hitScreen = false
    var asset = SKSpriteNode()
    var asset2 = SKSpriteNode()
    var asset3 = SKSpriteNode()
    var hitbox = SKSpriteNode()
 
    //Labels
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label1 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")

  
 
    
    
    //Textures & Actions
    
    let shake = SKAction.sequence([
        SKAction.moveBy(x: -10, y: 5, duration: 0.13),
        SKAction.moveBy(x: 10, y: -5, duration: 0.09),
        SKAction.moveBy(x: -10, y: 5, duration: 0.14),
        SKAction.moveBy(x: 10, y: -5, duration: 0.09),
        SKAction.moveBy(x: -3, y: 8 , duration: 0.08),
        SKAction.moveBy(x: 3, y: -8 , duration: 0.11),
        SKAction.moveBy(x: -12, y: -5  , duration:0.1 ),
        SKAction.moveBy(x: 12, y:  5, duration: 0.06)
                
            ])
    
    
    
    let michaelTexture: [SKTexture] = [
        SKTexture(imageNamed: "michael1"),
        SKTexture(imageNamed: "michael2")
      ]
    

    
    
    override func sceneDidLoad(){
        makeBackground()
        makeFeature()
        makeFeature2()
      
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let current = touch.location(in: self)
        

      
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        
        //updates timer
        gameT += 1
        if(remainingTime > 0.0){
            timerNode.xScale = remainingTime / totalTime
        }
        
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
    
    func makeFeature(){
        //this will be hand that scrolls
        label1.text = "Maggot Lord"
    //    label1.position = CGPoint(x: sx, y: sy + 40)
        label1.zPosition = 3
        label1.fontSize = 30
        addChild(label1)
    }
    
    func makeFeature2(){
        //this will be hand that scrolls
       
    }
    

  

}


