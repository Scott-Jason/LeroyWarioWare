//
//  pong.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/26/24.
// yafer pong minigame WIP



import SpriteKit
import GameplayKit

class Pong: SKScene {
    
    var lock = false
    var whichScreen = 0
    var nextPart = false
    
    
    var gameT = 0
    //Music
    let sound = SKAction.playSoundFileNamed("bgEffoc", waitForCompletion: false)
    //Timer
    var timerNode = SKShapeNode()
    var remainingTime: CGFloat = 3.8  // Initial remaining time (does it like 2.0 = 4 sec for some reaosn)
    let totalTime: CGFloat = 3.8 // Total time for the timer in seconds
    
    //SpriteNodes
    var arrow = SKSpriteNode()
    var screen2 = SKSpriteNode()
    var screen3 = SKSpriteNode()
    var hitScreen = false
    var hand = SKSpriteNode()
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
        makeFeature3()
        makeFeature4()
       
        let shakeAction = SKAction.repeatForever(shake)
        label.run(shakeAction)
        label.position = CGPoint(x: sx-30, y:280)
        label.text = "Michael Kim isnt..."
        label.zPosition = 2
        addChild(label)
  
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let current = touch.location(in: self)
        
        
        
        
      
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        
         //updates timer
        gameT += 1
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
    
    func makeFeature(){
        //this will be hand that scrolls
        label1.text = "Maggot Lord"
        label1.position = CGPoint(x: sx, y: sy + 40)
        label1.zPosition = 3
        label1.fontSize = 30
        addChild(label1)
    }
    
    func makeFeature2(){
        //this will be hand that scrolls
        label2.text = "Booger Prince"
        label2.position = CGPoint(x: sx, y: sy - 20 )
        label2.zPosition = 4
        label2.fontSize = 30
        addChild(label2)
    }
    
    func makeFeature3(){
        //this will be hand that scrolls
        label3.text = "Bus Lover"
        label3.position = CGPoint(x: sx, y: sy - 80 )
        label3.zPosition = 4
        label3.fontSize = 30
        addChild(label3)
    }
    
    func makeFeature4(){
        //this will be the michael face
        hand = SKSpriteNode(texture: michaelTexture[0])
        hand.position = CGPoint(x: 575, y: 200)
        hand.zPosition = 1
        hand.xScale = 0.5
        hand.yScale = 0.5
        let cycleTime = SKAction.animate(with:michaelTexture, timePerFrame: 0.2)
        let repeatForever = SKAction.repeatForever(cycleTime)
        hand.run(repeatForever)
        addChild(hand)
    }
    
    func nextPartFunc(){
        label.text = "Coffee backwards is.."
        let shakeAction = SKAction.repeatForever(shake)
        label.run(shakeAction)
        label.position = CGPoint(x: sx, y:280)
        label1.text = "FEEOC"
        label2.text = "EEFOC"
        label3.text = "EEFOK"
    //    let cycleTime = SKAction.animate(with:theoCTexture, timePerFrame: 0.09)
     //   let repeatForever = SKAction.repeatForever(cycleTime)
       // hand.run(repeatForever)
        //add theo
        
    }
}


