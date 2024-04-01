//
//  jackBelly.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/31/24.


import SpriteKit
import GameplayKit

class jackBelly: SKScene {
    
    var lock = false
    var num = 0
 
    //Music
    let sound = SKAction.playSoundFileNamed("jackBG", waitForCompletion: false)
    let pump = SKAction.playSoundFileNamed("pump", waitForCompletion: true)
    let shucks = SKAction.playSoundFileNamed("shucks", waitForCompletion: true)
    let fuck = SKAction.playSoundFileNamed("fword", waitForCompletion: true)
    
    //Timer
    var gameT = 0
    var done = false
   
    
    //SpriteNodes
    var hitScreen = false
   // var jackTexture: [SKTexture] = []
    var background = SKSpriteNode()
    var asset2 = SKSpriteNode()

 
    //Labels
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label1 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")

  
    //Textures & Actions
    var jackTexture: [SKTexture] = [
        SKTexture(imageNamed: "j1"),
        SKTexture(imageNamed: "j2"),
        SKTexture(imageNamed: "j3"),
        SKTexture(imageNamed: "j4"),
        SKTexture(imageNamed: "j5"),
        SKTexture(imageNamed: "j6"),
        SKTexture(imageNamed: "j7"),
        SKTexture(imageNamed: "j8"),
        SKTexture(imageNamed: "j9")
      ]
    

    override func sceneDidLoad(){
        remainingTime = 2.0
        totalTime = 2.0
        makeBackground()
        makeFeature()
      //  print(remainingTime)
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if(done == false && num < 8 ){
              //  lock = true
                num += 1
                print(num)
                label1.run(pump)
                
            }
            if(num == 8){
                win = true
                label1.text = "It's a Boy!"
                label1.run(shucks)
                label1.position = CGPoint(x:size.width/2, y:size.height/2)
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       // background.texture = SKSpriteNode(texture: jackTexture[num])
        //updates timer
        background.texture = jackTexture[num]
        
        
        
        gameT += 1
        if(remainingTime > 0.0){
            timerNode.xScale = remainingTime / totalTime
        }
        if(remainingTime < 0.0){
            if(win == false){
                label1.run(fuck)
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
    }
    
    func makeBackground(){
        background = SKSpriteNode(texture: jackTexture[0])
        background.position = CGPoint(x: size.width/2, y: size.height/2) //where its at
        background.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        background.xScale = 0.6
        background.yScale = 0.6
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
        label1.text = "Expand!"
        label1.position = CGPoint(x: size.width/2, y:size.height - 70)
        label1.zPosition = 3
        label1.fontSize = 40
     //   label1.fontSize = 30
        addChild(label1)
    }
    
    func makeFeature2(){
        //this will be hand that scrolls
       
    }
    
}


