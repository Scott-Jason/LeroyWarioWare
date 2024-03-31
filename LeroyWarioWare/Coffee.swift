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
    
    
    var gameT = 0
    
    let sound = SKAction.playSoundFileNamed("bgEffoc", waitForCompletion: false)
    let no = SKAction.playSoundFileNamed("no", waitForCompletion: false)
    let yeah = SKAction.playSoundFileNamed("Michael yeah", waitForCompletion: false)
    let laugh = SKAction.playSoundFileNamed("Theo lauigh", waitForCompletion: false)
  
   
    
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
    
    let theoTexture: [SKTexture] = [
        SKTexture(imageNamed: "Tsmile"),
        SKTexture(imageNamed: "Tsmile2")
      ]
    
    let theoCTexture: [SKTexture] = [
        SKTexture(imageNamed: "Tconfuse"),
        SKTexture(imageNamed: "Tconfuse2")
      ]
    
    let evilTexture: [SKTexture] = [
        SKTexture(imageNamed: "michael3"),
        SKTexture(imageNamed: "michael4")
      ]
    
    
    
    override func sceneDidLoad(){
        remainingTime = 3.8
        totalTime = 3.8
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
            for (index, _) in text.enumerated() {
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
            hand.run(yeah)
            label3.text = "Correct!"
            label.removeAllActions()
            let textToWrite = "He said Richter..."
            let durationPerCharacter: TimeInterval = 0.005
                // label.text = "He said Richter..."
            writeTextSlowly(text: textToWrite, duration: durationPerCharacter, label: label)
            
        }
        
        if(label2.frame.contains(current) && nextPart == true){
            let cycleTime = SKAction.animate(with:theoTexture, timePerFrame: 0.09)
            label2.text = "Perfect!"
            
            win = true
            let repeatForever = SKAction.repeatForever(cycleTime)
            hand.run(repeatForever)
            hand.run(laugh)
        }
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
        

        if(remainingTime < 0.0){
            if(win){
                label.text = "which is funny"
            }
            
            if(win == false){
                label.text = "mama mia bruh..."
                label.run(no)
            }
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.8)
                view.presentScene(sammy, transition: transition)
            }
        }
        
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
        background.run(sound)
        
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
        label2.text = "EEFFOC"
        label3.text = "EEFFOK"
        let cycleTime = SKAction.animate(with:theoCTexture, timePerFrame: 0.09)
        let repeatForever = SKAction.repeatForever(cycleTime)
        hand.run(repeatForever)
        //add theo
        
    }
}


