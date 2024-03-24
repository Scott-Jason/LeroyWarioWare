//
//  GameScene.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/21/24.
//

import SpriteKit
import GameplayKit

class SammySoy: SKScene {
    
    var milk = SKSpriteNode()
    var hitScreen = false
    var drop = SKSpriteNode()
    var hitbox = SKSpriteNode()
 //   let customFont = UIFont(name: "wariofont", size: 16.0)// check if this works
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
  

    var sx = 75
    let sy = 320
    var sm = 7
    var dy = 0
    
    
    override func sceneDidLoad(){
        makeBackground();
        makeSoy();
        
        
        
        
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
        if(hitScreen == false){
            if let touch = touches.first{
                hitScreen = true
                sm = 0
                makeDrop()
                dy = sy
            }
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
        sx += sm
        dy -= 8
        if(sx > 750 || sx < 75){
            sm *= -1
            
        }
        drop.position = CGPoint(x: sx, y: dy)
        milk.position = CGPoint(x: sx, y: sy)
        
        //game goes back to menu hud
        
        if(drop.frame.intersects(hitbox.frame)){
            label.text = "Wow, Soytastic!"
            //go back to menu
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.8)
                view.presentScene(sammy, transition: transition)
            }
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
      
    }
    
    func makeDrop(){
        drop = SKSpriteNode(imageNamed:"drop")
        drop.texture?.filteringMode = .nearest
        drop.position = CGPoint(x:sx+10, y:sy)
        drop.zPosition = 5
        drop.xScale = 3
        drop.yScale = 3
        addChild(drop)
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

