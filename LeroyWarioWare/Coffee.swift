//
//  COFFEE.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/25/24.
// gonna try to set this file up as more of a generic blueprint for other microgames
// add stuff that happens if you click the wrong label, also can make panel 2 eefoc if want



import SpriteKit
import GameplayKit

class Coffee: SKScene {
    
    var lock = false
    var whichScreen = 0
    var nextPart = false
    
    
    //some are unused thats ok
    var arrow = SKSpriteNode()
    var screen2 = SKSpriteNode()
    var screen3 = SKSpriteNode()
    var hitScreen = false
    var hand = SKSpriteNode()
    var hitbox = SKSpriteNode()
 
    //wario labels
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label1 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label2 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label3 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
  

    var sx = 380 - 100
    var sy = 170
    var sm = 7
    var dy = 0
    
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
    
    let evilTexture: [SKTexture] = [
        SKTexture(imageNamed: "michael3"),
        SKTexture(imageNamed: "michael4")
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
        
        //func for writing text slowly, can put outside this func if i want to use it more
        func writeTextSlowly(text: String, duration: TimeInterval, label: SKLabelNode) {
            var actions: [SKAction] = []
            for (index, character) in text.enumerated() {
                let wait = SKAction.wait(forDuration: duration * TimeInterval(index))
                let updateText = SKAction.run {
                    label.text = String(text.prefix(index + 1))
                }
                actions.append(contentsOf: [wait, updateText])
            }
            label.run(SKAction.sequence(actions)){
                self.nextPart = true
            }
        }
        
        //collision with touch and label frame
        
        if(label3.frame.contains(current) && nextPart == false){
            
            let cycleTime = SKAction.animate(with:evilTexture, timePerFrame: 0.09)
            let repeatForever = SKAction.repeatForever(cycleTime)
            hand.run(repeatForever)
            label3.text = "Correct!"
            label.removeAllActions()
            let textToWrite = "He said Richter..."
            let durationPerCharacter: TimeInterval = 0.02
                // label.text = "He said Richter..."
            writeTextSlowly(text: textToWrite, duration: durationPerCharacter, label: label)
            
        }
        
        if(label2.frame.contains(current) && nextPart == true){
            //soiething
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        //dont need anything for this one i think
        if(lock == false && nextPart == true){
            lock = true
            nextPartFunc()
        }
        
    }
    
    
    func makeBackground(){
        let background = SKSpriteNode(imageNamed: "black")
        background.position = CGPoint(x: 400, y: 200) //where its at
        background.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        background.xScale = 5
        background.yScale = 4
        addChild(background)
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
        label2.text = "Booger Dick"
        label2.position = CGPoint(x: sx, y: sy - 20 )
        label2.zPosition = 4
        label2.fontSize = 30
        addChild(label2)
    }
    
    func makeFeature3(){
        //this will be hand that scrolls
        label3.text = "Human"
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
        label.text = "Coffee spelled backwards is.."
        label1.text = "FEEOC"
        label2.text = "EEFOK"
        label3.text = "EEFOC"
    }
}


