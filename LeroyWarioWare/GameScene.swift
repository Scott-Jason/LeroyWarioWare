//
//  GameScene.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/20/24.
//

import SpriteKit
import GameplayKit

var oh = 0
//when return back here play something based off win or lose
var win = false
var lives = 3
var timerNode = SKShapeNode()
var remainingTime: CGFloat = 2.0  // Initial remaining time
var totalTime: CGFloat = 2.0  // Total time for the timer in seconds

class GameScene: SKScene {
    
    
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    
    public var gameRunTime = 0
    
    override func sceneDidLoad(){
        makeBackground()
       // cycling();
        //fix this make it real
        label.position = CGPoint(x: 380, y: 190)
        label.fontSize = 50
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.fontColor = UIColor.red
        if(win){
            label.text = " nice! You have \(lives) lives left!!!"
        }
        if(win == false){
            label.text = "awful!!! You have \(lives) lives left!!!"
        }
        
        win = false
      //  label.text = "You have \(lives) lives left!!!"
        addChild(label)
        //makeBackground();
    }
    


    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameRunTime += 1
        if(oh == 0){
            oh += 1
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.4)
                view.presentScene(sammy, transition: transition)
            }
        }
        
        if(win == false && oh != 0){
            label.text = "So close! \(lives) left!"
            // genereate different effects if win or lose then update sep varaible to get to different minigames
        }
        
        if(gameRunTime == 4){ //when it goes to sammy  keep it on 50
            //swaps to sammys scene
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = jackBelly(size: view.bounds.size)
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
       
      
        
        houseS = SKSpriteNode(texture: houseTexture[0])
        houseS.zPosition = 1
        houseS.position = CGPoint(x: 400, y: 186)
        houseS.yScale = 0.6
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
