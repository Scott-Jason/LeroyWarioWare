//
//  GameScene.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/21/24.
//

import SpriteKit
import GameplayKit

class SammySoy: SKScene {
    
    
    let sound = SKAction.playSoundFileNamed("bgSammy", waitForCompletion: false)
    let sammyD = SKAction.playSoundFileNamed("sammy", waitForCompletion: false)
    var milk = SKSpriteNode()
    var hitScreen = false
    var drop = SKSpriteNode()
    var hitbox = SKSpriteNode()
 //   let customFont = UIFont(name: "wariofont", size: 16.0)// check if this works
    var label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    
    var gameT = 0
    

    var sx = 75
    let sy = 320
    var sm = 7
    var dy = 0
    
    
    override func sceneDidLoad(){
        remainingTime = 2.0
        totalTime = 2.0
        makeBackground();
        makeSoy();
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(hitScreen == false){
            if let touch = touches.first{
                hitScreen = true
                sm = 0
                makeDrop()
                dy = sy
            }
        }
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        gameT += 1
        
        timerNode.xScale = remainingTime / totalTime
        if(gameT % 10 == 0){
            remainingTime -= 0.1
        }
        
        if(remainingTime < 0.0){
            if(win == false){
                label.text = "its over"
            }
            if(win == true){
                label.text = "goodjob!"
            }
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.8)
                view.presentScene(sammy, transition: transition)
            }
        }
      
        
        // Called before each frame is rendered
        sx += sm
        dy -= 8
        if(sx > 500 || sx < 75){
            sm *= -1
            
        }
        drop.position = CGPoint(x: sx, y: dy)
        milk.position = CGPoint(x: sx, y: sy)
        
        //game goes back to menu hud
        
        if(drop.frame.intersects(hitbox.frame)){
            label.text = "Wow, Soytastic!"
            win = true
            label.run(sammyD)
            //go back to menu

        }
        
        
    }
    
    func makeBackground(){
        let black = SKSpriteNode(imageNamed: "black")
        black.position = CGPoint(x: 430, y: 197) //where its at
        black.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        black.xScale = 3.9
        black.yScale = 1.95
        addChild(black)
        let face = SKSpriteNode(imageNamed: "face")
        face.position = CGPoint(x: 385,y: 50)
        face.xScale = -0.4
        face.yScale = -1
        face.zRotation = CGFloat.pi / 2
        face.zPosition = 3
        addChild(face)
        hitbox = SKSpriteNode(imageNamed: "hitbox")
        hitbox.position = CGPoint(x:180,y:70)
        hitbox.xScale = 0.1
        hitbox.yScale = 0.1
        hitbox.zPosition = 0 // behind everything
        addChild(hitbox)
        label.position = CGPoint(x: 380, y: 190)
        label.fontSize = 50
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.text = "Squirt!"
        addChild(label)
        black.run(sound)
        
        //timer
        timerNode = SKShapeNode(rectOf: CGSize(width: remainingTime*50, height: 5))
        timerNode.position = CGPoint(x: size.width - 50, y: size.height/2)
        timerNode.zPosition = 8
        timerNode.fillColor = .green  // Initial color
        timerNode.zRotation = .pi/2
        addChild(timerNode)
      
    }
    
    func makeDrop(){
        drop = SKSpriteNode(imageNamed:"drop")
        drop.texture?.filteringMode = .nearest
        drop.position = CGPoint(x:sx+10, y:sy)
        drop.zPosition = 2
        drop.xScale = 3
        drop.yScale = 3
        addChild(drop)
        var sound = SKAction.playSoundFileNamed("drop", waitForCompletion: false)
      //  sound = SKAction.changeVolume(to: 1.0, duration: 2)
        drop.run(sound)
    }
    
    func makeSoy(){
        milk = SKSpriteNode(imageNamed: "soy")
        milk.texture?.filteringMode = .nearest
        milk.position = CGPoint(x: sx, y: sy)
        milk.zPosition = 1
        milk.xScale = 0.15
        milk.yScale = -0.15
        addChild(milk)
        
        
        
    }
}

