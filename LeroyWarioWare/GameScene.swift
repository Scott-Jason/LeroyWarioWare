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
// add sound effects for win and loss

var win = false
var lives = 5
var level = -2
var timerNode = SKShapeNode()
var remainingTime: CGFloat = 2.0  // Initial remaining time
var totalTime: CGFloat = 2.0  // Total time for the timer in seconds

class GameScene: SKScene {
    
    var lastGame = false
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    
    public var gameRunTime = 0
    
    
    override func sceneDidLoad(){
        makeBackground()

        label.position = CGPoint(x: 380, y: 190)
        label.fontSize = 50
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.fontColor = UIColor.red
        if(win){
            label.fontSize = 20
            label.text = " nice! You have \(lives) lives left!!!"
        }
        if(win == false){
            lives -= 1
            label.fontSize = 20
            label.text = "awful!!! You have \(lives) lives left!!!"
        }
        print(lastGame)
        win = false
      
        addChild(label)
        level += 1
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameRunTime += 1
        //random code for first time thing
        if(oh == 0){
            oh += 1
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.4)
                view.presentScene(sammy, transition: transition)
            }
        }
        
     
        
        //next game that plays
        if(gameRunTime == 50){ //when it goes to sammy  keep it on 50
            //swaps to relevant scene
            if let view = self.view {
                var nextGame: SKScene
                switch level{
                case 0:
                    nextGame = BatSwat(size: view.bounds.size)
                case 1:
                    nextGame = pullup(size: view.bounds.size)
                case 2:
                    nextGame = Coffee(size: view.bounds.size)
                case 3:
                    nextGame = Pong(size: view.bounds.size)
                case 4:
                    nextGame = doomScroll(size: view.bounds.size)
                case 5:
                    nextGame = jackBelly(size: view.bounds.size)
                case 6:
                    nextGame = SammySoy(size: view.bounds.size)
                default:
                    nextGame = GameScene(size: view.bounds.size)
                }
                
                let transition = SKTransition.fade(withDuration: 0.4)
                view.presentScene(nextGame, transition: transition)
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
