//
//  GameScene.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/20/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var lives = 3
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    
    public var gameRunTime = 0
    
    override func sceneDidLoad(){
        makeBackground();
       // cycling();
        //fix this make it real
        label.position = CGPoint(x: 380, y: 190)
        label.fontSize = 50
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.fontColor = UIColor.red
        label.text = "You have \(lives) lives left!!!"
        addChild(label)

        
        
        
        
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
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameRunTime += 1
        if(gameRunTime == 50){ //when it goes to sammy  keep it on 50 
            //swaps to sammys scene
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = BatSwat(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.4)
                view.presentScene(sammy, transition: transition)
            }
        }
        
    }
    
    func makeBackground(){
        let houseTexture: [SKTexture] = [
            SKTexture(imageNamed: "house1"),
            SKTexture(imageNamed: "house2")
          ]
        
        var houseS: SKSpriteNode
       
        for texture in houseTexture {
            texture.filteringMode = .nearest
        }
        
        houseS = SKSpriteNode(texture: houseTexture[0])
        houseS.zPosition = 0
        houseS.position = CGPoint(x: 40, y: 0)
        houseS.yScale = 0.5
        houseS.xScale = 1
        addChild(houseS)
            
        //house changing pixelation on loop
        func cycling(){
            
            let cycleTime = SKAction.animate(with:houseTexture, timePerFrame: 0.2)
            let repeatForever = SKAction.repeatForever(cycleTime)
            houseS.run(repeatForever)
        }
        cycling();
    }
}
