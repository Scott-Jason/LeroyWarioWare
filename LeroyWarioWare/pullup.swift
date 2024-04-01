//
//  pullup.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/31/24.
//

import SpriteKit
import GameplayKit

class pullup: SKScene {
    
    var lock2 = false
    var up = false
    var lock = false
    var num = 0
    var reps = 0
 
    //Music
    
    let err = SKAction.playSoundFileNamed("err", waitForCompletion: false)
    let woo = SKAction.playSoundFileNamed("woo", waitForCompletion: false)
    let sound = SKAction.playSoundFileNamed("jasonBG", waitForCompletion: false)
    let jasonNO = SKAction.playSoundFileNamed("jasonNO", waitForCompletion: false)
    let jasonSweet = SKAction.playSoundFileNamed("jasonSweet", waitForCompletion: false)
    
    //Timer
    var gameT = 0
    var done = false
    var random = 5
    var random2 = 3
    
   
    
    //SpriteNodes
    var hitScreen = false
   // var jackTexture: [SKTexture] = []
    var background = SKSpriteNode()
    var asset2 = SKSpriteNode()

 
    //Labels
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label1 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label2 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")

  
    //Textures & Actions
    

    override func sceneDidLoad(){
        up = false
        remainingTime = 3.8
        totalTime = 3.8
        makeBackground()
      //  jason.pause()
        makeFeature()
      //  print(remainingTime)
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let current = touch.location(in: self)
        if(label.frame.contains(current)){
            print(lock)
            if(up == false && lock == false){
                reps += 1
                label.position = CGPoint(x: CGFloat(random), y: CGFloat(random2))
                lock = true
                label.text = "DOWN"
                print("UP")
                makeFeature2()
            }else if(up == true && lock == false){
                label.position = CGPoint(x: CGFloat(random), y: CGFloat(random2))
                lock = true
                label.text = "UP"
                print("Down")
                makeFeature3()
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        label2.text = "\(reps)"
        if(reps == 3 && lock2 == false){
            lock2 = true
            label2.run(jasonSweet)
            win = true
        }
        let maxY = Int(size.height - 100)
        let maxX = Int(size.width - 100)
        random = Int.random(in: 2...maxX)
        random2 = Int.random(in: 2...maxY)
        
        //Timer all
        gameT += 1
        if(remainingTime > 0.0){
            timerNode.xScale = remainingTime / totalTime
        }
        if(remainingTime < 0.0){
            if(win == false){
                label.run(jasonNO)
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
        let jason = SKVideoNode(fileNamed: "jstart.mov")
       // jason.pause()
        jason.position = CGPoint(x:size.width/2,y:size.height/2)
        jason.xScale = 0.7
        jason.yScale = 0.7
        jason.zPosition = 0
        //jason.isHidden = true
        addChild(jason)
        jason.run(sound)
        
        //jason.run(sound)
        
        //timer
        timerNode = SKShapeNode(rectOf: CGSize(width: remainingTime*50, height: 5))
        timerNode.position = CGPoint(x: size.width - 50, y: size.height/2)
        timerNode.zPosition = 8
        timerNode.fillColor = .green  // Initial color
        timerNode.zRotation = .pi/2
        addChild(timerNode)
        
        
        label.zPosition = 20
        label.text = "UP!"
        label.position = CGPoint(x:size.width/2 - 30,y:size.height/2 - 100)
        label.fontSize = 28
        addChild(label)
        
        
    }
    
    func makeFeature(){
        label1.text = "Give me 3!"
        label1.position = CGPoint(x: size.width/2 - 280, y:size.height - 120)
        label1.zPosition = 20
        label1.fontColor = UIColor.black
        label1.fontSize = 40
     //   label1.fontSize = 30
        addChild(label1)
        label2.text = "\(reps)"
        label2.position = CGPoint(x: size.width/2 - 280, y:size.height - 200)
        label2.zPosition = 20
        label2.fontColor = UIColor.black
        label2.fontSize = 50
     //   label1.fontSize = 30
        addChild(label2)
    }
    
    func makeFeature2(){
        num += 1
        let jup = SKVideoNode(fileNamed: "jasonupreal.mov")
       // jup.pause()
        jup.position = CGPoint(x:size.width/2,y:size.height/2)
        jup.xScale = 0.7
        jup.yScale = 0.7
      //  jup.zPosition = CGFloat(num)
        //jup.isHidden = true
        addChild(jup)
        jup.play()
        jup.run(woo){
            self.lock = false
        }
        up = true
    }
    
    func makeFeature3(){
        num += 1
        let jup = SKVideoNode(fileNamed: "jasondown.mov")
       // jup.pause()
        jup.position = CGPoint(x:size.width/2,y:size.height/2)
        jup.xScale = 0.7
        jup.yScale = 0.7
      //  jup.zPosition = CGFloat(num)
        //jup.isHidden = true
        addChild(jup)
        jup.play()
        jup.run(err){
            self.lock = false
        }
        up = false
    }
    
    
    
}


